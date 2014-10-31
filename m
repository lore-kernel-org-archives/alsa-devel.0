From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH v3 1/2] thinkpad-acpi: Try to use full software mute
 control
Date: Fri, 31 Oct 2014 21:07:00 -0200
Message-ID: <20141031230700.GA11745@khazad-dum.debian.net>
References: <cover.1413590510.git.luto@amacapital.net>
 <378856925c5ceecd27a6490585ee60362a714ef6.1413590510.git.luto@amacapital.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <378856925c5ceecd27a6490585ee60362a714ef6.1413590510.git.luto@amacapital.net>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Andy Lutomirski <luto@amacapital.net>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, ibm-acpi-devel@lists.sourceforge.net, Len Brown <len.brown@intel.com>, David Henningsson <david.henningsson@canonical.com>, Takashi Iwai <tiwai@suse.de>, Grant Diffey <gdiffey@gmail.com>, ALSA development <alsa-devel@alsa-project.org>, platform-driver-x86@vger.kernel.org, Andy Lutomirski <luto@MIT.EDU>
List-Id: alsa-devel@alsa-project.org

On Fri, 17 Oct 2014, Andy Lutomirski wrote:
> ThinkPads have hardware volume controls and three buttons to control
> them.  (These are separate from the standard mixer.)  By default,
> the buttons are:
> 
>  - Mute: Mutes the hardware volume control and, on some models,
>    generates KEY_MUTE.
> 
>  - Up: Unmutes, generates KEY_VOLUMEUP, and increases volume if
>    applicable.  (Newer thinkpads only have hardware mute/unmute.)
> 
>  - Down: Unmutes, generates KEY_VOLUMEDOWN, and decreases volume
>    if applicable.
> 
> This behavior is unfortunate, since modern userspace will also
> handle the hotkeys and change the other mixer.  If the software
> mixer is muted and the hardware mixer is unmuted and you push mute,
> hilarity ensues as they both switch state.
> 
> Rather than adding a lot of complex ALSA integration to fix this,
> just disable the special ThinkPad volume controls when possible.
> This turns the mute and volume buttons into regular buttons, and
> standard software controls will work as expected.
> 
> ALSA already knows about the mute light on models with a mute light,
> so everything should just work.
> 
> This should also allow us to remove _OSI(Linux) for all ThinkPads.
> 
> For future reference: It turns out that we can ask ACPI for one of
> three behaviors directly on very new models.  They are "latch" (the
> default), "none" (no automatic control), and "toggle" (mute unmutes
> when muted).  All of the modes besides "none" seem to be a bit
> buggy, though, and there doesn't seem to be a consistent way to get
> any notification when the HW mute state is changed.
> 
> Signed-off-by: Andy Lutomirski <luto@mit.edu>

Acked-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

> ---
>  drivers/platform/x86/thinkpad_acpi.c | 116 ++++++++++++++++++++++++++++++++---
>  1 file changed, 106 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
> index 3bbc6eb60de5..cfc317f2de23 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -6559,6 +6559,17 @@ static struct ibm_struct brightness_driver_data = {
>   * bits 3-0 (volume).  Other bits in NVRAM may have other functions,
>   * such as bit 7 which is used to detect repeated presses of MUTE,
>   * and we leave them unchanged.
> + *
> + * On newer Lenovo ThinkPads, the EC can automatically change the volume
> + * in response to user input.  Unfortunately, this rarely works well.
> + * The laptop changes the state of its internal MUTE gate and, on some
> + * models, sends KEY_MUTE, causing any user code that responds to the
> + * mute button to get confused.  The hardware MUTE gate is also
> + * unnecessary, since user code can handle the mute button without
> + * kernel or EC help.
> + *
> + * To avoid confusing userspace, we simply disable all EC-based mute
> + * and volume controls when possible.
>   */
>  
>  #ifdef CONFIG_THINKPAD_ACPI_ALSA_SUPPORT
> @@ -6613,11 +6624,21 @@ enum tpacpi_volume_capabilities {
>  	TPACPI_VOL_CAP_MAX
>  };
>  
> +enum tpacpi_mute_btn_mode {
> +	TP_EC_MUTE_BTN_LATCH  = 0,	/* Mute mutes; up/down unmutes */
> +	/* We don't know what mode 1 is. */
> +	TP_EC_MUTE_BTN_NONE   = 2,	/* Mute and up/down are just keys */
> +	TP_EC_MUTE_BTN_TOGGLE = 3,	/* Mute toggles; up/down unmutes */
> +};
> +
>  static enum tpacpi_volume_access_mode volume_mode =
>  	TPACPI_VOL_MODE_MAX;
>  
>  static enum tpacpi_volume_capabilities volume_capabilities;
>  static bool volume_control_allowed;
> +static bool software_mute_requested = true;
> +static bool software_mute_active;
> +static int software_mute_orig_mode;
>  
>  /*
>   * Used to syncronize writers to TP_EC_AUDIO and
> @@ -6635,6 +6656,8 @@ static void tpacpi_volume_checkpoint_nvram(void)
>  		return;
>  	if (!volume_control_allowed)
>  		return;
> +	if (software_mute_active)
> +		return;
>  
>  	vdbg_printk(TPACPI_DBG_MIXER,
>  		"trying to checkpoint mixer state to NVRAM...\n");
> @@ -6696,6 +6719,12 @@ static int volume_set_status_ec(const u8 status)
>  
>  	dbg_printk(TPACPI_DBG_MIXER, "set EC mixer to 0x%02x\n", status);
>  
> +	/*
> +	 * On X200s, and possibly on others, it can take a while for
> +	 * reads to become correct.
> +	 */
> +	msleep(1);
> +
>  	return 0;
>  }
>  
> @@ -6778,6 +6807,57 @@ unlock:
>  	return rc;
>  }
>  
> +static int volume_set_software_mute(bool startup)
> +{
> +	int result;
> +
> +	if (!tpacpi_is_lenovo())
> +		return -ENODEV;
> +
> +	if (startup) {
> +		if (!acpi_evalf(ec_handle, &software_mute_orig_mode,
> +				"HAUM", "qd"))
> +			return -EIO;
> +
> +		dbg_printk(TPACPI_DBG_INIT | TPACPI_DBG_MIXER,
> +			    "Initial HAUM setting was %d\n",
> +			    software_mute_orig_mode);
> +	}
> +
> +	if (!acpi_evalf(ec_handle, &result, "SAUM", "qdd",
> +			(int)TP_EC_MUTE_BTN_NONE))
> +		return -EIO;
> +
> +	if (result != TP_EC_MUTE_BTN_NONE)
> +		pr_warn("Unexpected SAUM result %d\n",
> +			result);
> +
> +	/*
> +	 * In software mute mode, the standard codec controls take
> +	 * precendence, so we unmute the ThinkPad HW switch at
> +	 * startup.  Just on case there are SAUM-capable ThinkPads
> +	 * with level controls, set max HW volume as well.
> +	 */
> +	if (tp_features.mixer_no_level_control)
> +		result = volume_set_mute(false);
> +	else
> +		result = volume_set_status(TP_EC_VOLUME_MAX);
> +
> +	if (result != 0)
> +		pr_warn("Failed to unmute the HW mute switch\n");
> +
> +	return 0;
> +}
> +
> +static void volume_exit_software_mute(void)
> +{
> +	int r;
> +
> +	if (!acpi_evalf(ec_handle, &r, "SAUM", "qdd", software_mute_orig_mode)
> +	    || r != software_mute_orig_mode)
> +		pr_warn("Failed to restore mute mode\n");
> +}
> +
>  static int volume_alsa_set_volume(const u8 vol)
>  {
>  	dbg_printk(TPACPI_DBG_MIXER,
> @@ -6885,7 +6965,12 @@ static void volume_suspend(void)
>  
>  static void volume_resume(void)
>  {
> -	volume_alsa_notify_change();
> +	if (software_mute_active) {
> +		if (volume_set_software_mute(false) < 0)
> +			pr_warn("Failed to restore software mute\n");
> +	} else {
> +		volume_alsa_notify_change();
> +	}
>  }
>  
>  static void volume_shutdown(void)
> @@ -6901,6 +6986,9 @@ static void volume_exit(void)
>  	}
>  
>  	tpacpi_volume_checkpoint_nvram();
> +
> +	if (software_mute_active)
> +		volume_exit_software_mute();
>  }
>  
>  static int __init volume_create_alsa_mixer(void)
> @@ -7085,16 +7173,20 @@ static int __init volume_init(struct ibm_init_struct *iibm)
>  			"mute is supported, volume control is %s\n",
>  			str_supported(!tp_features.mixer_no_level_control));
>  
> -	rc = volume_create_alsa_mixer();
> -	if (rc) {
> -		pr_err("Could not create the ALSA mixer interface\n");
> -		return rc;
> -	}
> +	if (software_mute_requested && volume_set_software_mute(true) == 0) {
> +		software_mute_active = true;
> +	} else {
> +		rc = volume_create_alsa_mixer();
> +		if (rc) {
> +			pr_err("Could not create the ALSA mixer interface\n");
> +			return rc;
> +		}
>  
> -	pr_info("Console audio control enabled, mode: %s\n",
> -		(volume_control_allowed) ?
> -			"override (read/write)" :
> -			"monitor (read only)");
> +		pr_info("Console audio control enabled, mode: %s\n",
> +			(volume_control_allowed) ?
> +				"override (read/write)" :
> +				"monitor (read only)");
> +	}
>  
>  	vdbg_printk(TPACPI_DBG_INIT | TPACPI_DBG_MIXER,
>  		"registering volume hotkeys as change notification\n");
> @@ -9091,6 +9183,10 @@ MODULE_PARM_DESC(volume_control,
>  		 "Enables software override for the console audio "
>  		 "control when true");
>  
> +module_param_named(software_mute, software_mute_requested, bool, 0444);
> +MODULE_PARM_DESC(software_mute,
> +		 "Request full software mute control");
> +
>  /* ALSA module API parameters */
>  module_param_named(index, alsa_index, int, 0444);
>  MODULE_PARM_DESC(index, "ALSA index for the ACPI EC Mixer");

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

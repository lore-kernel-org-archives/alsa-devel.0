From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH v3 2/2] acpi: Remove _OSI(Linux) for ThinkPads
Date: Fri, 31 Oct 2014 21:07:37 -0200
Message-ID: <20141031230737.GB11745@khazad-dum.debian.net>
References: <cover.1413590510.git.luto@amacapital.net>
 <72ea290629696d2fc750dc5950c2af0776ab133e.1413590510.git.luto@amacapital.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <72ea290629696d2fc750dc5950c2af0776ab133e.1413590510.git.luto@amacapital.net>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Andy Lutomirski <luto@amacapital.net>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, ibm-acpi-devel@lists.sourceforge.net, Len Brown <len.brown@intel.com>, David Henningsson <david.henningsson@canonical.com>, Takashi Iwai <tiwai@suse.de>, Grant Diffey <gdiffey@gmail.com>, ALSA development <alsa-devel@alsa-project.org>, platform-driver-x86@vger.kernel.org, Jerone Young <jerone.young@canonical.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 17 Oct 2014, Andy Lutomirski wrote:
> AFAICT the only reason to set _OSI(Linux) on ThinkPads is to get
> sensible mute button behavior.  Now that the thinkpad_acpi driver
> can do this on is own, there is no reason to keep the ACPI
> quirk.
> 
> Cc: Len Brown <len.brown@intel.com>
> Cc: Jerone Young <jerone.young@canonical.com>
> Signed-off-by: Andy Lutomirski <luto@amacapital.net>

Acked-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

> ---
>  drivers/acpi/blacklist.c | 54 ------------------------------------------------
>  1 file changed, 54 deletions(-)
> 
> diff --git a/drivers/acpi/blacklist.c b/drivers/acpi/blacklist.c
> index 36eb42e3b0bb..4a3cbb5d3c55 100644
> --- a/drivers/acpi/blacklist.c
> +++ b/drivers/acpi/blacklist.c
> @@ -265,60 +265,6 @@ static struct dmi_system_id acpi_osi_dmi_table[] __initdata = {
>  	 */
>  
>  	/*
> -	 * Lenovo has a mix of systems OSI(Linux) situations
> -	 * and thus we can not wildcard the vendor.
> -	 *
> -	 * _OSI(Linux) helps sound
> -	 * DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad R61"),
> -	 * DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad T61"),
> -	 * T400, T500
> -	 * _OSI(Linux) has Linux specific hooks
> -	 * DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad X61"),
> -	 * _OSI(Linux) is a NOP:
> -	 * DMI_MATCH(DMI_PRODUCT_VERSION, "3000 N100"),
> -	 * DMI_MATCH(DMI_PRODUCT_VERSION, "LENOVO3000 V100"),
> -	 */
> -	{
> -	.callback = dmi_enable_osi_linux,
> -	.ident = "Lenovo ThinkPad R61",
> -	.matches = {
> -		     DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -		     DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad R61"),
> -		},
> -	},
> -	{
> -	.callback = dmi_enable_osi_linux,
> -	.ident = "Lenovo ThinkPad T61",
> -	.matches = {
> -		     DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -		     DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad T61"),
> -		},
> -	},
> -	{
> -	.callback = dmi_enable_osi_linux,
> -	.ident = "Lenovo ThinkPad X61",
> -	.matches = {
> -		     DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -		     DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad X61"),
> -		},
> -	},
> -	{
> -	.callback = dmi_enable_osi_linux,
> -	.ident = "Lenovo ThinkPad T400",
> -	.matches = {
> -		     DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -		     DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad T400"),
> -		},
> -	},
> -	{
> -	.callback = dmi_enable_osi_linux,
> -	.ident = "Lenovo ThinkPad T500",
> -	.matches = {
> -		     DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -		     DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad T500"),
> -		},
> -	},
> -	/*
>  	 * Without this this EEEpc exports a non working WMI interface, with
>  	 * this it exports a working "good old" eeepc_laptop interface, fixing
>  	 * both brightness control, and rfkill not working.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

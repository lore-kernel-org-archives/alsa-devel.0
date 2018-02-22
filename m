From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [RFC 0/1] ALSA: hda: Add a power_save blacklist
Date: Thu, 22 Feb 2018 12:22:19 +0100
Message-ID: <1e70d667-12d5-66f9-ed5b-7d5575110739@redhat.com>
References: <20180222105352.5408-1-hdegoede@redhat.com>
 <s5hmv01e0yv.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr0-f195.google.com (mail-wr0-f195.google.com
 [209.85.128.195])
 by alsa0.perex.cz (Postfix) with ESMTP id 873C42676E7
 for <alsa-devel@alsa-project.org>; Thu, 22 Feb 2018 12:22:21 +0100 (CET)
Received: by mail-wr0-f195.google.com with SMTP id z12so10179829wrg.4
 for <alsa-devel@alsa-project.org>; Thu, 22 Feb 2018 03:22:21 -0800 (PST)
In-Reply-To: <s5hmv01e0yv.wl-tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

On 22-02-18 12:08, Takashi Iwai wrote:
> On Thu, 22 Feb 2018 11:53:51 +0100,
> Hans de Goede wrote:
>>
>> Hi All,
>>
>> On some boards setting power_save to a non 0 value leads to clicking /
>> popping sounds when ever we enter/leave powersaving mode. Ideally we would
>> figure out how to avoid these sounds, but that is not always feasible.
>>
>> This commit adds a blacklist for devices where powersaving is known to
>> cause problems and disables it on these devices.
>>
>> Note this patch ATM is a RFC because I still need to get test-feedback
>> that it actually works on affected boards.
>>
>> I tried to put this blacklist in userspace first:
>> https://github.com/systemd/systemd/pull/8128
>>
>> But the systemd maintainers rightfully pointed out that it would be
>> impossible to then later remove entries once we actually find a way to
>> make power-saving work on listed boards without issues. Having this list
>> in the kernel will allow removal of the blacklist entry in the same commit
>> which fixes the clicks / plops.
>>
>> I've chosen to also apply the blacklist to changes made through
>> /sys/module/snd_hda_intel/parameters/power_save, since tools such as
>> powertop and TLP do this automatically.
>>
>> About the choice to also apply this to changes made through
>> /sys/module/snd_hda_intel/parameters/power_save, one could argue that this
>> will get in the way of users who want the power-saving anyways and are
>> willing to live with the clicks/plops. An alternative approach would be to
>> only apply this to the value of the module-parameter at boot and then only
>> when it matches CONFIG_SND_HDA_POWER_SAVE_DEFAULT. I'm open to changing this.
> 
> IMO, we shouldn't prevent user to set the explicit power_save mode
> even if it's blacklisted.  That is, if any, I prefer blacklist
> influencing only on the default value, a patch like below.

Ok, luckily I've not yet started a test-kernel build for people to test,
so I will rework this as you suggest and then do the test-build.

> But, before adding to the blacklist, it's better to investigate the
> cause.

I completely agree, but with power_save defaulting to 1 in the upcoming
Fedora 28 I'm not sure we will have time to fully investigate every
issue, also not every reporter may have the time to work with us on this,
I still have one bugreport open where I'm waiting for "lspci -v -nn"
output...

I see this blacklist as a way to give people a working config / fix
regressions quickly, as said already I completely agree that actually
fixing things is better. I'm just not sure that is feasible in all cases.

> For example, Lenovo X1 is definitely a thing to be looked at.
> Often a simple turn-off of "Loopback Mixing" element is enough.

Hmm, we've already tried several of the quirks from patch_realtek.c
on this one, but they have not helped. Another member of my team has
access to one and is more then happy to test better fixes, see:
https://bugzilla.kernel.org/show_bug.cgi?id=198611

So if you've anything he can try to fix this please leave a comment
there.

> We need alsa-info.sh output for further investigation for each case,
> in anyway.

Ok, note I've added a bugzilla link to each blacklist entry exactly
so that we can follow up and try to come up with a better fix.

I will ask all reporters to run alsa-info.sh and attach the generated
file to the bugs.

Regards,

Hans


> 
> 
> thanks,
> 
> Takashi
> 
> ===
> 
> diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
> index c71dcacea807..f21bf0add9f0 100644
> --- a/sound/pci/hda/hda_intel.c
> +++ b/sound/pci/hda/hda_intel.c
> @@ -181,7 +181,7 @@ static const struct kernel_param_ops param_ops_xint = {
>   };
>   #define param_check_xint param_check_int
>   
> -static int power_save = CONFIG_SND_HDA_POWER_SAVE_DEFAULT;
> +static int power_save = -1; /* default */
>   module_param(power_save, xint, 0644);
>   MODULE_PARM_DESC(power_save, "Automatic power-saving timeout "
>   		 "(in second, 0 = disable).");
> @@ -2198,6 +2198,7 @@ static int azx_probe_continue(struct azx *chip)
>   	struct hdac_bus *bus = azx_bus(chip);
>   	struct pci_dev *pci = chip->pci;
>   	int dev = chip->dev_index;
> +	int val;
>   	int err;
>   
>   	hda->probe_continued = 1;
> @@ -2278,7 +2279,11 @@ static int azx_probe_continue(struct azx *chip)
>   
>   	chip->running = 1;
>   	azx_add_card_list(chip);
> -	snd_hda_set_power_save(&chip->bus, power_save * 1000);
> +	val = power_save;
> +	if (val < 0 && !is_power_save_blacklisted(chip))
> +		val = CONFIG_SND_HDA_POWER_SAVE_DEFAULT;
> +	if (val >= 0)
> +		snd_hda_set_power_save(&chip->bus, val * 1000);
>   	if (azx_has_pm_runtime(chip) || hda->use_vga_switcheroo)
>   		pm_runtime_put_autosuspend(&pci->dev);
>   
> 

From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [V2 PATCH] ALSA: hda - Enable mute/mic-mute LEDs
 for more Thinkpads with Conexant codec
Date: Sat, 27 Jun 2015 11:03:04 +0800
Message-ID: <CAN8ccibyupfc_1xa3q7FfH_T7iL_1_S8cRJ1ksHG-BBJ1SJyfw@mail.gmail.com>
References: <1385534846-20829-1-git-send-email-hui.wang@canonical.com>
 <53AFF992.5030403@web.de> <53B0C596.6090007@canonical.com>
 <53B1078B.4090101@web.de> <53B219DF.6090807@canonical.com>
 <53B26575.1000003@web.de> <53B27ED7.4070401@canonical.com>
 <53B50062.30200@web.de> <53B51B63.8060809@canonical.com>
 <53B51CF3.8090102@web.de> <53B52146.9050300@canonical.com>
 <55603F22.8070103@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f48.google.com (mail-oi0-f48.google.com
 [209.85.218.48])
 by alsa0.perex.cz (Postfix) with ESMTP id C93D3261561
 for <alsa-devel@alsa-project.org>; Sat, 27 Jun 2015 05:03:06 +0200 (CEST)
Received: by oigx81 with SMTP id x81so87351163oig.1
 for <alsa-devel@alsa-project.org>; Fri, 26 Jun 2015 20:03:05 -0700 (PDT)
In-Reply-To: <55603F22.8070103@web.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jan Kiszka <jan.kiszka@web.de>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Hui Wang <jason77.wang@gmail.com>, tiwai@suse.de, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Hui Wang <hui.wang@canonical.com>, alex.hung@canonical.com, yk@canonical.com, david.henningsson@canonical.com
List-Id: alsa-devel@alsa-project.org

> >>>>>>>>>>> Most Thinkpad Edge series laptops use conexant codec, so far
> >>>>>>>>>>> although
> >>>>> <snip>
> >>>>>>>> Is there anything I can debug or any information I can collect
> >>>>>>>> from my
> >>>>>>>> box to examine this?
> >>>>>>> What is the linux distribution on your machine? And use showkey to
> >>>>>>> catch
> >>>>>>> the keycode of that button.
> >>>>>> I'm running OpenSUSE 13.1. The reported keycode of the power
> >>>>>> button is
> >>>>>> 116.
> >>>>> It seems the keycode is correct, it is power keycode rather the mute
> >>>>> keycode.
> >>>>>
> >>>>> Could you please do some debug, let us find which line of code is
the
> >>>>> root cause for this problem. for example:
> >>>>>
> >>>>> after running the line, the problem shows up:
> >>>>>
> >>>>> 1.     if (ACPI_SUCCESS(acpi_get_devices("LEN0068", acpi_check_cb,
> >>>>> &found, NULL)) && found) // in the sound/pci/hda/thinkpad_helper.c,
> >>>>> is_thinkpad()
> >>>> This evaluates to true
> >>>>
> >>>>> 2.     return ACPI_SUCCESS(acpi_get_devices("IBM0068",
acpi_check_cb,
> >>>>> &found, NULL)) && found; // same as above
> >>>>>
> >>>>> 3.         if (led_set_func(TPACPI_LED_MUTE, false) >= 0) { //in the
> >>>>> sound/pci/hda/thinkpad_helper.c, hda_fixup_thinkpad_acpi()
> >>>> ...and this
> >>>>
> >>>>> 4. if (led_set_func(TPACPI_LED_MICMUTE, false) >= 0) { // same as
> >>>>> above
> >>>>>
> >>>> ...and this as well. spec->num_adc_nids is 1.
> >>>
> >>> If we change the code like below, does the power button can work well?
> >>>
> >>> in the thinkpad_helper.c, hda_fixup_thinkpad_acpi()
> >>>
> >>>
> >>>          if (led_set_func(TPACPI_LED_MUTE, false) >= 0) {
> >>>              /*
> >>>              old_vmaster_hook = spec->vmaster_mute.hook;
> >>>              spec->vmaster_mute.hook = update_tpacpi_mute_led;
> >>>              removefunc = false;
> >>>             */
> >> Disabling only this block resolves the issue.
> >
> > So Below two lines make the power button change to the reset button.
> >
> > drivers/platform/x86/thinkpad_acpi.c  mute_led_on_off():
> >
> > acpi_get_handle(hkey_handle, "SSMS", &temp);
> > acpi_evalf(hkey_handle, &output, "SSMS", "dd", 1);
> >
> >

http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/drivers/platform/x86/thinkpad_acpi.c?id=9a417ec0c9d1f7af5394333411fc4d98adb8761b

It seem that software mute also depend on HAUM and SAUM ACPI interface

Seem regression of the above patch is SSMS is not supported

https://bugs.launchpad.net/ubuntu/+source/alsa-driver/+bug/1450947

Which models of thinkpad are tested by the author ?

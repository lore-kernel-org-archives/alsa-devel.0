From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [pulseaudio-discuss] ThinkPad T-510 audio output
	mute LED non-workingness
Date: Fri, 1 May 2015 22:22:15 +0800
Message-ID: <CAN8ccibSH6je=OpX6vOTG9PzETxikmpuX+7PDgiYNrsG+YavNw@mail.gmail.com>
References: <20150419133733.GA551@huh.zplane.com>
 <CAN8cciYqdJ-m+M0+F09115nocy7szAfgdAf834c2bS4=gL7DAA@mail.gmail.com>
 <20150425013937.GB550@huh.zplane.com>
 <1429974719.3937109.258484493.7D74FAC6@webmail.messagingengine.com>
 <20150426152012.GE550@huh.zplane.com>
 <s5hvbgiho2o.wl-tiwai@suse.de>
 <CAN8cciZQBRz2Ty3YRt2+3KO9v1BWef-_8FU_d_SsE87mLdgY-w@mail.gmail.com>
 <s5hh9s2gj45.wl-tiwai@suse.de>
 <20150427135859.GI550@huh.zplane.com>
 <s5ha8xt4hsa.wl-tiwai@suse.de>
 <20150428000206.GK550@huh.zplane.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f46.google.com (mail-oi0-f46.google.com
 [209.85.218.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 4CA9E2605EE
 for <alsa-devel@alsa-project.org>; Fri,  1 May 2015 16:22:17 +0200 (CEST)
Received: by oign205 with SMTP id n205so70726047oig.2
 for <alsa-devel@alsa-project.org>; Fri, 01 May 2015 07:22:16 -0700 (PDT)
In-Reply-To: <20150428000206.GK550@huh.zplane.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: gdg@zplane.com
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Alex Hung <alex.hung@canonical.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, bruno.mueller@gmail.com, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

>
> Here are the XXX messages:
>
>     [   13.722755] sound hdaudioC0D0: XXX hda_fixup_thinkpad_acpi init...
>     [   13.724366] sound hdaudioC0D0: XXX ok, this is thinkpad
>     [   13.724373] sound hdaudioC0D0: XXX mute LED NOT WORKING!
>

This mean that your thinkpad does not support SSMS interface


>     [   13.724374] sound hdaudioC0D0: XXX ok, mic LED is hooked
>

This mean that your thinkpad support MMTS interface


http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/drivers/platform/x86/thinkpad_acpi.c?id=9a417ec0c9d1f7af5394333411fc4d98adb8761b

it look like you still need hardware mute gate to turn on/off mute led if
there is no other way to turn mute led on/off

but need the MMTS to turn on/off mic mute led

https://lists.launchpad.net/hybrid-graphics-linux/msg01387.html

Do T420 support SSMS interface ?

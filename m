From: Glenn Golden <gdg@zplane.com>
Subject: Re: [pulseaudio-discuss] ThinkPad T-510 audio output
 mute LED non-workingness
Date: Mon, 27 Apr 2015 18:02:06 -0600
Message-ID: <20150428000206.GK550@huh.zplane.com>
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
Reply-To: gdg@zplane.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.indra.com (smtp.indra.com [209.169.0.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 5C0262654CC
 for <alsa-devel@alsa-project.org>; Tue, 28 Apr 2015 02:02:16 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5ha8xt4hsa.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Alex Hung <alex.hung@canonical.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Raymond Yau <superquad.vortex2@gmail.com>, bruno.mueller@gmail.com, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai <tiwai@suse.de> [2015-04-27 19:12:21 +0200]:
> 
> Below is a debug patch, and now you should see messages like "XXX ..."
> in kernel log at loading the driver.  If there is no such a message,
> it means that the thinkpad hook isn't built in at all.  Please check
> the kernel log again with the patch.
> 

Here are the XXX messages:

    [   13.722755] sound hdaudioC0D0: XXX hda_fixup_thinkpad_acpi init...
    [   13.724366] sound hdaudioC0D0: XXX ok, this is thinkpad
    [   13.724373] sound hdaudioC0D0: XXX mute LED NOT WORKING!
    [   13.724374] sound hdaudioC0D0: XXX ok, mic LED is hooked

Smoking gun?

Btw, about "extramodules": Thanks for your suggestion on approaching that.

As it turns out, the only modules that were in /lib/extramodules from the
distro install were tp_smapi and friends (thinkpad_ec, hdaps). (That's why
my battery indicator wasn't working.)  But after some reading, it seems like
these are probably not implicated in the present issue, so I just said the heck
with it and didn't bother to do anything further in attempting to recreate
extramodules for the patched build.  But if you think that any of that
tp_smapi stuff might be relevant, let me know and I'll do what's necessary
to build the extramodules subtree.

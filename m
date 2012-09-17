From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Channel map API patches: to be 3.7 or not to be?
Date: Mon, 17 Sep 2012 18:46:32 +0800
Message-ID: <CAN8cciZh44NaQrNUagMiY7O=v7JmmgCfTEDySiBGoopYdNAUJg@mail.gmail.com>
References: <s5hk3w1g4e2.wl%tiwai@suse.de>
 <CAN8cciYtoH91sFjwes+aTAjO+4z8CCMdOYgM4kdWbGNr3iuheQ@mail.gmail.com>
 <s5hbohdezpc.wl%tiwai@suse.de> <s5hehm8rc2s.wl%tiwai@suse.de>
 <CAN8ccib1bbVtGDcEqiizbzQg+iZg13redh_fPMYX-fQsGKtStw@mail.gmail.com>
 <s5h627jg3r2.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qa0-f44.google.com (mail-qa0-f44.google.com
 [209.85.216.44])
 by alsa0.perex.cz (Postfix) with ESMTP id 45FB0264F0D
 for <alsa-devel@alsa-project.org>; Mon, 17 Sep 2012 12:46:33 +0200 (CEST)
Received: by qafi29 with SMTP id i29so1914960qaf.17
 for <alsa-devel@alsa-project.org>; Mon, 17 Sep 2012 03:46:32 -0700 (PDT)
In-Reply-To: <s5h627jg3r2.wl%tiwai@suse.de>
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
Cc: lukasz.wojnilowicz@gmail.com, ALSA Development Mailing List <alsa-devel@alsa-project.org>, pulseaudio-discuss@lists.freedesktop.org
List-Id: alsa-devel@alsa-project.org

> > How about those sound card which use multi plugin for multi channels
(e.g.
> > emu10k1 , c0106 and cs4630) as they can also provide a rear or clfe
device
> > for independent stereo playback ?
>
> The case of emu10k1 is a bit difficult, as the routing is completely
> dynamic and determined in alsa-lib plugin.  So, my plan for this case
> is to provide the chmap override in the alsa-lib config definition for
> emu10k1 surrounds.
>
But the routing of device 0 "hw" is not as same as front device since the
driver pan the output to both front and rear jacks (upmixing).

Does all pcm devices support channel map ?

How about those 16 channels multichannel playback and capture devices ?

card 0: Live [SB Live! Platinum [CT4760P]], device 2: emu10k1 efx
[Multichannel Capture/PT Playback]
  Subdevices: 8/8

card 0: Live [SB Live! Platinum [CT4760P]], device 3: emu10k1 [Multichannel
Playback]
  Subdevices: 1/1

**** List of CAPTURE Hardware Devices ****

card 0: Live [SB Live! Platinum [CT4760P]], device 2: emu10k1 efx
[Multichannel Capture/PT Playback]
  Subdevices: 1/1

BTW. It seem that the patch for USB audio is still missing as some USB card
support 5.1/7.1

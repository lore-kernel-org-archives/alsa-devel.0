From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: sound: usb-audio: full capture/playback/spdif
 support for Digidesign Mbox 2
Date: Thu, 13 Dec 2012 16:29:35 +0100
Message-ID: <50C9F45F.3010806@ladisch.de>
References: <AANLkTi=cSDq5SEh321Zy2n2RMHWFnW2-hd-=k9mz+eEz@mail.gmail.com>
 <4CEED787.9050504@gmail.com>
 <AANLkTimjaYMaqA3fFqWKi0+8nsaqENe8oWj=hph1Hv09@mail.gmail.com>
 <s5hfwukp4k4.wl%tiwai@suse.de>
 <AANLkTi=3JSsaa=P5s31+fq75Jp0WQUKD7mu0Ft8Tq+bP@mail.gmail.com>
 <4CF517BF.4020706@ladisch.de>
 <AANLkTi=Y6tA=1CW6Yu0rpAm7=JyLLjA1A-4cL-JFaBrP@mail.gmail.com>
 <AANLkTimH8OfncsS_WPtXGgFN316YeJQMtEEfkxXmEuQ8@mail.gmail.com>
 <CABXa2sE_WRgCv_Ym9gD2s0bggwBghSUsJhOamSYrNhq80_F8Bw@mail.gmail.com>
 <s5h6246saej.wl%tiwai@suse.de>
 <CABXa2sFRG7fuCnpvOhyhFre_McY7ts6caRUZeHO0didnTow3Sg@mail.gmail.com>
 <s5h4njqdraf.wl%tiwai@suse.de> <s5h38zadqvu.wl%tiwai@suse.de>
 <CABXa2sGwkOSmEXGhZ8123QFsr9T_c=+UzK5fdkZt-OE0CLF40w@mail.gmail.com>
 <s5hvcc6yp4w.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id CBB9226501A
 for <alsa-devel@alsa-project.org>; Thu, 13 Dec 2012 16:29:38 +0100 (CET)
In-Reply-To: <s5hvcc6yp4w.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Damien Zammit <damien.zammit@gmail.com>, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> Damien Zammit wrote:
>> +	case QUIRK_MIDI_MBOX2:
>> +		/* Digidesign Mbox 2 uses MIDIMAN MIDI protocol */
>> +		umidi->usb_protocol_ops = &snd_usbmidi_midiman_ops;
>> +		err = snd_usbmidi_detect_per_port_endpoints(umidi, endpoints);
>> +		break;
>
> If the quirk handling is as same as QUIRK_MIDI_MIDIMAN, can't we just
> reuse it instead of adding yet a new type?

The endpoint detection is different; that comment applies only to the
next single line.

But while technically correct, the comment is superfluous because it
doesn't say anything that isn't obvious from the code.


Regards,
Clemens

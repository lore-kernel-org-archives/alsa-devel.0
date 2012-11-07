From: Massimo Del Fedele <max@veneto.com>
Subject: Re: Fix for Asus G75 notebook subwoofer
Date: Wed, 07 Nov 2012 18:02:20 +0100
Message-ID: <509A941C.8060305@veneto.com>
References: <k6rkr2$usv$1@ger.gmane.org> <s5hy5ifgmbq.wl%tiwai@suse.de>
 <k7ajdq$42u$1@ger.gmane.org> <s5hsj8ngkxe.wl%tiwai@suse.de>
 <k7b68h$epd$1@ger.gmane.org> <s5h390m95d5.wl%tiwai@suse.de>
 <509947A7.9080406@veneto.com> <s5h7gpxhjtz.wl%tiwai@suse.de>
 <509A641D.8070501@veneto.com> <s5h390l7chn.wl%tiwai@suse.de>
 <509A8365.7060001@veneto.com> <s5hr4o55ryl.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from plane.gmane.org (plane.gmane.org [80.91.229.3])
 by alsa0.perex.cz (Postfix) with ESMTP id C958F2650A7
 for <alsa-devel@alsa-project.org>; Wed,  7 Nov 2012 18:02:29 +0100 (CET)
Received: from list by plane.gmane.org with local (Exim 4.69)
 (envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1TW91S-0000zL-26
 for alsa-devel@alsa-project.org; Wed, 07 Nov 2012 18:02:38 +0100
Received: from host184-250-dynamic.0-87-r.retail.telecomitalia.it
 ([87.0.250.184]) by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Wed, 07 Nov 2012 18:02:38 +0100
Received: from max by host184-250-dynamic.0-87-r.retail.telecomitalia.it with
 local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Wed, 07 Nov 2012 18:02:38 +0100
In-Reply-To: <s5hr4o55ryl.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


Il 07/11/2012 16:54, Takashi Iwai ha scritto:
>
> It's OK, just missing the stereo capability check in the mixer code,
> but almost harmless.  Which channel (left or right) of "surround"
> mixer actually controls the volume of subwoofer on your machine?

Both, as the volume control is at DAC level and not at pin one.
aplay with channel test sound shows a 4 channels audio, driving
subwoofer with both rear left and rear right data.
If I lower left or right volume, just opposite channel goes to
subwoofer.
I guess that mono mixing is done at widget 0x3e (the hidden one).

Massimo

From: Robin Gareus <robin@gareus.org>
Subject: Re: firewire mixer interface -- was Re: [PATCH 11/11]
 ALSA: digi00x: apply double-oh-three algorism to multiplex PCM samples
Date: Tue, 24 Mar 2015 04:15:07 +0100
Message-ID: <5510D6BB.60806@gareus.org>
References: <1426435269-17059-1-git-send-email-o-takashi@sakamocchi.jp>	<1426435269-17059-12-git-send-email-o-takashi@sakamocchi.jp>	<5506E7EE.6060300@gareus.org>	<55070409.8090107@sakamocchi.jp>	<55070F3B.7000509@gareus.org>	<55075D65.20406@sakamocchi.jp>	<55082E06.6010008@gareus.org>	<55083103.5030704@gmail.com>	<5508CFA5.7060903@sakamocchi.jp>	<550AD65F.10803@gareus.org>	<550B51BC.80506@sakamocchi.jp>	<550C0CFC.4060404@gareus.org>	<550C1FC6.4050700@sakamocchi.jp>	<s5hmw376bck.wl-tiwai@suse.de>	<550C25DD.3080507@sakamocchi.jp>	<s5hfv8z69jz.wl-tiwai@suse.de>	<550C3294.7020003@sakamocchi.jp>
 <s5hsicz1znq.wl-tiwai@suse.de> <550D08D9.7070509@gmail.com>
 <550E2F1C.2020009@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de
 [81.169.146.218])
 by alsa0.perex.cz (Postfix) with ESMTP id CDB79261566
 for <alsa-devel@alsa-project.org>; Tue, 24 Mar 2015 04:15:21 +0100 (CET)
In-Reply-To: <550E2F1C.2020009@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, clemens@ladisch.de, ffado-devel@lists.sf.net, Damien Zammit <damien.zammit@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 03/22/2015 03:55 AM, Takashi Sakamoto wrote:
[..]
> It's due to what I've reported to Robin. According to his response, I've
> judge his codes have never passed any appropriate tests with actual devices.

We did clean-room reverse engineer the protocol and key. I do not own
any digidesign devices (nor any other firewire devices for that matter)
and have never tested it myself on real hardware.

I can only state that the current code works correctly on all the raw
bus data dumps that I have seen so far.

Damien verified the code to work on real hardware and mentioned that in
a prior email and also on
https://github.com/takaswie/snd-firewire-improve/issues/16

Cheers!
robin

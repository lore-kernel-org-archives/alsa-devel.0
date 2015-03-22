From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: firewire mixer interface -- was Re: [PATCH 11/11]
 ALSA: digi00x: apply double-oh-three algorism to multiplex PCM samples
Date: Sun, 22 Mar 2015 11:55:24 +0900
Message-ID: <550E2F1C.2020009@sakamocchi.jp>
References: <1426435269-17059-1-git-send-email-o-takashi@sakamocchi.jp>	<1426435269-17059-12-git-send-email-o-takashi@sakamocchi.jp>	<5506E7EE.6060300@gareus.org>	<55070409.8090107@sakamocchi.jp>	<55070F3B.7000509@gareus.org>	<55075D65.20406@sakamocchi.jp>	<55082E06.6010008@gareus.org>	<55083103.5030704@gmail.com>	<5508CFA5.7060903@sakamocchi.jp>	<550AD65F.10803@gareus.org>	<550B51BC.80506@sakamocchi.jp>	<550C0CFC.4060404@gareus.org>	<550C1FC6.4050700@sakamocchi.jp>	<s5hmw376bck.wl-tiwai@suse.de>	<550C25DD.3080507@sakamocchi.jp>	<s5hfv8z69jz.wl-tiwai@suse.de>	<550C3294.7020003@sakamocchi.jp>
 <s5hsicz1znq.wl-tiwai@suse.de> <550D08D9.7070509@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id D5FEB26043E
 for <alsa-devel@alsa-project.org>; Sun, 22 Mar 2015 03:55:30 +0100 (CET)
In-Reply-To: <550D08D9.7070509@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Damien Zammit <damien.zammit@gmail.com>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Robin Gareus <robin@gareus.org>, clemens@ladisch.de, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

On Mar 21 2015 14:59, Damien Zammit wrote:
> I think it would be a nice feature if it just worked out of the box like
> any other alsa mixer control, and I'm sure many other people who are
> currently using FFADO would agree that having everything to control the
> sound card in ALSA would be more convenient than what they have now.

Over generalization.

Actually ALSA middleware cannot represent control interfaces with the
same level as FFADO achieves, thus your idea can bring no advantages to
FFADO users.

> Takashi S: can we perhaps focus on getting the streaming working better
> with 003amdtp for digi00x and revisit the issue of mixer controls later?

It's what I've suggested.

> Have you looked at the updated 003amdtp documentation?  I believe Robin
> has made suggestions on how to integrate the latest code into the driver.

It's due to what I've reported to Robin. According to his response, I've
judge his codes have never passed any appropriate tests with actual devices.


Regards

Takashi Sakamoto

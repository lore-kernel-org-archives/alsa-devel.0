From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 11/11] ALSA: digi00x: apply double-oh-three
 algorism to multiplex PCM samples
Date: Fri, 20 Mar 2015 07:51:38 +0900
Message-ID: <550B52FA.2060506@sakamocchi.jp>
References: <1426435269-17059-1-git-send-email-o-takashi@sakamocchi.jp>
 <1426435269-17059-12-git-send-email-o-takashi@sakamocchi.jp>
 <5506E7EE.6060300@gareus.org> <55070409.8090107@sakamocchi.jp>
 <55070F3B.7000509@gareus.org> <55075D65.20406@sakamocchi.jp>
 <55082E06.6010008@gareus.org> <55083103.5030704@gmail.com>
 <5508CFA5.7060903@sakamocchi.jp> <550AD65F.10803@gareus.org>
 <550B51BC.80506@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 0E40426067F
 for <alsa-devel@alsa-project.org>; Thu, 19 Mar 2015 23:51:43 +0100 (CET)
In-Reply-To: <550B51BC.80506@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Robin Gareus <robin@gareus.org>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, clemens@ladisch.de, Damien Zammit <damien.zammit@gmail.com>, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

On Mar 20 2015 07:46, Takashi Sakamoto wrote:
> I can't understand what character devices you mention about. If you
> mention about ALSA PCM character devices (usually
> /dev/snd/pcmC%uD%d[p|c]), it's yes. In fact, one ALSA application can
> use ALSA PCM character device for one direction (playback/capture). So
> the access by any other applications causes -EBUSY. (here, I ignore
> alsa-lib's PCM direct mixing layer.)

I'll correct the 'ALSA application' with 'ALSA PCM application'. The
ALSA PCM application and ALSA Control application are different because
they access to different character devices and use different set of
ioctl(2) interfaces or different API set given by alsa-lib.


Regards

Takashi Sakamoto

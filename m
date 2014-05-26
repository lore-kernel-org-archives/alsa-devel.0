From: Fidel Leon Martin <fidelleon@mykolab.com>
Subject: Re: Fwd: Re: No sound for a rather old laptop (ALC260).
Date: Mon, 26 May 2014 17:17:06 +0200
Message-ID: <2860698.yPnmLZqY7f@lillinux>
References: <1490682.oNo167L24G@lillinux> <s5hr43gk3wi.wl%tiwai@suse.de>
Content-Type: multipart/mixed; boundary="nextPart6228463.uda4In2KoC"
Content-Transfer-Encoding: 7Bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx03.mykolab.com (mx01.mykolab.com [95.128.36.1])
 by alsa0.perex.cz (Postfix) with ESMTP id EDCC326518B
 for <alsa-devel@alsa-project.org>; Mon, 26 May 2014 17:17:14 +0200 (CEST)
In-Reply-To: <s5hr43gk3wi.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.

--nextPart6228463.uda4In2KoC
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday 26 May 2014 16:31:25 you wrote:
> At Mon, 26 May 2014 16:11:35 +0200,
> 
> Fidel Leon Martin wrote:
> > Hello, list. Is there any way to know if this support request has been
> > taken by anyone...?
> 
> There is no such a thing like "support request" on the ML...

s/support request/bug report/, sorry O:-)

> > > Fidel Leon wrote:
> > > > I own a rather old laptop which features a snd_hda_intel soundcard,
> > > > with a
> > > > ALC260 chipset.
> > Attached are alsa-infos from kernel 2.6 (which works) and 3.14 (Fedora 20,
> > which doesnt work).
> 
> Looking at the alsa-info.sh output on 3.14, the node 0x0f has a
> strange control value 0x80.  This should be usually 0xc0, and testing
> with the emulator, it give this value at all.
> 
> What if you give model=nofixup option to snd-hda-intel module?

/etc/modprobe.d/alc260.conf:
options snd-hda-intel model=nofixup

Rebooted but seems to make little difference. Cranked every slider from 
Alsamixer an pavucontrol to maximum. No output from speakers and a very low 
volume output in the S/PDIF output.

And now, to increase my dumb reputation, I'm not running 3.14 kernel (neither 
Fedora) anymore - I'm using Lubuntu 14.04 - so I'm attaching alsa-info.sh log 
for new setup.

-- 
Fidel Leon
fidelleon@mykolab.com
GPG: AD74FB97

--nextPart6228463.uda4In2KoC
Content-Disposition: attachment; filename="alsa-alc260-3.13.txt.gz"
Content-Transfer-Encoding: base64
Content-Type: application/gzip; name="alsa-alc260-3.13.txt.gz"

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

--nextPart6228463.uda4In2KoC
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--nextPart6228463.uda4In2KoC--

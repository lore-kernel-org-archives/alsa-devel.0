From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Re: How to support multiple open in low-level driver
Date: Sun, 5 Jan 2003 16:05:24 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0301051600200.500-100000@pnote.perex-int.cz>
References: <200301051548.31168.torger@ludd.luth.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (root@gate.perex.cz [194.212.165.105])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id QAA12552
	for <alsa-devel@alsa-project.org>; Sun, 5 Jan 2003 16:06:08 +0100
In-Reply-To: <200301051548.31168.torger@ludd.luth.se>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Anders Torger <torger@ludd.luth.se>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sun, 5 Jan 2003, Anders Torger wrote:

> On Sunday 05 January 2003 15.34, Jaroslav Kysela wrote:
> > > I noticed that also my rme96 driver supported this sort of,
> > > although it probably does not feel very good about it. If the sound
> > > card is in ADAT mode, it is not so good if it is reopened in SPDIF
> > > mode from another application for example.
> > >
> > > I'd like to just return -EBUSY if it is already open, is that ok?
> >
> > If you pass value one to snd_pcm_new() - substream counts, then the
> > midlevel code takes care about this constraint. No special code is
> > required on the driver side.
> 
> Ok, thanks for the information, you are being most helpful.
> 
> I have another question. The rme96 driver provides two sub devices, one 
> which is the card in adat mode, and one which is the card in spdif 
> mode. These cannot be run at the same time.
> 
> If I had written the driver today, I suppose I would have had only one 
> device, which supports 2 or 8 channels. Do you agree that it would be a 
> better design, than the two sub-devices I have now? I don't think I 
> will change that now though, if you don't insist that I should (I think 
> it will be quite easy to do the change).
> 
> If I keep the two sub-devices, I suppose then returning EBUSY in the 
> open function is the correct way if the card is busy running the ADAT 
> subdevice when trying to open the SPDIF subdevice (or the other way 
> around).

Well, you're talking about PCM devices (subdevices are one level after 
devices):

cards -> pcm devices -> pcm subdevices

I think that current implementation is good when hardware has S/PDIF and
ADAT outputs completely separate. If S/PDIF can be somehow used
simultaneously in ADAT mode (8 channels) or versa vice, then it would be
better to use only one device with two available channel counts (2 and 8).

Anyway, selecting this implementation detail is completely on the driver's 
author.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

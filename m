From: Anders Torger <torger@ludd.luth.se>
Subject: Re: Re: How to support multiple open in low-level driver
Date: Sun, 5 Jan 2003 15:48:31 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200301051548.31168.torger@ludd.luth.se>
References: <Pine.LNX.4.33.0301051532360.500-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.it4u.net (mail.it4u.net [81.8.150.196])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id PAA12299
	for <alsa-devel@alsa-project.org>; Sun, 5 Jan 2003 15:49:08 +0100
In-Reply-To: <Pine.LNX.4.33.0301051532360.500-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sunday 05 January 2003 15.34, Jaroslav Kysela wrote:
> > I noticed that also my rme96 driver supported this sort of,
> > although it probably does not feel very good about it. If the sound
> > card is in ADAT mode, it is not so good if it is reopened in SPDIF
> > mode from another application for example.
> >
> > I'd like to just return -EBUSY if it is already open, is that ok?
>
> If you pass value one to snd_pcm_new() - substream counts, then the
> midlevel code takes care about this constraint. No special code is
> required on the driver side.

Ok, thanks for the information, you are being most helpful.

I have another question. The rme96 driver provides two sub devices, one 
which is the card in adat mode, and one which is the card in spdif 
mode. These cannot be run at the same time.

If I had written the driver today, I suppose I would have had only one 
device, which supports 2 or 8 channels. Do you agree that it would be a 
better design, than the two sub-devices I have now? I don't think I 
will change that now though, if you don't insist that I should (I think 
it will be quite easy to do the change).

If I keep the two sub-devices, I suppose then returning EBUSY in the 
open function is the correct way if the card is busy running the ADAT 
subdevice when trying to open the SPDIF subdevice (or the other way 
around).

/Anders Torger


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

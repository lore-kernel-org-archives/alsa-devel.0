From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: How to support multiple open in low-level driver
Date: Sun, 5 Jan 2003 15:34:53 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0301051532360.500-100000@pnote.perex-int.cz>
References: <200301032337.37262.torger@ludd.luth.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (root@gate.perex.cz [194.212.165.105])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id PAA12084
	for <alsa-devel@alsa-project.org>; Sun, 5 Jan 2003 15:35:24 +0100
In-Reply-To: <200301032337.37262.torger@ludd.luth.se>
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

On Fri, 3 Jan 2003, Anders Torger wrote:

> I have noticed that some (most) low level drivers support multiple open, 
> that is a sound card which is already opened, can be opened again.

Yes, but hardware must support this feature (it must mix multiple streams 
in hardware and have appropriate amount of DMA engines).

> I noticed that also my rme96 driver supported this sort of, although it 
> probably does not feel very good about it. If the sound card is in ADAT 
> mode, it is not so good if it is reopened in SPDIF mode from another 
> application for example.
> 
> I'd like to just return -EBUSY if it is already open, is that ok?

If you pass value one to snd_pcm_new() - substream counts, then the 
midlevel code takes care about this constraint. No special code is 
required on the driver side.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Channels jumping with snd_intel8x0,
 nforce2 and 5.1 output
Date: Mon, 12 Jan 2004 18:08:00 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0401121805030.23817-100000@studcom.urz.uni-halle.de>
References: <20040108222431.GA16232@helvete.escomposlinux.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mlucom10.urz.uni-halle.de (mlucom10.urz.Uni-Halle.DE [141.48.3.4])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id SAA06557
	for <alsa-devel@alsa-project.org>; Mon, 12 Jan 2004 18:08:05 +0100
In-reply-to: <20040108222431.GA16232@helvete.escomposlinux.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Gorka Olaizola <gorka@escomposlinux.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Gorka Olaizola wrote:
> I downloaded de nvaudio driver from Nvidia's site and read the source a bit.
>
>         /* Reset the Global Cnt back to Stereo 16ch and set the format
>            This is needed to keep the 6 channel data in alignment ,
>            to start from Front Left always */
>         i_glob_cnt = inl(card->iobase + GLOB_CNT);
>         outl((i_glob_cnt & 0xcfffff),card->iobase + GLOB_CNT);
>         mdelay(50);
>         outl(i_glob_cnt,card->iobase + GLOB_CNT);
>
> I translated the part that I thought interesting to the function
> "snd_intel8x0_setup_multi_channels" in the file intel8x0.c of Alsa (Line
> 923)
> ...
> Now speaker_test works well for me and the sound is coming from the right
> speaker all the time. But there are some problems.
> With mplayer in oss emulation the sound is very choppy and with
> alsa9:surround51 there are constant cracks and pops.
> If I play a DVD with xine with alsa:surround51 the sound seems correct and I
> don't hear cracks. Maybe mplayer has some problems with alsa 1.0.x

I think these problems are not related to your patch.

Please add an explanatory comment to your change, and submit a patch
for intel8x0.c.


Regards,
Clemens




-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html

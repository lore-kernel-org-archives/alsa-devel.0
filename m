From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Reasonable sound hardware parameters?
Date: Mon, 28 May 2007 10:52:18 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0705281045310.7894@tm8103.perex-int.cz>
References: <1180162229.5468.21.camel@localhost>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-1653132244-1180342338=:7894"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 73DF624701
	for <alsa-devel@alsa-project.org>;
	Mon, 28 May 2007 10:52:19 +0200 (CEST)
In-Reply-To: <1180162229.5468.21.camel@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Joachim =?ISO-8859-1?Q?F=F6rster?= <mls.JOFT@gmx.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-1653132244-1180342338=:7894
Content-Type: TEXT/PLAIN; charset=iso8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sat, 26 May 2007, Joachim F=F6rster wrote:

> Hi ALSA devs,
>=20
> as I already described in one of my last posts on the list, I'm going to
> write a ALSA driver for a sound controller which will also be "written"
> at the same time (VHDL for FPGA) - on top of an embedded system (Xilinx
> ML403 EvalBoard, PowerPC 405). We will do playback feature only.
>=20
> The point is, that we will have _no_ real DMA and we don't want to use
> the copy/silence or ack/workqueue (with intermediate buffer). So we
> decided to move the ring buffer, which usually exists in RAM into the
> sound controller and handle it as some kind of device IO memory, which
> should be mmap'able (kernel function io_remap_pfn_range()). So, the
> important goal is, to have mmap feature in the ALSA driver.
>=20
> First question: To implement mmap on such kind of device IO memory, I
> have to use snd_pcm_lib_mmap_iomem() as mmap() callback - like it is
> used in the rme32 driver, right?

Yes. rme32 is quite similar.

> Second question: Do the following parameters make sense regarding the
> size of the HW ring buffer and period sizes:
>=20
> .buffer_bytes_max=3D16*1024;
> .period_bytes_max=3D8*1024;
> .period_bytes_min=3D?? resonable value ??

32 or 64

> .periods_min=3D2;
> .periods_max=3D?? resonable value ??

16

> Furthermore, the sound controller will fire an interrupt after one=20
> period is played. Are there any arguments against these values? Any=20
> comments?

Yes, I think that the access through a PCI I/O window to a PCI device is=20
much slower than PCI DMA transfers with bursts. I would really consider to=
=20
design hardware with real DMA. Of course, if it's only experimental stuff,=
=20
then don't worry.

=09=09=09=09=09=09Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
--8323584-1653132244-1180342338=:7894
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--8323584-1653132244-1180342338=:7894--

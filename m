From: John Rigg <ad@sound-man.co.uk>
Subject: Re: Re: [OT] ALSA userspace API complexity
Date: Mon, 9 Jan 2006 23:20:43 +0000
Message-ID: <20060109232043.GA5013__28017.9579197013$1136848300$gmane$org@localhost.localdomain>
References: <20050726150837.GT3160@stusta.de> <200601091405.23939.rene@exactcode.de> <Pine.LNX.4.61.0601091637570.21552@zeus.compusonic.fi> <200601091812.55943.rene@exactcode.de> <Pine.LNX.4.62.0601091355541.4005@qynat.qvtvafvgr.pbz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail3.uklinux.net (mail3.uklinux.net [80.84.72.33])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C7EE213D
	for <alsa-devel@alsa-project.org>; Tue, 10 Jan 2006 00:10:27 +0100 (MET)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0601091355541.4005@qynat.qvtvafvgr.pbz>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: David Lang <dlang@digitalinsight.com>
Cc: =?iso-8859-1?Q?Ren=E9?= Rebe <rene@exactcode.de>, Hannu Savolainen <hannu@opensound.com>, Jaroslav Kysela <perex@suse.cz>, Takashi Iwai <tiwai@suse.de>, linux-sound@vger.kernel.org, ALSA development <alsa-devel@alsa-project.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 09, 2006 at 01:58:00PM -0800, David Lang wrote:
> On Mon, 9 Jan 2006, Ren=E9 Rebe wrote:
>=20
> >On Monday 09 January 2006 16:10, Hannu Savolainen wrote:
> >
> >>>>I don't think so. The library can do such conversions (and alsa-lib=
=20
> >>>>does)
> >>>>quite easy. If we have a possibility to remove the code from the ke=
rnel
> >>>>space without any drawbacks, then it should be removed. I don't see=
 any
> >>>>advantage to have such conversions in the kernel.
> >>>
> >>>Also, when the data is already available as single streams in a=20
> >>>user-space
> >>>multi track application, why should it be forced interleaved, when t=
he=20
> >>>hardware
> >>>could handle the format just fine?
> >>Because the conversion doesn't cost anything. Trying to avoid it by
> >>making the API more complicated (I would even say confusing) is extre=
me
> >>overkill.
> >
> >Since when doesn't cost convesion anything? I'm able to count a lot of=
=20
> >wasted
> >CPU cycles in there ...
>=20
> if the data needed to be accessed by the CPU anyway it's free becouse=20
> otherwise the CPU would stall waiting for the next chunk of memory. you=
=20
> can do quite a bit of work on data in cache while you are waiting for t=
he=20
> next cache line to load.
>=20
> in this same way, checksumming a network packet is free if the CPU need=
s=20
> to copy the data anway, it only costs something if the data could bypas=
s=20
> the CPU.

Yes, but the CPU has plenty of other work to do. The sound cards that
would be worst affected by this are the big RME cards (non-interleaved) a=
nd
multiple ice1712 cards (non-interleaved blocks of interleaved data),
which AFAIK are the only cards capable of handling serious professional a=
udio.
This could represent 48 or more channels of 96kHz audio, which
doesn't leave a lot of spare CPU capacity for running X, for example.

John


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click

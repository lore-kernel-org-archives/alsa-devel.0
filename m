From: Iain Kennedy <iain@psand.net>
Subject: Re: hdspmixer issues
Date: Mon, 20 Sep 2004 21:09:18 +0100 (BST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0409202101350.2974@tallow.psand.net>
Reply-To: iain@psand.net
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> > I"ve been messing with hdsp (again :-) and found out that my hdspmixer
> > has very oddly behaving sound meters. While the input (2nd row)
> > appears to be more or less ok (the yellow peak things kind of fly all
> > over the place and often drop off below green lines or even completely
> > dissapear), the analog outputs as well as combined monitoring output
> > (front 1/4" phono jack on the multiface) only occassionally spike with
> > a line input (usually only one channel). I am wondering why this is so
> > since the audio is definitely working ok, but the monitoring of the
> > outputs simply isn"t working (at least not visually).
>
> i"ve been experiencing similar spikes on the analog outputs as ico
> described. since we had a somehow similar problem with screwed up pci
> cycles that was caused by incorrect initialisation of the cardbus briges
> on our machines, i somehow doubt that it"s related to the problem we
> had.

> cheers...

I've been experiencing lack of/sporadic metering on hdspmixer too..
I'm running Debian testing with kernel 2.6.8 (same effect with 2.6.3),
with both the debian alsa packages and a locally compiled latest alsa
version...

I had no such problem using 2.4.xx series kernels, although I was using a
pre-1.06 version of the alsa drivers..

I really don't want to start rolling my system back to older kernels, but
if thats what has to happen, so be it.

I've tried fiddling with PCI latencies and I've also tested the hdspmixer
using OS/X to see whether it is some bizarre heat related h/w problem
(it's damned hot in this bus!)

There is no appreciable quality problems with the routed audio, but it's a
bit disconcerting not being able to see levels (and a bit embarrasing
doing live events!)

If anybody has any further information on this, or wants me to provide
more information, let me know.

Regards,

Iain


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php

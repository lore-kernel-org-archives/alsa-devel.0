From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: [Alsa-user] 2.6 kernel
Date: Tue, 9 Dec 2003 10:35:41 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0312091029050.20863@pnote.perex-int.cz>
References: <200312091616.23281.markc@renta.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from pnote.perex-int.cz (194.149.109.108.adsl.nextra.cz [194.149.109.108])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id KAA28673
	for <alsa-devel@alsa-project.org>; Tue, 9 Dec 2003 10:36:52 +0100
In-Reply-To: <200312091616.23281.markc@renta.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Mark Constable <markc@renta.net>
Cc: alsa-user@lists.sourceforge.net, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 9 Dec 2003, Mark Constable wrote:

> Some queries about the latest 2.6 kernels...
> 
> I presume the "alsa" part that comes with a 2.6 kernel is only
> the equiv of the alsa-driver package so do I still need to get
> alsa-lib and alsa-utils from somewhere else ?

Yes, from our main site - http://www.alsa-project.org .

> If so, then do I have to determine which particular version is
> in the kernel and then source the same versioned lib/utils packages ?

Version is available in linux/include/sound/version.h

> What is the difference between /usr/include/sound/* and
> /usr/src/linux/include/sound/* and where might "<asound/asoundlib.h>"
> be that some packages need for compiling ?

ALSA library has a copy of kernel header files and it is backwards
compatible with ALSA code 0.9 final (which is also in the 2.6 kernel 
tree). In other words, you can use 1.0 packages without any problems.

> Is there some sane method to intergrate ALSA from CVS into whatever
> is the latest 2.6 kernel source tree... how ?

ftp://ftp.alsa-project.org/pub/kernel-patches .

or (use BitKeeper):

bk pull http://linux-sound.bkbits.net/linux-sound

or

simply copy files from the ALSA's alsa-kernel CVS module to relevant 
locations in the 2.6 kernel tree.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/

From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Something wrong with snd_pcm_avail_update
Date: Wed, 24 Sep 2008 10:58:41 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0809241055160.26850@tm8103-a.perex-int.cz>
References: <20080924001954.GA5422@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 6EA8324396
	for <alsa-devel@alsa-project.org>;
	Wed, 24 Sep 2008 10:58:42 +0200 (CEST)
In-Reply-To: <20080924001954.GA5422@tango.0pointer.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lennart Poettering <mznyfn@0pointer.de>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 24 Sep 2008, Lennart Poettering wrote:

> Heya!
> 
> There seems to be something wrong with snd_pcm_update_avail() for mmap
> in recent 2.6.26 kernels:
> 
> Quoting Alexander Gavrilov:
> 
> <snip>
> Fedora 9 with kernel 2.6.26.3-29 exhibits a bug where
> the driver decrements its hw.ptr under certain stress
> conditions, or at least it appears so from debugging.
> 
> It causes alsa-lib to give absurdly huge avail numbers
> to pulseaudio, which crashes it. This patch adds a
> work-around to avoid such unfriendly behavior until
> the bug is fixed.
> 
> As this is not a real fix, it displays a message every
> time it is activated.
> </snip>
> 
> https://bugzilla.redhat.com/show_bug.cgi?id=462200
> 
> (see the patch attached to that bug report)
> 
> Takashi, Jaroslav, do you know anything about this?

If it's HDA hardware, the user might try to test the recent linux kernels 
or the ALSA driver compiled from tarball available on 
www.alsa-project.org. The hw position routines were improved recently for 
the HDA driver.

					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.

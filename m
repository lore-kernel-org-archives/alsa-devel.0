From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: alsa-pulse plugin
Date: Tue, 2 Feb 2010 08:43:21 +0100
Message-ID: <20100202074321.GC14209@tango.0pointer.de>
References: <4f3252891002010028u338830d4jba98dae1d383bb97@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id AC39F1037EE
	for <alsa-devel@alsa-project.org>; Tue,  2 Feb 2010 08:43:46 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4f3252891002010028u338830d4jba98dae1d383bb97@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 01.02.10 16:28, Raymond Yau (superquad.vortex2@gmail.com) wrote:

> When try to abort aplay -D pulse any.wav  in a terminal  on Fedora 12
> 
> the following error appear on some occasion and the terminal hang
> 
> aplay -v any.wav
> ,,,
>  ^CAborted by signal Interrupt...
> Assertion 'pthread_mutex_destroy(&m->mutex) == 0' failed at
> pulsecore/mutex-posix.c:83 function pa_mutex_free(). Aborting
> Aborted by signal Aborted....
> *** glibc detected *** aplay: double free corruption(top): 0x09e69708 ****
> *** glibc detected *** aplay corrupted double-linked list : 0x09e5dcb8 ***

Hmm, we had a couple of issues with PI mutex support being broken in
glibc that could result in errors like this, but that should now be
fixed in F12. Please update to the latest F12, then install debuginfo
symbols and try to reproduce within valgrind. Please file the output
as bug in rhbz against the alsa-plugins package!

Thank you,

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net
http://0pointer.net/lennart/           GnuPG 0x1A015CC4

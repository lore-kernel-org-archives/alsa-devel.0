From: Glenn Maynard <g_sf@zewt.org>
Subject: Re: Improving wine support for alsa.
Date: Thu, 6 May 2004 19:42:48 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040506234248.GB30822@zewt.org>
References: <409A80DC.2080601@superbug.demon.co.uk> <opr7lnga2ffmr65f@mail.broadpark.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from h0040333b7dc3.ne.mediaone.net (postfix@h00045a576c6a.ne.client2.attbi.com [65.96.98.23])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id BAA16072
	for <alsa-devel@alsa-project.org>; Fri, 7 May 2004 01:42:57 +0200
Content-Disposition: inline
In-Reply-To: <opr7lnga2ffmr65f@mail.broadpark.no>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, May 07, 2004 at 12:30:00AM +0200, Arve Knudsen wrote:
> James, I don't know if this is of any help, but you could always have a  
> peek at the PortAudio (www.portaudio.com) code (pa_linux_alsa.c). We don't  
> use snd_pcm_async_handler though, but implement async and blocking IO  
> ourselves.

It looks like SND_PCM_ASYNC isn't used, and SIGIO is never handled;
instead, it just poll()s.

Kernel people: is poll() less effective than using SND_PCM_ASYNC and a
signal handler for low-latency sound?  I'm guessing it is, but there
isn't much documentation for doing low-latency sound in ALSA, or about
the Linux kernel's treatment of SIGIO.  (I'd expect that SIGIO would be
triggered from an interrupt, but poll() wouldn't wake up as quickly,
but I'm not sure.)

-- 
Glenn Maynard


-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3

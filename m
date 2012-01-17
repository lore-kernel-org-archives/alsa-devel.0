From: Elias Kokkinis <ekokkinis@upatras.gr>
Subject: Re: [Alsa-user] Read and write with different output
	sizes
Date: Tue, 17 Jan 2012 18:31:06 +0200
Message-ID: <1696F737-024C-4A64-AA69-A6EDEA407CCA@upatras.gr>
References: <C9D5747C-1206-4E64-88A8-14AA803FDA56@upatras.gr>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nic.upatras.gr (nic.upatras.gr [150.140.129.30])
	by alsa0.perex.cz (Postfix) with ESMTP id 9F3832461C
	for <alsa-devel@alsa-project.org>; Tue, 17 Jan 2012 17:31:09 +0100 (CET)
In-Reply-To: <C9D5747C-1206-4E64-88A8-14AA803FDA56@upatras.gr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-user@lists.sourceforge.net
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Dear all,

after some further research into the matter, it seems I have to do some asynchronous capture/playback with ALSA.

I have searched for examples and found this site:
http://alumnos.elo.utfsm.cl/~yanez/alsa-sample-programs/
where two example programs are included.

microphone.c and speaker.c which use almost all available input/output modes in ALSA. The interesting thing is that you can run both programs concatenated since they write and read to the standard output and create a simple audio loop-back. 

I have tested different configurations and the configuration I want works with direct and asynchronous read/write with mmap and read/write with poll.

Now I have taken the bits and pieces of those to programs and I have tried to create a single program that will read and write with different buffer sizes. I can't seem to be able to "reroute" the write from the standard output [these programs use write() and read()] to a buffer, or the read from the standard input to a buffer. 

Any ideas? Comments? 

I thank everyone for their time,
Elias

On 16 Jan 2012, at 12:53, Elias Kokkinis wrote:

> Hello all,
> 
> I am posting a question I previously posted in alsa-devel, but did not get the expected feedback.
> 
> I am using alsa drivers in an OMAP3530 processor to do some audio processing. I am implementing a typical speech enhancement algorithm with overlap-add. I use a window length of 2048 samples and an overlap of 1024 samples. That means I need to use an input (capture) buffer of 2048 and an output (playback) buffer of 1024. Can this be configured in alsa? Can the playback and capture streams have different buffer sizes, but operate at the same sample rate (e.g. 44100Hz)?
> 
> Best regards,
> Elias
> ------------------------------------------------------------------------------
> RSA(R) Conference 2012
> Mar 27 - Feb 2
> Save $400 by Jan. 27
> Register now!
> http://p.sf.net/sfu/rsa-sfdev2dev2
> _______________________________________________
> Alsa-user mailing list
> Alsa-user@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-user

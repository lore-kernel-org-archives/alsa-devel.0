From: Jaroslav Kysela <perex@perex.cz>
Subject: Re:
	=?utf-8?q?Warning/error_from_ALSA=E2=80=99s_pcm=5Fmi?=
	=?utf-8?q?n=2Ec_example=2E_Possible_problem=3F?=
Date: Fri, 29 Oct 2010 09:19:55 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1010290917270.29422@eeebox2.perex-int.cz>
References: <AANLkTinTsGB4WB16xfkrvjueMGhQtTWPBbUNAuYVbZVv@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 02808245B8
	for <alsa-devel@alsa-project.org>;
	Fri, 29 Oct 2010 09:19:56 +0200 (CEST)
In-Reply-To: <AANLkTinTsGB4WB16xfkrvjueMGhQtTWPBbUNAuYVbZVv@mail.gmail.com>
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
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, 29 Oct 2010, Raymond Yau wrote:

>>> On Sat, 30 Jan 2010, Louise Hoffman wrote:
>
>>> Dear ALSA developers,
>>>
>>> When I compile ALSA's pcm_min.c[0] example with
>>>
>>> gcc -Wall -lasound pcm_min.c -o pcm_min
>>>
>>> Everything is fine, but running it, I get the white noise as expected,
>>> but I also get this warning/error:
>>>
>>> Short write (expected 16384, wrote 7616)
>
>> It was a bug in alsa-lib. I fixed it in patch bellow. Thank you for your
>> report.
>
>> http://git.alsa-project.org/?p=alsa-lib.git;a=commitdiff;h=2e48439ad93f6c8d99a2d72928ac71285b5211bb <http://git.alsa-project.org/?p=alsa-lib.git;a=commitdiff;h=2e48439ad93f6c8d99a2d72928ac71285b5211bb>
>
> Add snd_pcm_dump() after call snd_pcm_set_params in pcm_min.c
>
> The start threshold is equal to buffer size , so there should be a
> short write at the second write since
> 16384 + 7616 = 24000  ( start threshold )
>
> your patch had changed the behaviour

The pcm_min uses the blocked mode, so all layers tries to queue all given 
samples and wait for the ring buffer.

>  buffer_size  : 24000
>  start_threshold  : 24000

> state = 2
> write 16384 frames
> state = 2
> write 16384 frames
> state = 3

This looks correct.

 					Jaroslav


-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.

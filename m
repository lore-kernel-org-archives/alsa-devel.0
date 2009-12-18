From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Play multiple sounds concurrently
Date: Fri, 18 Dec 2009 15:02:51 +0100
Message-ID: <4B2B8B8B.505@ladisch.de>
References: <4B2B873E.6010906@avibit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 4884110390F
	for <alsa-devel@alsa-project.org>; Fri, 18 Dec 2009 15:02:54 +0100 (CET)
In-Reply-To: <4B2B873E.6010906@avibit.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Markus Luttenberger <m.luttenberger@avibit.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Markus Luttenberger wrote:
> I want to play multiple sounds concurrently with ALSA. The audio data is 
> mono and G.711 a-law encoded. I can successfully play a single source of 
> audio data but the sound is distorted when I try to play two sources.
> 
>    wr_buf[count] = (char) (0.5 * buf1[count]) +
>                    (char) (0.5 * buf2[count]);

A-law is a somewhat logarithmic encoding; simply adding two values with
linear scale factors will not work.

If both your source data and the output device use A-law, you have to
decode the samples to linear PCM, add them, and encode them back.  See
<http://git.alsa-project.org/?p=alsa-lib.git;a=blob;f=src/pcm/pcm_alaw.c;hb=HEAD>
for the algorithm that alsa-lib uses; you would use something like
buf[] = s16_to_alaw((alaw_to_s16(buf1[]) + alaw_to_s16(buf2[])) / 2);

If it is possible for your output device to use a linear PCM format,
you might want to use that to avoid the additional encoding step.


HTH
Clemens

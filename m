From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Custom card returns "arecord: main:722: audio
	open	error: Invalid argument"
Date: Sun, 29 May 2016 13:09:23 +0200
Message-ID: <017a406d-861c-6202-dd83-f9ce7c7655a3@ladisch.de>
References: <CALAeOVPgNxX-0OeDm7a+Y2OMa7XHZ9SnZ4czHbKo9Uzdfayb3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id EB7E8260535
 for <alsa-devel@alsa-project.org>; Sun, 29 May 2016 13:09:27 +0200 (CEST)
In-Reply-To: <CALAeOVPgNxX-0OeDm7a+Y2OMa7XHZ9SnZ4czHbKo9Uzdfayb3Q@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rob Nertney <rob@rob-otics.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Rob Nertney wrote:
> static struct snd_pcm_hardware my_pcm_hw =
> {
>   .info = (SNDRV_PCM_INFO_MMAP |
>       SNDRV_PCM_INFO_BLOCK_TRANSFER |
>       SNDRV_PCM_INFO_MMAP_VALID),

You must set one of INTERLEAVED, NONINTERLEAVED, or COMPLEX.
(And a single channel should be marked interleaved.)


Regards,
Clemens

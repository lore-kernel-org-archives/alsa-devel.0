From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Increasing maximum sampling frequency?
Date: Wed, 27 May 2009 22:34:39 -0400
Message-ID: <75b66ecd0905271934m7299c4x43be0b79af24300d@mail.gmail.com>
References: <4A1DED36.4030008@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f175.google.com (mail-ew0-f175.google.com
	[209.85.219.175])
	by alsa0.perex.cz (Postfix) with ESMTP id 3BDDC244D9
	for <alsa-devel@alsa-project.org>;
	Thu, 28 May 2009 04:34:40 +0200 (CEST)
Received: by ewy23 with SMTP id 23so5162388ewy.32
	for <alsa-devel@alsa-project.org>; Wed, 27 May 2009 19:34:39 -0700 (PDT)
In-Reply-To: <4A1DED36.4030008@cse.unsw.edu.au>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Cameron Stone <camerons.lists@cse.unsw.edu.au>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, May 27, 2009 at 9:47 PM, Cameron Stone
<camerons.lists@cse.unsw.edu.au> wrote:
> I've got a USB microphone application that I want to sample at 256000 8
> bit samples per second so I can listen to bats. I know that my device
> can get close to that rate, but alsa seems to restrict sampling rates to
> 192kHz.
>
> Is it possible to push the maximum sampling frequency higher? If so,
> where should I start looking?
>

For starters, try adding a 256K sample rate to include/sound/pcm.h:

 118 #define SNDRV_PCM_RATE_176400           (1<<11)         /* 176400Hz */
 119 #define SNDRV_PCM_RATE_192000           (1<<12)         /* 192000Hz */
 120

and sound/core/pcm_native.c:

1762
1763 static unsigned int rates[] = { 5512, 8000, 11025, 16000, 22050,
32000, 44100,
1764                                  48000, 64000, 88200, 96000,
176400, 192000 };
1765

Line numbers may vary, mine are from 2.6.27 kernel source.

Lee

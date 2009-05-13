From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: WM9712 - Big and little endian format conversion.
Date: Wed, 13 May 2009 14:18:43 -0400
Message-ID: <9e4733910905131118o6d96c02au3907b3f6cd5203b2@mail.gmail.com>
References: <9e4733910905131055v4eb487dhf5d410ae5d6b1a52@mail.gmail.com>
	<20090513175959.GB27909@sirena.org.uk>
	<9e4733910905131108n4e109dc5xd4c11056b95b33a4@mail.gmail.com>
	<20090513181448.GA23738@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.148])
	by alsa0.perex.cz (Postfix) with ESMTP id A573F1038BD
	for <alsa-devel@alsa-project.org>;
	Wed, 13 May 2009 20:18:45 +0200 (CEST)
Received: by qw-out-1920.google.com with SMTP id 4so564220qwk.56
	for <alsa-devel@alsa-project.org>; Wed, 13 May 2009 11:18:44 -0700 (PDT)
In-Reply-To: <20090513181448.GA23738@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, May 13, 2009 at 2:14 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Wed, May 13, 2009 at 02:08:19PM -0400, Jon Smirl wrote:
>> On Wed, May 13, 2009 at 1:59 PM, Mark Brown
>
>> > In this specific case there's now a standard define for the AC97 codecs
>> > to use for the formats in current ASoC, add all the formats supported by
>> > your CPU to that and all the AC97 codecs will pick it up automatically.
>> > It's called SND_SOC_STD_AC97_FMTS, defined in the DAI header file.
>
>> Which tree is this in?
>
> It's in -next now so it can be seen in Takashi's tree and mine as well
> - it's commit 33f503c96c976fd585dedb76514ca6cb286e60d9.
>

Adding S32_BE works for me:

#define SND_SOC_STD_AC97_FMTS (SNDRV_PCM_FMTBIT_S16_LE |\
                               SNDRV_PCM_FMTBIT_S32_LE |\
                               SNDRV_PCM_FMTBIT_S32_BE)


-- 
Jon Smirl
jonsmirl@gmail.com

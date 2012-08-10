From: Fabio Estevam <festevam@gmail.com>
Subject: Re: Error with "Unsigned 8 bit, Rate 8000 Hz,
	Mono" track
Date: Fri, 10 Aug 2012 09:52:30 -0300
Message-ID: <CAOMZO5CdyZ8ONK+iOK-UVnL-K02gCP7-w6Aoj+cL-1g=K0B0rQ@mail.gmail.com>
References: <CAOMZO5Dc38HSZRXFeZ-55KN83v1NNPCAAuoiFdixJ0K2dw90vg@mail.gmail.com>
 <20120810110004.GA7142@shlinux2.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
 [209.85.213.51])
 by alsa0.perex.cz (Postfix) with ESMTP id BEEFC26651D
 for <alsa-devel@alsa-project.org>; Fri, 10 Aug 2012 14:22:45 +0200 (CEST)
Received: by yhnn12 with SMTP id n12so1406071yhn.38
 for <alsa-devel@alsa-project.org>; Fri, 10 Aug 2012 05:52:30 -0700 (PDT)
In-Reply-To: <20120810110004.GA7142@shlinux2.ap.freescale.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dong Aisheng <b29396@freescale.com>
Cc: Shawn Guo <shawn.guo@linaro.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Lauri Hintsala <lauri.hintsala@bluegiga.com>
List-Id: alsa-devel@alsa-project.org

On 8/10/12, Dong Aisheng <b29396@freescale.com> wrote:
> On Fri, Aug 10, 2012 at 12:25:13PM +0800, Fabio Estevam wrote:
>> Hi,
>>
>> Running 3.6-rc1 on a mx28evk I get the following error with this wav
>> format:
>>
>> root@freescale /home$ aplay k3b_error1.wav
>> Playing WAVE 'k3b_error1.wav' : Unsigned 8 bit, Rate 8000 Hz, Mono
>> [  303.640000] asoc: machine hw_params failed: -22
> It failed at here:
> /* Sgtl5000 sysclk should be >= 8MHz and <= 27M */
> if (mclk < 8000000 || mclk > 27000000)
> 	return -EINVAL;
>
> Since sgtl5000 on slave mode, the mclk can only be 256*fs, 384*fs, 512*fs,
> the maximum mclk of 8Khz 4096000(512 * 8000) < 8Mhz, it does not meet
> the minimum clock requirement of mclk.
> It looks like hw limitation on slave mode.

I can play this file on a mx51evk and mx6qsabrelite boards, which also
uses a sgtl5000.

So it looks like a mxs issue, right?

Thanks,

Fabio Estevam

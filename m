From: "christian pellegrin" <chripell@gmail.com>
Subject: Re: possible problem in s3c24xx-pcm.c in git-devel
	branch
Date: Fri, 14 Nov 2008 17:20:35 +0100
Message-ID: <cabda6420811140820y23de807fwbc064ce82c011f2c@mail.gmail.com>
References: <cabda6420811130657k4079884cge643c1b33b319b14@mail.gmail.com>
	<20081113151701.GG31592@sirena.org.uk>
	<cabda6420811130740u325cf60bse8401af768fb7340@mail.gmail.com>
	<20081113160936.GH31592@sirena.org.uk>
	<20081114124640.GB25307@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.251])
	by alsa0.perex.cz (Postfix) with ESMTP id 5D20924149
	for <alsa-devel@alsa-project.org>; Fri, 14 Nov 2008 17:20:37 +0100 (CET)
Received: by rv-out-0708.google.com with SMTP id f25so1549495rvb.32
	for <alsa-devel@alsa-project.org>; Fri, 14 Nov 2008 08:20:35 -0800 (PST)
In-Reply-To: <20081114124640.GB25307@sirena.org.uk>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: David Anders <dave123_aml@yahoo.com>, alsa-devel@alsa-project.org, Ben Dooks <ben-linux@fluff.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 14, 2008 at 1:46 PM, Mark Brown <broonie@sirena.org.uk> wrote:
>
> More info provided by Dave on IRC:
>
> 15:46 < prpplague> now the big difference between the 2410 and 2440 is ofcourse
>                   the primary clock, the 2410 generally running 200mhz whereas
>                   the 2440 is at 400mhz
>
>

Hi,

to say the truth I never saw problems on the S3c2440 custom board @
400Mhz I worked with initially:

CPU S3C2440A (id 0x32440001)
S3C244X: core 399.651 MHz, memory 133.217 MHz, peripheral 66.608 MHz

Right now I cannot do much complete audio testing with it (the audio
part after the codec is crippled) but I can test if dma starts and if
audio playing last the right number of seconds. My initial patch was
against 2.6.27 so without the limitation on the maximum period
initially loading but I remembered that there were only 2 buffers
loaded because the lower level dma enqueue function returned error
after that. I never saw problems with aplay and madplay.

I will try to do some changes in that code but my worry is how to know
how many periods are filled with data for sure by the upper ALSA
layers (I'm not an expert in ASLA as you can see).


-- 
Christian Pellegrin, see http://www.evolware.org/chri/
"Real Programmers don't play tennis, or any other sport which requires
you to change clothes. Mountain climbing is OK, and Real Programmers
wear their climbing boots to work in case a mountain should suddenly
spring up in the middle of the computer room."

From: Liam Girdwood <lrg@ti.com>
Subject: Re: Soc-DSP / Dynamic PCM
Date: Fri, 27 Apr 2012 17:22:40 +0100
Message-ID: <1335543760.4150.22.camel@odin>
References: <A3217089E06965468FCEC60ADC3A8F925BF9991210@EXDCVYMBSTM006.EQ1STM.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog123.obsmtp.com (na3sys009aog123.obsmtp.com
	[74.125.149.149])
	by alsa0.perex.cz (Postfix) with ESMTP id AD479244C9
	for <Alsa-devel@alsa-project.org>;
	Fri, 27 Apr 2012 18:22:45 +0200 (CEST)
Received: by wera1 with SMTP id a1so633561wer.20
	for <Alsa-devel@alsa-project.org>; Fri, 27 Apr 2012 09:22:42 -0700 (PDT)
In-Reply-To: <A3217089E06965468FCEC60ADC3A8F925BF9991210@EXDCVYMBSTM006.EQ1STM.local>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sebastien LEDUC <sebastien.leduc@stericsson.com>
Cc: "Alsa-devel@alsa-project.org" <Alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 25 April 2012 09:08, Sebastien LEDUC <sebastien.leduc@stericsson.com> wrote:
> Hi
> I have seen some discussion on the mailing list about upcoming changes in ASoC for soc-dsp support / dynamic PCM.
> Could somebody explain what is the purpose of these changes?

The purpose is to support on SoC DSP devices that can route digital
audio from ALSA PCM devices to multiple SoC DAIs at runtime (like OMAP4
ABE).

> Is there a branch where I can have a look to the on-going work?
>

Sure, my TI lrg/topic/3.5-rebase ABE branch is probably best to take a
look atm as it shows the ABE and DPCM code together.

gitorious.org:omap-audio/linux-audio.git

You can also try the code if you have a Pandaboard.

Regards

Liam

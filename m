From: Shine Liu <shinel@foxmail.com>
Subject: Re: [PATCH] ASoC: s3c24xx platform: Fix
 s3c2410_dma_started called at wrong time
Date: Sun, 23 Aug 2009 19:37:13 +0800
Message-ID: <1251027433.732.42.camel@sl>
References: <1250761331.4412.70.camel@shinel>
	<20090820101549.GA23141@rakim.wolfsonmicro.main>
	<1250769588.3684.28.camel@sl> <20090820121851.GB11699@sirena.org.uk>
	<1250775480.1404.19.camel@sl>
	<20090820145207.GA25143@rakim.wolfsonmicro.main>
	<1250783107.1404.70.camel@sl> <20090820184714.GD5032@sirena.org.uk>
	<1250848839.3928.6.camel@shinel>
	<20090823102841.GA737@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpbg93.qq.com (smtpbg93.qq.com [119.147.10.252])
	by alsa0.perex.cz (Postfix) with SMTP id 9B4CB24150
	for <alsa-devel@alsa-project.org>;
	Sun, 23 Aug 2009 13:37:41 +0200 (CEST)
In-Reply-To: <20090823102841.GA737@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, ben-linux@fluff.org
List-Id: alsa-devel@alsa-project.org


> 
> This isn't quite what I was expecting - what I was expecting was more
> that the I2S driver would set up a function on startup which would be
> called by the ASoC DMA driver from its trigger function.  It does look
> like a reasonable approach, though.

Yes, I understand what you exactly want. I was intend to register the
callback function on I2S startup, but finally I found it is not possible
because there are two callback functions for the DMA driver:
s3c24xx_snd_txctrl() and s3c24xx_snd_rxctrl(), however, there's only one
slot for the callback function. So I choose not to setup the callback
functions dynamicly, when the task is playback, the callback funtion is
s3c24xx_snd_txctrl() and when the task is record, the funtion is
s3c24xx_snd_rxctrl().

However, there's another way to archive what you expect: combine the
s3c24xx_snd_txctrl() and s3c24xx_snd_rxctrl() into one function. That
would be like:

struct s3c24xx_snd_ctrl_data {
	int event;	//start or stop
	int direction;	//playback or record
};

static void s3c24xx_snd_ctrl(struct s3c24xx_snd_ctrl_data* data)
{
	if(data->direction == SNDRV_PCM_STREAM_PLAYBACK)
		s3c24xx_snd_txctrl(data->event);
	eles
		s3c24xx_snd_rxctrl(data->event);
}

Then we can register this callback funtion on I2S startup.

> 
> The way you've got things at the minute at least all the other S3C ASoC
> drivers will need to be updated to match the change in the DMA driver.
> 

I have posted the DMA driver patch to linux-arm-kernel yesterday:
http://lists.arm.linux.org.uk/lurker/message/20090822.153940.e15e3bd7.en.html

Hope there is no problem to merge the patch.

If the dma patch is accepted, I will post a formal patch here for ASoC
S3C24XX.

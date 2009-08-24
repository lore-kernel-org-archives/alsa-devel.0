From: Shine Liu <shinel@foxmail.com>
Subject: Re: [PATCH] ASoC: s3c24xx platform: Fix
 s3c2410_dma_started called at wrong time
Date: Mon, 24 Aug 2009 19:54:40 +0800
Message-ID: <1251114880.3676.41.camel@shinel>
References: <20090820101549.GA23141@rakim.wolfsonmicro.main>
	<1250769588.3684.28.camel@sl> <20090820121851.GB11699@sirena.org.uk>
	<1250775480.1404.19.camel@sl>
	<20090820145207.GA25143@rakim.wolfsonmicro.main>
	<1250783107.1404.70.camel@sl> <20090820184714.GD5032@sirena.org.uk>
	<1250848839.3928.6.camel@shinel>
	<20090823102841.GA737@opensource.wolfsonmicro.com>
	<1251027433.732.42.camel@sl>
	<20090824101733.GA3591@rakim.wolfsonmicro.main>
Reply-To: shinel@foxmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpbg69.qq.com (smtpbg69.qq.com [119.147.10.228])
	by alsa0.perex.cz (Postfix) with SMTP id CE4152462E
	for <alsa-devel@alsa-project.org>;
	Mon, 24 Aug 2009 13:55:13 +0200 (CEST)
In-Reply-To: <20090824101733.GA3591@rakim.wolfsonmicro.main>
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


> ...but there's no need for the struct, just pass two arguments to the
> function, the event and either the substream or the direction.  The
> substream is probably easier since otherwise all the callers will need
> to parse the direction.

Finally, I decide to place the callback function in struct
s3c2410_dma_client instead of add a new struct:

 struct s3c2410_dma_client {

       ....

       /* callback funtion from client to generate the DMA REQ signal */
       int (*gen_request)(void *);

       /* callback funtion from client to end the DMA request */
       int (*end_request)(void *);

       /* argument for the callback function */
       void            *private_data;
 };

I think the callback function should have only one argument. If we have
more than one argument to pass, just embbed them into a internal struct
known to the callback funtions and pass the pointer to the object of
this struct to the callback function. 

If not, more filed will be needed in struct s3c2410_dma_client to place
the arguments. I think it's redundant for the generic DMA driver.

I've posted five new patches which regist the callback functions either
in the I2S/AC97 probe phase or by directly assiged in the source code
depended by whether the callback functions and the object of struct
s3c2410_dma_client are in the same source file.

Look forward for further comments on these patches. There should be some
defects in them.

Thanks.

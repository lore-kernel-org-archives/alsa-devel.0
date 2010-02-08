From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: DMA interrupt not getting triggered(nailed
	the	problem need solution)
Date: Mon, 8 Feb 2010 11:27:00 +0000
Message-ID: <20100208112659.GB12780@sirena.org.uk>
References: <4218975.894361265627821377.JavaMail.weblogic@epml09>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id F3F5D2413B
	for <alsa-devel@alsa-project.org>; Mon,  8 Feb 2010 12:27:04 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4218975.894361265627821377.JavaMail.weblogic@epml09>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ANISH KUMAR <anish.singh@samsung.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, jassi brar <jassisinghbrar@gmail.com>, "ben-linux@fluff.org" <ben-linux@fluff.org>, "JaroslavKyselaperex@perex.cz" <JaroslavKyselaperex@perex.cz>
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 08, 2010 at 11:17:01AM +0000, ANISH KUMAR wrote:

> >If the initial hardware state happens to result in LRCLK being where the
> >lrsync() function is trying to get it then the driver will start up, but
> >the misclocking of the configuration will result in ALSA detecting an
> >error which will eventually result in a restart of the audio stream.

> Mark in my case it is not restarting the audio stream(though it is trying to call trigger again for restarting) 
> because in s3c_snd_lrsync function again i am getting time out(ETIMEDOUT).

...and the reason it is back in lrsync() is that it's trying to restart
the audio stream.

> This LRI register bit is not getting set properly causing timeout.How this situation is not coming always(4/10)??
> And who should suppose to set it?

The LRI register reports the hardware state and so is updated
autonomously by the hardware.

> If my machine driver had a problem then this should have come always??

As I said in the e-mail to which you are replying:

| If the initial hardware state happens to result in LRCLK being where the
| lrsync() function is trying to get it then the driver will start up, but
| the misclocking of the configuration will result in ALSA detecting an
| error which will eventually result in a restart of the audio stream.

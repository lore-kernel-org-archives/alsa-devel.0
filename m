From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: DMA interrupt not getting triggered(nailed
	the	problem need solution)
Date: Mon, 8 Feb 2010 11:05:16 +0000
Message-ID: <20100208110515.GA12780@sirena.org.uk>
References: <15824817.821301265596468706.JavaMail.weblogic@epml09>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 454B72446A
	for <alsa-devel@alsa-project.org>; Mon,  8 Feb 2010 12:05:19 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <15824817.821301265596468706.JavaMail.weblogic@epml09>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, jassi brar <jassisinghbrar@gmail.com>, "JaroslavKyselaperex@perex.cz" <JaroslavKyselaperex@perex.cz>, ben-linux@fluff.org
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 08, 2010 at 02:34:29AM +0000, ANISH KUMAR wrote:

> This problem is due to ETIMEDOUT(timeout) happening in s3c_snd_lrsync function(called by trigger).

Please don't start a new thread for each mail, please continue
discussion in the existing thread.  It makes it much easier to follow
which problem you are talking about.

> As i understand this could be due I2S being broken. This basically happens because 
> of improper initialization of CPU or CODEC.

> But if that is the case then it would not have produced sound initially also but that
> is not the case(initially it is ringing i.e. interrupt coming for a short time then after i am getting time out problem)??

If the initial hardware state happens to result in LRCLK being where the
lrsync() function is trying to get it then the driver will start up, but
the misclocking of the configuration will result in ALSA detecting an
error which will eventually result in a restart of the audio stream.

> Please provide any pointers which can help me out.

You've probably got a problem with the machine driver for your system,
check the way the clocks are set up in there.

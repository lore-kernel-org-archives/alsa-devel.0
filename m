From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Questions about /dev/snd and /proc/asound (new
	ASoC driver)
Date: Fri, 8 Aug 2008 12:43:34 +0100
Message-ID: <20080808114334.GB17329@sirena.org.uk>
References: <489B6322.8080307@videotron.qc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id B54C524ADF
	for <alsa-devel@alsa-project.org>;
	Fri,  8 Aug 2008 13:43:35 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <489B6322.8080307@videotron.qc.ca>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Simon Tremblay <bidou@videotron.qc.ca>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 07, 2008 at 05:03:30PM -0400, Simon Tremblay wrote:

> I read documentation in sound/soc and created a codec driver
> (tlv320aic23b) and a machine driver (for my board). I think it's all I
> have to do since AT91 is supported and tlv320aic23b works with i2c and I2S.

That should be it, yes.

> But there is no /dev/snd created. I don't know for now why... Maybe
> someone has an idea?

This is the responsibility of user space - to create files dynamically
usually one of udev or mdev will be installed on the device.

> I think all I have in /proc/asound is correct too:

udev and mdev rely on the information in /sys/class/sound to create
device files - check the dev files in the directories under there.

> I think it's because I have nothing in /dev/snd. I'm right?

Yes.

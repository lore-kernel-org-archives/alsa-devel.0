From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC_iv/iv 1/1] ASoC: Add optional name_prefix to
 struct snd_soc_dev_map
Date: Mon, 1 Nov 2010 13:49:28 -0400
Message-ID: <20101101174927.GE24814@opensource.wolfsonmicro.com>
References: <1288353823-22075-1-git-send-email-jhnikula@gmail.com>
	<20101029214244.GK3921@opensource.wolfsonmicro.com>
	<20101031201243.3ef62461.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4BF37103826
	for <alsa-devel@alsa-project.org>; Mon,  1 Nov 2010 18:49:23 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20101031201243.3ef62461.jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Sun, Oct 31, 2010 at 08:12:43PM +0200, Jarkko Nikula wrote:

> I don't know would it fit to multi-DAI devices. Should those drivers
> differentiate inside their controls & widgets for different DAIs?

As previously discussed that's not going to be possible in general -
many of these devices will support mixing signals between the DAIs so
for many of the controls it won't be possible to associate them with any
particular DAI.  This can happen very early within the chip so means
that any per DAI naming ends up being ineffecitve.

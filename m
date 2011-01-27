From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 4/4] ASoC: Convert bunch of codecs to
	use	soc-core interconnect registration
Date: Thu, 27 Jan 2011 09:58:18 +0000
Message-ID: <20110127095817.GC1338@opensource.wolfsonmicro.com>
References: <1296043097-11720-1-git-send-email-jhnikula@gmail.com>
	<1296043097-11720-4-git-send-email-jhnikula@gmail.com>
	<4D411745.4070307@nokia.com>
	<20110127092116.e29f5cb1.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4A165103AAA
	for <alsa-devel@alsa-project.org>; Thu, 27 Jan 2011 11:23:06 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20110127092116.e29f5cb1.jhnikula@gmail.com>
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
Cc: alsa-devel@alsa-project.org, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 27, 2011 at 09:21:16AM +0200, Jarkko Nikula wrote:
> Peter Ujfalusi <peter.ujfalusi@nokia.com> wrote:

> > I don't see how these actually simplifies the codec drivers.
> > We had a single snd_soc_dapm_add_routes call before the patches, now we
> > have two fields to fill in snd_soc_codec_driver...

> Yeah, simplification comes only if a driver is checking the return value
> what most are not doing currently.

For me anything that moves things from code to data structures is a
simplification since it reduces the variation between drivers.  It's not
going to make a massive difference either way to the driver itself but
it makes life easier if you want to do something to all drivers.

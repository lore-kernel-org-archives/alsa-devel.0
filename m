From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC updates for 2.6.30
Date: Wed, 18 Feb 2009 12:29:54 +0000
Message-ID: <20090218122954.GA11336@opensource.wolfsonmicro.com>
References: <20090218120135.GA15414@sirena.org.uk>
	<s5hiqn8vsz4.wl%tiwai@suse.de> <s5hhc2svssv.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 83AEF10388D
	for <alsa-devel@alsa-project.org>; Wed, 18 Feb 2009 13:29:55 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hhc2svssv.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 18, 2009 at 01:22:08PM +0100, Takashi Iwai wrote:

> I get the following warning with my build test:
>     sound/soc/codecs/wm8731.c:611: warning: 'wm8731_unregister' defined but not used

> Could you fix it?

What config are you running - is CONFIG_I2C undefined?

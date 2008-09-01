From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] ASoC: Convert tlv320aic3x to a new-style
	i2c driver
Date: Mon, 1 Sep 2008 12:35:09 +0100
Message-ID: <20080901113508.GC2722@sirena.org.uk>
References: <20080901112131.08cdbb59@hyperion.delvare>
	<20080901143114.e98543a1.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id C0F3D24351
	for <alsa-devel@alsa-project.org>;
	Mon,  1 Sep 2008 13:35:13 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080901143114.e98543a1.jarkko.nikula@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: ext Jean Delvare <khali@linux-fr.org>, alsa-devel@alsa-project.org, Vladimir Barinov <vbarinov@ru.mvista.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 01, 2008 at 02:31:14PM +0300, Jarkko Nikula wrote:
> "ext Jean Delvare" <khali@linux-fr.org> wrote:

> Thanks. In N810 it's connected into second i2c bus so this makes it
> working

>  +	.i2c_bus = 2,

Should that be 1?  Normally the buses are numbered from zero...

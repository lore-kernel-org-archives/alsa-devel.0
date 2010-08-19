From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] Add support for tlv320aic3007
	to	tlv320aic3x driver
Date: Thu, 19 Aug 2010 10:47:45 +0100
Message-ID: <20100819094744.GA9307@sirena.org.uk>
References: <AANLkTinScuZVufiHO15uvBMrf4oPMAV=r__G72b=o2u8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 9FD7C24157
	for <alsa-devel@alsa-project.org>;
	Thu, 19 Aug 2010 11:47:46 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTinScuZVufiHO15uvBMrf4oPMAV=r__G72b=o2u8@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Randolph Chung <rchung42@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 19, 2010 at 02:19:16PM +0800, Randolph Chung wrote:
> The attached patch adds support for the tlv320aic3007 codec to the
> tlv320aic3x driver.
> 
> The tlv320aic3007 is similar to the aic31, but has an additional
> class-D speaker amp. The speaker amp control register overlaps with
> the mono output register of other codecs in this family, so we allow
> the board driver to pass in a model id to identify the codec being
> used.

Rather than passing something in the platform data you should use the
I2C device ID table for the device and have the board register the
device as a tlv320aic3007.

I would review the patch in more detail but you attached it as a base64
encoded attachment which means my MUA hasn't quoted it for me and won't
even display it unless I explicitly open it...  The main thing I noticed
was that you're using an enum instead of a TLV control for the amp
volume.

As I reminded you last time you always need to CC maintainers on
patches.  This is very helpful for ensuring that we actually see things
on busy lists and is helpful for keeping track of what needs reviewing.

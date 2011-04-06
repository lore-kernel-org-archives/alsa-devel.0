From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: synchronized block of register writes
Date: Thu, 7 Apr 2011 07:48:53 +0900
Message-ID: <20110406224851.GB5297@opensource.wolfsonmicro.com>
References: <B2150E1E4418E1438554A300EA5040E40DAC77494E@ITSVLEX06.it.maxim-ic.internal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D21C5103834
	for <alsa-devel@alsa-project.org>;
	Thu,  7 Apr 2011 00:48:46 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <B2150E1E4418E1438554A300EA5040E40DAC77494E@ITSVLEX06.it.maxim-ic.internal>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Hsiang <Peter.Hsiang@maxim-ic.com>
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 06, 2011 at 03:28:10PM -0700, Peter Hsiang wrote:

> Hi Mark and Everyone,

Fix your mailer to word wrap at 80 columns, I've reflowed your text.

> When a codec driver control handling function needs to write a group
> of registers without any other register of the same codec being
> written to in parallel by ALSA, what is the best way to do this under
> the snd-soc codec driver architecture?  In the current architecture,
> does the driver's control handling function execute serially with
> other ALSA automated activities?

The framework should be taking care of locking for you in most
situations.  If you implement custom controls you will want to take the
CODEC mutex while applying changes from them (most of the existing
drivers are lax about this) and similarly for IRQs.

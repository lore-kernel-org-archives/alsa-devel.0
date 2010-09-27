From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: how to mandate the use of PCM plugin?
Date: Sun, 26 Sep 2010 22:54:39 -0700
Message-ID: <20100927055438.GA13129@opensource.wolfsonmicro.com>
References: <4C9F6409.6010400@aknet.ru> <20100927005858.GD21247@sirena.org.uk>
	<4CA0221D.6030208@aknet.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id ACE6A1037F3
	for <alsa-devel@alsa-project.org>;
	Mon, 27 Sep 2010 07:54:21 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4CA0221D.6030208@aknet.ru>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stas Sergeev <stsp@aknet.ru>
Cc: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 27, 2010 at 08:48:29AM +0400, Stas Sergeev wrote:
> 27.09.2010 04:58, Mark Brown wrote:

> >What is the actual problem you are trying to solve here?  It's not

> What I am trying to solve, is the problem
> that people have with my snd-pcsp driver.
> Pulseaudio uses "hw" to bypass some pcm
> plugins, and then people are left with the
> non-functional softvol control, and they blame
> my driver.
> I am looking for the way to mandate the
> softvol plugin even for the "hw" device.

Why not work on fixing the actual problem if it's not already been
fixed?  I'm not clear from your description what that actually is but it
would seem much more generally useful to fix that.  This is far from the
only card with no hardware volume control and I'd imagine all will be
affected.

> Is this possible?

No, and it would still be unhelpful since it would leave you with two
soft volume controls in operation.

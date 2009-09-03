From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/3] ASoC: DaVinci: pcm,
	rename variables	in prep for ping/pong
Date: Thu, 3 Sep 2009 13:17:51 +0100
Message-ID: <20090903121750.GD2954@sirena.org.uk>
References: <1251761505-11353-1-git-send-email-troy.kisky@boundarydevices.com>
	<1251761505-11353-2-git-send-email-troy.kisky@boundarydevices.com>
	<20090902220152.GB4495@sirena.org.uk>
	<4A9F0A8C.1040509@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 72619244D7
	for <alsa-devel@alsa-project.org>;
	Thu,  3 Sep 2009 14:17:52 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4A9F0A8C.1040509@boundarydevices.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Troy Kisky <troy.kisky@boundarydevices.com>
Cc: avm@ti.com, davinci-linux-open-source@linux.davincidsp.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 02, 2009 at 05:15:08PM -0700, Troy Kisky wrote:
> Mark Brown wrote:

> > for the platform data to at most select the workaround only on CPUs that
> > have problems with channel swapping - it's going to cause confusion for
> > people to have it on by default.

> I think the ones without a problem use davinci-mcasp instead of davinci-i2s
> but share davinci-pcm. So, I don't know of any machines to exclude in davinci-i2s.
> But if someone else knows, speak up.

Oh, right.  That wasn't clear from what you were saying about newer
chips not being affected - if the fix was top drop the original IP block
in favour of the McASP that's OK.

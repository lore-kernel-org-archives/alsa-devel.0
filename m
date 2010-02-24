From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: issues porting codec to s3c2443
Date: Wed, 24 Feb 2010 17:54:20 +0000
Message-ID: <20100224175419.GI9018@sirena.org.uk>
References: <C171323BB93CB94897E300CBB6D4537F1D94251A@CLMSG-01.ad.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id D65B024436
	for <alsa-devel@alsa-project.org>; Wed, 24 Feb 2010 18:54:20 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <C171323BB93CB94897E300CBB6D4537F1D94251A@CLMSG-01.ad.cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Austin, Brian" <Brian.Austin@cirrus.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 24, 2010 at 11:43:41AM -0600, Austin, Brian wrote:

> sure that I am missing something because of that.  The question is, is
> it ok to submit the codec standalone and have someone look at it to make
> sure I made the correct changes.  No compiler warnings occur.  My port
> was based off of the WM8750 if that helps any

Yes, it's entirely normal to submit CODEC drivers that aren't referenced
by any machine drivers in mainline - please just go ahead and do this.

> soc-audio soc-audio: RXEN: Invalid MODE in IISMOD

...

> It seems that the S3C2412 I2S is not setup correctly for my platform.

It'd probably be easier for folks to help if you post your machine
driver...

From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Question about your DSP topic branch
Date: Wed, 26 Jan 2011 11:20:04 +0000
Message-ID: <20110126112004.GA5476@opensource.wolfsonmicro.com>
References: <4D2652C8.7030701@codeaurora.org> <4D3E7536.9070906@codeaurora.org>
	<20110125115113.GB13051@sirena.org.uk>
	<4D3FBDB1.90804@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8C17F24535
	for <alsa-devel@alsa-project.org>; Wed, 26 Jan 2011 12:19:47 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4D3FBDB1.90804@codeaurora.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Patrick Lai <plai@codeaurora.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 25, 2011 at 10:22:41PM -0800, Patrick Lai wrote:
> On 1/25/2011 3:51 AM, Mark Brown wrote:

> >Yes, that'd be kind of nice but given how tiny these noop drivers are
> >and the fact that they do all need to specify their capabilites it's not
> >clear that there's much advantage from combining them into a single
> >driver - the boiler plate is so small and simple.

> Do we consider the case that codec driver is not required such as
> virtual sink or sink is configured outside of ALSA driver? If we
> create dummy codec driver for each use case, wouldn't
> sound/soc/codecs end up littered with bunch of noop drivers?

Yup, but it's not really a big cost - they're all so trivial.

> Furthermore, couldn't capabilities
> being passed through platform device?

Right, but of course you probably end up defining a common set of
platform data for each device so people don't have to cut'n'paste the
same thing into all the different board files.

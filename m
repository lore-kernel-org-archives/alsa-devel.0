From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH V3 1/5] sound: asoc: Adding support for
 STA529 Audio Codec
Date: Wed, 20 Apr 2011 11:56:20 +0100
Message-ID: <20110420105620.GB4097@opensource.wolfsonmicro.com>
References: <1302499804-24386-1-git-send-email-rajeev-dlh.kumar@st.com>
	<1302499804-24386-2-git-send-email-rajeev-dlh.kumar@st.com>
	<20110411145621.GA26769@opensource.wolfsonmicro.com>
	<4DAE600F.4010405@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9CFC81037FC
	for <alsa-devel@alsa-project.org>;
	Wed, 20 Apr 2011 12:56:23 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4DAE600F.4010405@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: rajeev <rajeev-dlh.kumar@st.com>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 20, 2011 at 09:54:47AM +0530, rajeev wrote:
> On 4/11/2011 8:26 PM, Mark Brown wrote:
> > On Mon, Apr 11, 2011 at 11:00:00AM +0530, Rajeev Kumar wrote:

> >> +static const char *op_mode_text[] = { "slave", "master"};

> > What is op_mode?  This sounds like it should be configured by
> > set_dai_fmt()...

> OK, I will change the name.

You're missing the point here.  The name isn't an issue.

> This patch set has been compiled and tested for Linux-kernel-version 2.6.38-rc4,
> since SPEAr patches for this linux version are already under review in Russel King's
> ARM branch.This version does not have snd_soc_cache_sync() function. 

This isn't how mainline works.  You're not submitting code against some
old, released kernel version.  You're submitting code for the
development version of the kernel and need to fit in with that.  Code
for an older kernel may not even compile with current development
kernels.  For integration testing -next is often a good bet.

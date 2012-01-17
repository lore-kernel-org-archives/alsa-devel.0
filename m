From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: Allow drivers to specify how
 many bits are significant on a DAI
Date: Tue, 17 Jan 2012 18:17:09 +0000
Message-ID: <20120117181709.GM2944@opensource.wolfsonmicro.com>
References: <1326739267-9678-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<4F15377B.6080108@ti.com>
	<20120117113848.GE2944@opensource.wolfsonmicro.com>
	<4F157264.5020102@ti.com>
	<20120117131950.GF2944@opensource.wolfsonmicro.com>
	<4F15833B.2000808@ti.com>
	<20120117145646.GG2944@opensource.wolfsonmicro.com>
	<4F159CE2.4090306@ti.com>
	<20120117164452.GJ2944@opensource.wolfsonmicro.com>
	<4F15B611.2080808@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 40036103A46
	for <alsa-devel@alsa-project.org>; Tue, 17 Jan 2012 19:17:12 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4F15B611.2080808@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 17, 2012 at 06:55:29PM +0100, Peter Ujfalusi wrote:
> On 01/17/2012 05:44 PM, Mark Brown wrote:

> > The datasheet isn't terribly machine parseable.

> True, and the information that the chip internally works in 24 bit mode
> is irrelevant. Why would any application care when it plays 16bit sample
> that the HW will internally convert it to 24 bit?

Off the top of my head it may decide that if it happens to have 24 bit
data then passing it straight through was sensible.  But frankly I'm
just working on the basis that if it's more effort to hide information
than to provide it then providing it seems like the way forwards.  I've
certainly got no intention of writing any code here myself unless
there's some issue found.

> >> This is not a point. If it does it's internal digital volume on the full
> >> 32bit resolution from which the HW just discards 8bits we will loose
> >> resolution. If PA knows that out of the 32bit only the 24bit msbit is
> >> going to be used it can apply the gain correctly.

> > This isn't a correctness thing really, it's just that it's doing more
> > work than it needs to because nothing is going to pay attention to the
> > the lower bits it outputs.  A gain applied with 24 bits just has an
> > output with a bit less resolution than one applied with 32 bits but it
> > shouldn't be substantially different.

> Yeah, but it is not correct. If it does not know this we have 8bit
> 'latency' in gain control. Pulse can change the gain which will have no
> effect.

Which will have the same overall effect as if it doesn't do anything
based on knowing the resolution.

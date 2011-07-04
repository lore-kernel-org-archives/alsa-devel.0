From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: core - Add platform read and write.
Date: Mon, 4 Jul 2011 15:34:54 -0700
Message-ID: <20110704223453.GB1030@opensource.wolfsonmicro.com>
References: <1309774215-4083-1-git-send-email-lrg@ti.com>
	<20110704194140.GC32624@opensource.wolfsonmicro.com>
	<4E122D1D.4010109@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B761624380
	for <alsa-devel@alsa-project.org>;
	Tue,  5 Jul 2011 00:34:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4E122D1D.4010109@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 04, 2011 at 10:14:05PM +0100, Liam Girdwood wrote:
> On 04/07/11 20:41, Mark Brown wrote:

> > Could return -EINVAL or something here - it's not like read where we're
> > mixing with the in band data.

> I was thinking that too, but consistency with the codec IO would mean return -1. 
> 
> However, I've no real preference. I happy to change to EINVAL.

Should probably fix the CODEC code as well.

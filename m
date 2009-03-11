From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 2/3][RFC] ASoC: Add Magician
	machine	support.
Date: Wed, 11 Mar 2009 22:44:40 +0000
Message-ID: <20090311224439.GB9001@sirena.org.uk>
References: <1236795420-12175-1-git-send-email-philipp.zabel@gmail.com>
	<1236795420-12175-2-git-send-email-philipp.zabel@gmail.com>
	<20090311222501.GA7536@sirena.org.uk>
	<1236811092.6781.199.camel@vega.slimlogic.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id A47471038C7
	for <alsa-devel@alsa-project.org>; Wed, 11 Mar 2009 23:44:49 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1236811092.6781.199.camel@vega.slimlogic.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@kernel.org>
Cc: alsa-devel@alsa-project.org, Philipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 11, 2009 at 10:38:12PM +0000, Liam Girdwood wrote:
> On Wed, 2009-03-11 at 22:25 +0000, Mark Brown wrote:

> > snd_soc_add_controls()

> I'm thinking we should probably make snd_soc_cnew() static now. It's far
> more convenient to use snd_soc_add_controls().

Yup, I was intending to do that after the merge window - add_controls is
new for .30 and there hasn't been too much API change this merge window
so it seemed helpful to keep it around for the time being.

From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [RFC PATCH] ASoC: wm_adsp: Change ADSPs to be
	mixer widgets	rather the PGAs
Date: Wed, 18 Dec 2013 13:14:36 +0000
Message-ID: <20131218131436.GE11138@opensource.wolfsonmicro.com>
References: <1387364024-15708-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <20131218112739.GH28455@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8AC7626164C
 for <alsa-devel@alsa-project.org>; Wed, 18 Dec 2013 14:14:37 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20131218112739.GH28455@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 18, 2013 at 11:27:39AM +0000, Mark Brown wrote:
> On Wed, Dec 18, 2013 at 10:53:44AM +0000, Charles Keepax wrote:
> 
> > Was also considering if it would be worth adding an
> > additional snd_soc_dapm_dsp id? That could sit between
> > mixers and pgas, but I can't really see any obvious issue
> > with treating the DSP as a mixer and it is a much simpler
> > change. Although I am open to writing the other change if it
> > is preferred?
> 
> One of the issues here was trying to ensure that the DSP started up with
> its inputs stable so noise from them starting didn't propagage into the
> algorithm and confuse it.  The expecation with putting it as a PGA was
> that it would start with the outputs mute and do a digital unmute to
> bring them up.  Since everything is digital this should all be more
> robust than it would be for analogue.

Muting the output is a little tricky though as a graph walk will
be required to determine which output was connected, unless you
have any handy ideas I have not spotted? I will start having a
look to see what could be done on the muting front.

Thanks,
Charles

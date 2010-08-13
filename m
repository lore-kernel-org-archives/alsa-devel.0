From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: Set up debugfs only once
	per	CODEC
Date: Fri, 13 Aug 2010 10:02:49 +0100
Message-ID: <20100813090249.GA32249@sirena.org.uk>
References: <1281624632-17992-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<201008130742.45006.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 0C924103809
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Aug 2010 11:02:51 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <201008130742.45006.peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 13, 2010 at 07:42:44AM +0300, Peter Ujfalusi wrote:
> On Thursday 12 August 2010 17:50:31 ext Mark Brown wrote:
> > Since the debugfs directory is current per CODEC we should only init
> > it when the CODEC is initialised, otherwise we end up with errors
> > being generated when an attempt is made to add duplicate debugfs
> > entries.

> But if you move the init of debugfs where you have moved it, than the machine 
> driver given DAPM widgets will have no debugfs entries, since the machine init 
> is going to be called later (dai_link->init)...

Sure, but the big problem there is that these aren't really CODEC
specific objects.

> > Since most of this stuff is actually for the card we should refactor
> > but this can come later.

> Sure, refactoring will help, but with this change we have missing debugfs files 
> for widgets, which is kind of confusing.

Meh, it's a debug facility and I hope it'll be sorted out within a week
or so anyway.  Besides, you're not really loosing much information since
there tends to be no interesting routing outside the CODEC.

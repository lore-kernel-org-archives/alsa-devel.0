From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH 1/2] ASoC: compress: Correct handling of
 compressed ops
Date: Wed, 24 Jan 2018 17:14:40 +0000
Message-ID: <20180124171440.fsep6atik37urv5m@localhost.localdomain>
References: <20180124135525.5633-1-ckeepax@opensource.cirrus.com>
 <20180124142901.GG18649@localhost>
 <20180124144915.p5fo2pypnawqbj66@localhost.localdomain>
 <20180124153330.GF9366@sirena.org.uk>
 <20180124160029.3qurs4cm75owjptn@localhost.localdomain>
 <20180124160551.GH9366@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 2E81D266A74
 for <alsa-devel@alsa-project.org>; Wed, 24 Jan 2018 18:14:46 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20180124160551.GH9366@sirena.org.uk>
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
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, lgirdwood@gmail.com, dan.carpenter@oracle.com, kuninori.morimoto.gx@renesas.com
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 24, 2018 at 04:05:51PM +0000, Mark Brown wrote:
> On Wed, Jan 24, 2018 at 04:00:29PM +0000, Charles Keepax wrote:
> > On Wed, Jan 24, 2018 at 03:33:30PM +0000, Mark Brown wrote:
> 
> > > This doesn't apply against Linus' tree so that's not going to happen...
> 
> > Shall I split it into a crufty fix and then a tidy up?
> 
> Without seeing how awkward the crufty fix looks it's hard to say, use
> your judgement.

My feeling is still the same really that we should stick with this
patch even though its a bit more to put into stable, since really
the looping stuff is a bug as well.

But that said I will have a go at drafting up a separated patch,
see what it looks like and report back tomorrow.

Thanks,
Charles

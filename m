From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH 1/2] ASoC: compress: Correct handling of
 compressed ops
Date: Wed, 24 Jan 2018 16:00:29 +0000
Message-ID: <20180124160029.3qurs4cm75owjptn@localhost.localdomain>
References: <20180124135525.5633-1-ckeepax@opensource.cirrus.com>
 <20180124142901.GG18649@localhost>
 <20180124144915.p5fo2pypnawqbj66@localhost.localdomain>
 <20180124153330.GF9366@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id D6AA8266C0E
 for <alsa-devel@alsa-project.org>; Wed, 24 Jan 2018 17:00:34 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20180124153330.GF9366@sirena.org.uk>
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

On Wed, Jan 24, 2018 at 03:33:30PM +0000, Mark Brown wrote:
> On Wed, Jan 24, 2018 at 02:49:15PM +0000, Charles Keepax wrote:
> 
> > The offending change here is only in the v4.15-rc's so if we can
> > get the change in before 4.16 there shouldn't be any need to send
> > anything to stable.
> 
> This doesn't apply against Linus' tree so that's not going to happen...

Shall I split it into a crufty fix and then a tidy up?

Thanks,
Charles

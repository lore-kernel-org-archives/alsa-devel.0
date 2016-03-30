From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: dpcm: prevent error for paths
 including static links
Date: Wed, 30 Mar 2016 09:58:12 +0100
Message-ID: <20160330085812.GE31814@localhost.localdomain>
References: <1458056089-885-1-git-send-email-piotrs@opensource.wolfsonmicro.com>
 <20160329212224.GM2350@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 6CE6E2617B8
 for <alsa-devel@alsa-project.org>; Wed, 30 Mar 2016 10:58:11 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20160329212224.GM2350@sirena.org.uk>
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
Cc: Piotr Stankiewicz <piotrs@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 29, 2016 at 02:22:24PM -0700, Mark Brown wrote:
> On Tue, Mar 15, 2016 at 03:34:49PM +0000, Piotr Stankiewicz wrote:
> 
> > This happens when setting up, e.g. a route starting with a dynamic
> > DAI, which passes through a static DAI (say, "Some FE" -> "Some BE"
> > -> "Codec to Modem link"). All DAPM widgets involved in that path will
> 
> Is this not just a normal CODEC connected to a back end on a DPCM
> system?  What are a "dynamic DAI" and "static DAI"?  Your changelog is
> very unclear, I really can't tell from your changelog what this is
> aiming to do or how it proposes to do it.

The issue is basically if you have a path with a DPCM DAI at the
front, but then a regular CODEC to CODEC DAI link later in the
path. Say for example a CODEC attached to a CPU that uses DPCM
but then the path goes through a CODEC to CODEC link to a speaker
AMP after the CODEC.

> 
> I'm also concerned that nobody else seems to be seeing this, that's a
> bit of a warning sign that you might be misusing things here.  Your
> mention of a "Codec to Modem link" sounds like you might be trying to
> use DPCM for off-SoC components somehow which is just not something
> that's expected to work.
> 
> At a minimum this needs a much better changelog.

Piotr is on holiday this week but should be back start of next
week, so should be able to respin the patch then. For what its
worth though I have seen this warning on other systems from the
one he is working on as well.

Thanks,
Charles

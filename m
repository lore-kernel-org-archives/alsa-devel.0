From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: arizona: Add DAC Volume Limit
	controls
Date: Wed, 28 Jun 2017 16:55:15 +0100
Message-ID: <20170628155515.ycrn7esull42jxkw@localhost.localdomain>
References: <20170628125317.30561-1-ckeepax@opensource.cirrus.com>
 <20170628140946.dhbsdyqzo2pgkczk@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 4BF56266B13
 for <alsa-devel@alsa-project.org>; Wed, 28 Jun 2017 17:55:18 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20170628140946.dhbsdyqzo2pgkczk@sirena.org.uk>
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
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 28, 2017 at 03:09:46PM +0100, Mark Brown wrote:
> On Wed, Jun 28, 2017 at 01:53:17PM +0100, Charles Keepax wrote:
> > Add controls that allow the limiting of the volume coming from the DACs on
> > the Arizona class devices, note that wm8998 does not have this feature.
> 
> Is it sensible to control the volume limits through normal controls
> given that the level of protection offered ends up being minimal if the
> two controls are sitting next to each other?  I'd kind of expect this to
> be something that comes from the system integration (eg, limits on the
> physical capabilities of the speaker).

That is a fair point, I don't think we have any need to adapt
them dynamically so I could move them to a DT binding/pdata. I
will have a look at that.

Thanks,
Charles

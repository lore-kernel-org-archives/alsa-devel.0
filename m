From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH 3/3] ASoC: wm8741: Set SR mode in
	hw_params()
Date: Wed, 6 Sep 2017 09:23:05 +0100
Message-ID: <20170906082305.5cf4xa2wtkzl4a6u@localhost.localdomain>
References: <1504553653-8144-1-git-send-email-sergej@taudac.com>
 <1504553653-8144-4-git-send-email-sergej@taudac.com>
 <20170905162300.zrmwyz3niarqzcr4@localhost.localdomain>
 <ca28fded-69d9-0ede-0a50-ac72434f0713@taudac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 1040B266DD6
 for <alsa-devel@alsa-project.org>; Wed,  6 Sep 2017 10:23:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <ca28fded-69d9-0ede-0a50-ac72434f0713@taudac.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sergej Sawazki <sergej@taudac.com>
Cc: ce3a@gmx.de, patches@opensource.cirrus.com, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 05, 2017 at 09:05:27PM +0200, Sergej Sawazki wrote:
> Am 05.09.2017 um 18:23 schrieb Charles Keepax:
> > On Mon, Sep 04, 2017 at 09:34:13PM +0200, Sergej Sawazki wrote:
> > > Set the ratio of MCLK/LRCLK in hw_params() instead of relying on the
> > > auto-detection.
> > > 
> > > The ratio of MCLK/LRCLK is known to the driver, there is no need to let
> > > the device to detect it.
> > > 
> > 
> > But also no reason to not let it do so, are there some problems
> > with the auto-detect?
> > 
> 
> I haven't noticed any problems. But, as we know the ratio and the device
> provides an interface to set it, why don't we just do it?
> Setting it feels right somehow, even if it is not absolutely necessary.
> 

I would lean more towards if the auto-detect works we might as
well use it and not add code we don't need.

Thanks,
Charles

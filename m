From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [PATCH] ASoC: core: Add API for configuration of
 DAI FS
Date: Mon, 16 Sep 2013 12:32:10 +0100
Message-ID: <1379331130.3215.35.camel@loki>
References: <1379092188-7385-1-git-send-email-liam.r.girdwood@linux.intel.com>
 <1379092188-7385-4-git-send-email-liam.r.girdwood@linux.intel.com>
 <20130913172604.GM29403@sirena.org.uk> <1379327309.3215.21.camel@loki>
 <20130916110554.GB29403@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 5A43F261A7C
 for <alsa-devel@alsa-project.org>; Mon, 16 Sep 2013 13:32:14 +0200 (CEST)
In-Reply-To: <20130916110554.GB29403@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 2013-09-16 at 12:05 +0100, Mark Brown wrote:
> On Mon, Sep 16, 2013 at 11:28:29AM +0100, Liam Girdwood wrote:
> 
> > I'll change the naming so it's set_bclk() and the params to keep it in
> > line with snd_soc_dai_set_sysclk().
> 
> bclk_ratio()? 

ok, that sounds best :)

Liam

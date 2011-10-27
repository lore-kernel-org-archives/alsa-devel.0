From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC:core:add flag ignore_pmdown_time in
 snd_soc_dai_link
Date: Thu, 27 Oct 2011 10:18:54 +0100
Message-ID: <20111027091853.GA6174@sirena.org.uk>
References: <1319696933-19942-1-git-send-email-ramesh.babu@linux.intel.com>
	<CABS+qY0aZDnEDODaHGBXAWWB6p5X+TYc9Hh3nQi1Cv+jKsqmrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 5541D1038C0
	for <alsa-devel@alsa-project.org>;
	Thu, 27 Oct 2011 11:18:55 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CABS+qY0aZDnEDODaHGBXAWWB6p5X+TYc9Hh3nQi1Cv+jKsqmrw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Girdwood, Liam" <lrg@ti.com>
Cc: ramesh.babu@linux.intel.com, "Ujfalusi, Peter" <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 27, 2011 at 10:11:37AM +0100, Girdwood, Liam wrote:

> This looks fine by me. Peter, does this work for you ?

Peter already has a per-CODEC property he's using since the CODEC needs
this for pop/click issues.  This is for a system integration problem the
Intel guys have.

From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 3/3] ASoC: Blackfin: fix bug - kernel
	will	crash when record and play in bf527-ezkit
Date: Fri, 13 Feb 2009 20:18:18 +0000
Message-ID: <20090213201816.GA6410@sirena.org.uk>
References: <1233915156-17985-1-git-send-email-cooloney@kernel.org>
	<1233915156-17985-4-git-send-email-cooloney@kernel.org>
	<20090206115626.GD8723@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id A417D2434D
	for <alsa-devel@alsa-project.org>; Fri, 13 Feb 2009 21:25:51 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20090206115626.GD8723@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Bryan Wu <cooloney@kernel.org>
Cc: alsa-devel@alsa-project.org, Cliff Cai <cliff.cai@analog.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Feb 06, 2009 at 11:56:45AM +0000, Mark Brown wrote:

> > set constraint only if the value is not 0, change the configuring way for sport

> If this is fixing a kernel crash we should push it for 2.6.29 (the code
> hasn't changed so I'm assuming it occurs there).  What is the crash that
> is being fixed?

Any updates on this?

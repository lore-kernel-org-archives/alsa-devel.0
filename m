From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 1/5] ASoC: Blackfin: fix bug -
	kernel	willcrash when record and play in bf527-ezkit
Date: Mon, 9 Mar 2009 11:21:28 +0000
Message-ID: <20090309112127.GB13593@sirena.org.uk>
References: <1236326010-683-1-git-send-email-cooloney@kernel.org>
	<1236326010-683-2-git-send-email-cooloney@kernel.org>
	<20090306120145.GF6493@sirena.org.uk>
	<0F1B54C89D5F954D8535DB252AF412FA03AB85F5@chinexm1.ad.analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id C50DD10381D
	for <alsa-devel@alsa-project.org>; Mon,  9 Mar 2009 12:21:30 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <0F1B54C89D5F954D8535DB252AF412FA03AB85F5@chinexm1.ad.analog.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Cai, Cliff" <Cliff.Cai@analog.com>
Cc: Bryan Wu <cooloney@kernel.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 09, 2009 at 06:58:19PM +0800, Cai, Cliff wrote:

> This patch should be named : change the configuring way for sport,
> Because I found that the previous way is not reliable sometimes.
> Application like "tone" ,will call starup() twice before entering
> hw_params() to configure SPORT.  
> in this case SPORT won't be configured at all.

This doesn't address the concerns I raised with the patch:

> >Won't this mean that if a second data format is played the 
> >audio will be mishandled since the hardware will not have been 
> >configured for the new audio format?

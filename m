From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 2/5] ASoC: ssm2602 codec: fix bug
	-	kernelwill crash when record and play in bf527-ezkit
Date: Mon, 9 Mar 2009 11:55:16 +0000
Message-ID: <20090309115516.GC13593@sirena.org.uk>
References: <1236326010-683-1-git-send-email-cooloney@kernel.org>
	<1236326010-683-3-git-send-email-cooloney@kernel.org>
	<20090306123515.GG6493@sirena.org.uk>
	<0F1B54C89D5F954D8535DB252AF412FA03AB85FE@chinexm1.ad.analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 1DC181037FF
	for <alsa-devel@alsa-project.org>; Mon,  9 Mar 2009 12:55:19 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <0F1B54C89D5F954D8535DB252AF412FA03AB85FE@chinexm1.ad.analog.com>
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

On Mon, Mar 09, 2009 at 07:07:26PM +0800, Cai, Cliff wrote:

>  This patch should be named :set constraint only if the value is not 0.
>  I found that sometimes substream may be not NULL,but runtime can be
> NULL,So the previous way will cause
> Kernel to crash.

Again, this doesn't address the concern about the fact that you're only
supporting one time configuration here.

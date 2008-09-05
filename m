From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 2/9] ASoC: Blackfin: SPORT peripheral
	interface driver
Date: Fri, 5 Sep 2008 14:10:50 +0100
Message-ID: <20080905131049.GH12383@sirena.org.uk>
References: <1220610102-7716-1-git-send-email-cooloney@kernel.org>
	<1220610102-7716-3-git-send-email-cooloney@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 5D1FE24615
	for <alsa-devel@alsa-project.org>;
	Fri,  5 Sep 2008 15:10:52 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1220610102-7716-3-git-send-email-cooloney@kernel.org>
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
Cc: Cliff Cai <cliff.cai@analog.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 05, 2008 at 06:21:35PM +0800, Bryan Wu wrote:

> +	/* Maybe the dummy buffer descriptor ring is damaged */
> +	sport->dummy_rx_desc->next_desc_addr = \
> +			(unsigned long)(sport->dummy_rx_desc+1);

Here and elsewhere in this driver you've got continuation characters
which aren't need.  I've fixed this up locally (and some additional
checkpatch/coding standards things) here and in other patches in the
series.

Otherwise the patch series looks good to go, thanks - I'm just about to
review the codec driver patch that it depends upon.

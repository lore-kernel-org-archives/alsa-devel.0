From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 1/1] ASoC: Blackfin: update SPORT0 port
	selector (v2)
Date: Mon, 27 Oct 2008 11:35:36 +0000
Message-ID: <20081027113536.GC5896@sirena.org.uk>
References: <1225098565-6848-1-git-send-email-cooloney@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 2895A24707
	for <alsa-devel@alsa-project.org>; Mon, 27 Oct 2008 12:35:38 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1225098565-6848-1-git-send-email-cooloney@kernel.org>
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
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Cliff Cai <cliff.cai@analog.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Oct 27, 2008 at 05:09:25PM +0800, Bryan Wu wrote:
> From: Cliff Cai <cliff.cai@analog.com>
> 
> - Setting the TFS pin selector for SPORT 0 based on whether the selected
>   port id F or G. If the port is F then no conflict should exist for the
>   TFS. When Port G is selected and EMAC then there is a conflict between
>   the PHY interrupt line and TFS.  Current settings prevent the conflict
>   by ignoring the TFS pin when Port G is selected. This allows both
>   ssm2602 using Port G and EMAC concurrently.
> 
>  - some code cleanup
> 
> Signed-off-by: Cliff Cai <cliff.cai@analog.com>
> Signed-off-by: Bryan Wu <cooloney@kernel.org>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCHv2 3/3] ASoC: Extend DAPM to handle power
 changes on cross-device paths
Date: Fri, 12 Nov 2010 15:13:32 +0000
Message-ID: <20101112151332.GF17283@rakim.wolfsonmicro.main>
References: <1289553806-28625-1-git-send-email-jhnikula@gmail.com>
	<1289553806-28625-4-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 23CB5103964
	for <alsa-devel@alsa-project.org>; Fri, 12 Nov 2010 16:13:34 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1289553806-28625-4-git-send-email-jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 12, 2010 at 11:23:26AM +0200, Jarkko Nikula wrote:

>  	list_for_each_entry_safe(w, n, list, power_list) {
>  		ret = 0;
>  
>  		/* Do we need to apply any queued changes? */
> -		if (sort[w->id] != cur_sort || w->reg != cur_reg) {
> +		if (sort[w->id] != cur_sort || w->reg != cur_reg ||
> +		    w->dapm != cur_dapm) {
>  			if (!list_empty(&pending))
> -				dapm_seq_run_coalesced(dapm, &pending);
> +				dapm_seq_run_coalesced(cur_dapm, &pending);
>  
>  			INIT_LIST_HEAD(&pending);
>  			cur_sort = -1;
>  			cur_reg = SND_SOC_NOPM;

We need a corresponding change in dapm_seq_compare() to ensure that the
widgets for a given card are grouped together.  I'll send out some
patches to do that shortly since I just noticed there's an oversight
there anyway.

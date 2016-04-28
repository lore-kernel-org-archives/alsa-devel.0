From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH 3/6] topology: Use generic pointer to
 realloc buffer for private data
Date: Thu, 28 Apr 2016 10:48:36 +0200
Message-ID: <5721CE64.4060803@perex.cz>
References: <cover.1461831763.git.mengdong.lin@linux.intel.com>
 <1dd0f08c152af476e3a5af48ce7de97cd759616a.1461831763.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id 752B92660D1
 for <alsa-devel@alsa-project.org>; Thu, 28 Apr 2016 10:48:37 +0200 (CEST)
In-Reply-To: <1dd0f08c152af476e3a5af48ce7de97cd759616a.1461831763.git.mengdong.lin@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: mengdong.lin@linux.intel.com, alsa-devel@alsa-project.org, broonie@kernel.org
Cc: tiwai@suse.de, mengdong.lin@intel.com, guneshwor.o.singh@intel.com, liam.r.girdwood@intel.com, hardik.t.shah@intel.com
List-Id: alsa-devel@alsa-project.org

Dne 28.4.2016 v 10:41 mengdong.lin@linux.intel.com napsal(a):
>  	priv_data_size = ref->data->size;
> +	elem->obj = realloc(elem->obj,
> +			elem->size + priv_data_size);
> +	if (!elem->obj)
> +		return -ENOMEM;

This causes a memory leak when realloc fails. You should free the
original pointer when realloc() fails.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.

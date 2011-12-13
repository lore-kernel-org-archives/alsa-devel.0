From: "Nallasellan, Singaravelan" <singaravelan.nallasellan@intel.com>
Subject: Re: [PATCH v4 4/6] core: add API header and driver
 header	files
Date: Tue, 13 Dec 2011 18:19:49 +0530
Message-ID: <3CA6C6D9F70D314CA34352990B57DA1507CCB50B02@bgsmsx502.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id 2DFCA103B30
	for <alsa-devel@alsa-project.org>; Tue, 13 Dec 2011 13:49:56 +0100 (CET)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@linux.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "lrg@ti.com" <lrg@ti.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

> +struct snd_compr_runtime {
> +	snd_pcm_state_t state;
> +	struct snd_compr_ops *ops;
> +	void *buffer;
Can we define buffer as char *?
> +	size_t buffer_size;
> +	size_t fragment_size;
Can we define buffer_size and fragment_size as unsigned items? 
Can we have negative size here?

> +	unsigned int fragments;
> +	size_t hw_pointer;
> +	size_t app_pointer;
> +	size_t bytes_written;
> +	size_t bytes_copied;
> +	wait_queue_head_t sleep;
> +};
> +

From: "Babu, Ramesh" <ramesh.babu@intel.com>
Subject: Non-cacheable memory to alsa ring buffer
Date: Mon, 2 Jan 2012 12:09:29 +0000
Message-ID: <32F4D3A311A1404B92CF923AFF38C3C502D600@BGSMSX101.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id BCF7E1038CA
	for <alsa-devel@alsa-project.org>; Mon,  2 Jan 2012 13:11:33 +0100 (CET)
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
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi

How can I allocate non-cacheable region for ring buffer?

I have an issue, where my DMA is not fetching right data from
Memory. I suspect that caching might be issue here.

I am using the below api to allocate memory:

retval = snd_pcm_lib_preallocate_pages_for_all(pcm,
                        SNDRV_DMA_TYPE_CONTINUOUS,
                        snd_dma_continuous_data(GFP_KERNEL),
                        RING_MIN_BUFFER, RING_MAX_BUFFER);

Where, RING_MIN_BUFFER = RING_MAX_BUFFER = (8*1024)

Thanks
Ramesh

From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Subject: Re: [PATCH v2 2/2] ASoC: SOF: Intel: fix reset of
 host_period_bytes
Date: Thu, 4 Jul 2019 13:05:21 +0300 (EEST)
Message-ID: <alpine.DEB.2.21.1907041304101.4409@eliteleevi>
References: <20190703151023.30313-1-yang.jie@linux.intel.com>
 <20190703151023.30313-2-yang.jie@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C7BBEF800E8
 for <alsa-devel@alsa-project.org>; Thu,  4 Jul 2019 12:04:10 +0200 (CEST)
In-Reply-To: <20190703151023.30313-2-yang.jie@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Keyon Jie <yang.jie@linux.intel.com>
Cc: alsa-devel@alsa-project.org, ranjani.sridharan@linux.intel.com, Marcin Rajwa <marcin.rajwa@linux.intel.com>, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

Hi,

On Wed, 3 Jul 2019, Keyon Jie wrote:

> From: Marcin Rajwa <marcin.rajwa@linux.intel.com>
> 
> This patch prevents the reset of host period bytes.
> The parameter has been used to keep information about
> completion of period copy. Right now we keep this
> information in period_irq.
> 
> Signed-off-by: Marcin Rajwa <marcin.rajwa@linux.intel.com>
> Signed-off-by: Keyon Jie <yang.jie@linux.intel.com>

looks good, for this patch:

Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>

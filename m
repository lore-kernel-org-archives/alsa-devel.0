From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Subject: Re: [PATCH v2 1/2] ASoC: SOF: add flag for position
 update ipc
Date: Thu, 4 Jul 2019 13:03:06 +0300 (EEST)
Message-ID: <alpine.DEB.2.21.1907041254100.4409@eliteleevi>
References: <20190703151023.30313-1-yang.jie@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3B4E7F800E8
 for <alsa-devel@alsa-project.org>; Thu,  4 Jul 2019 12:02:03 +0200 (CEST)
In-Reply-To: <20190703151023.30313-1-yang.jie@linux.intel.com>
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

patch looks good, but commit message could be improved.

On Wed, 3 Jul 2019, Keyon Jie wrote:

> In some cases, FW might need use the host_period_bytes even no position
> update ipc reqiured from driver, here add another flag for position update,
> and preserve host_period_bytes for FW to use.

Speculation on what FW might do is not really needed. The 
host_period_bytes field has been overloaded with multiple 
semantics and this patch clears that, right. How about:

""
Remove the special case semantics of 'host_period_bytes==0'.
Add a new field 'no_period_irq' to signal whether period elapsed
IPC should be sent and use 'host_period_bytes' only for
period size.
""

> This might require corresponding FW change and ABI alignment.

This is not helpful -- we know this _is_ a minor ABI change
and needs to be aligned with FW.

Br, Kai

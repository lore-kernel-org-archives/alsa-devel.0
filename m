From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Subject: Re: [PATCH v2 1/2] ASoC: SOF: add flag for position
 update ipc
Date: Thu, 4 Jul 2019 14:00:31 +0300 (EEST)
Message-ID: <alpine.DEB.2.21.1907041344240.4409@eliteleevi>
References: <20190703151023.30313-1-yang.jie@linux.intel.com>
 <alpine.DEB.2.21.1907041254100.4409@eliteleevi>
 <3788800e-7050-d68a-bec6-5b443fd0d563@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 35067F800E7
 for <alsa-devel@alsa-project.org>; Thu,  4 Jul 2019 12:59:19 +0200 (CEST)
In-Reply-To: <3788800e-7050-d68a-bec6-5b443fd0d563@linux.intel.com>
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
Cc: alsa-devel@alsa-project.org, Marcin Rajwa <marcin.rajwa@linux.intel.com>, ranjani.sridharan@linux.intel.com, Kai Vehmanen <kai.vehmanen@linux.intel.com>, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

Hi,

On Thu, 4 Jul 2019, Keyon Jie wrote:

> Well, to me it is flavor choice, Ranjani suggested to illustrate the use 
> case where the FW will use this host_period_bytes, and I agreed this 
> will help people to understand why we need this change.

hmm, ok. So maybe add "Allows FW to use 'host_period_bytes' field
for its original purpose" to my proposed wording..?

>> This is not helpful -- we know this _is_ a minor ABI change
>> and needs to be aligned with FW.
> It is minor change, but the FW change is still required, otherwise, we 
> will get extra position update IPCs which may confuse the driver, please 
[...]
> https://github.com/thesofproject/sof/pull/1592

Ack, but we know this already so best to put the accurate 
description in the commit message. The "might require FW change"
is a bit scary statement in a patch touching ABI structs. ;)

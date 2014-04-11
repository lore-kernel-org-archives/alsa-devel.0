From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: How to create a proc entry for an ASoc codec?
Date: Fri, 11 Apr 2014 09:16:03 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F82B3DB083@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id 80735266F6B
 for <alsa-devel@alsa-project.org>; Fri, 11 Apr 2014 11:16:44 +0200 (CEST)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Girdwood, Liam R" <liam.r.girdwood@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

How to create a proc entry for an ASoc codec under the sound card?

We hope to create an proc entry for an I2S codec under /proc/asound/cardx, to debug the codec status at runtime.

So after the machine driver calls snd_soc_register_card(&soc_card), I calls snd_card_proc_new(soc_card .snd_card, ....)
But no codec entry is created although dmesg shows this function succeeds.

How ASoC creates the proc entries such as 'id' for the sound card?

Thanks
Mengdong

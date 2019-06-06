From: "Ser, Simon" <simon.ser@intel.com>
Subject: Sending DC offsets to an ALSA device: dangerous?
Date: Thu, 6 Jun 2019 11:57:06 +0000
Message-ID: <74b57974c339abb4e45be3bec2364ccf417d2967.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8D34CF80768
 for <alsa-devel@alsa-project.org>; Thu,  6 Jun 2019 13:57:12 +0200 (CEST)
Content-Language: en-US
Content-ID: <A928624AA0EEF9439115F21DB3140290@intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "tvrtko.ursulin@linux.intel.com" <tvrtko.ursulin@linux.intel.com>, "martin.peres@linux.intel.com" <martin.peres@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Hi,

I've been writing some audio HDMI/DisplayPort tests in the IGT test
suite. As part of the tests I send 200ms DC offsets at 90% of the
maximum amplitude.

Do you know whether doing so is dangerous for some TV speakers? Would
sending the same DC offsets at 25% of the max amplitude be better?

Thanks,

Simon Ser

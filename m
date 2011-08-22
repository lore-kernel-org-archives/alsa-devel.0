From: Lu Guanqun <guanqun.lu@intel.com>
Subject: about UCM on bluetooth headset
Date: Mon, 22 Aug 2011 14:19:11 +0800
Message-ID: <20110822061911.GA7993@guanqun-laptop.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 87309103821
	for <alsa-devel@alsa-project.org>;
	Mon, 22 Aug 2011 08:19:13 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Liam,

In alsa-libs:include/use-case.h, there are below lines:

	* a conversation etc. The device describes the physical audio capture and playback
	* hardware i.e. headphones, phone handset, bluetooth headset, etc.

I'm not quite clear about how to set a use case for bluetooth headset.
According to my understanding, bluetooth doesn't fall into the category
of ALSA, therefore there's no such direct devices for it.

Could you shed some lights on this? What's the best practises to use UCM
with bluetooth?

-- 
guanqun

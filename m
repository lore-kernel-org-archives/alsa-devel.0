From: "Koul, Vinod" <vinod.koul@intel.com>
Subject: asoc register read/write calls
Date: Wed, 24 Nov 2010 18:11:51 +0530
Message-ID: <438BB0150E931F4B9CE701519A44630104BECC82EB@bgsmsx502.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id C0ACC24612
	for <alsa-devel@alsa-project.org>; Wed, 24 Nov 2010 13:42:16 +0100 (CET)
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
Cc: "Harsha, Priya" <priya.harsha@intel.com>
List-Id: alsa-devel@alsa-project.org

Mark,

In the asoc framework, do the codec register read-write calls need to be atomic?
Will it work in non-atomic context?

~Vinod

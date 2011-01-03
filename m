From: "Harsha, Priya" <priya.harsha@intel.com>
Subject: regarding references taken on platform and codec
	driver modules
Date: Mon, 3 Jan 2011 12:39:13 +0530
Message-ID: <98769532B4BB14429434178695419EAE053BF51572@bgsmsx501.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id D8164103871
	for <alsa-devel@alsa-project.org>; Mon,  3 Jan 2011 08:11:19 +0100 (CET)
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
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

In soc-core.c, I see that try_module_get() is used to get reference count on the
codec and platform drivers. But I don't see try_module_put() to remove the
reference count after usage.

Because of this, my reference count on codec and platform driver is never
reduced and I am not able to do rmmod of these drivers. But I can rmmod the
machine driver as there are no reference count taken on it.

Is this intentional to avoid rmmod of these modules? Or this is to be fixed

-Harsha

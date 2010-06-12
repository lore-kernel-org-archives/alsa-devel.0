From: "Harsha, Priya" <priya.harsha@intel.com>
Subject: ALSA's jack reporting framework map to Android
	framework
Date: Sat, 12 Jun 2010 09:28:34 +0530
Message-ID: <98769532B4BB14429434178695419EAE0426FF84AD@bgsmsx501.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id C6E142459B
	for <alsa-devel@alsa-project.org>;
	Sat, 12 Jun 2010 05:58:43 +0200 (CEST)
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

Hi all,

The ALSA's jack reporting framework reports jacks at /dev/input/eventx. But the Android framework expects the jack reporting to be done in /sys/.../switch/h2w.

Any suggestions as to how  the ALSA's jack reporting framework to Android framework? Are there any audio  drivers that have mapped this? Any kind of input would be really helpful

Thanks,
Harsha

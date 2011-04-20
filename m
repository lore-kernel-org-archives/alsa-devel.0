From: Lu Guanqun <guanqun.lu@intel.com>
Subject: questions about asoc jack detection
Date: Wed, 20 Apr 2011 14:52:12 +0800
Message-ID: <20110420065212.GC21880@qtel.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id 393D324340
	for <alsa-devel@alsa-project.org>;
	Wed, 20 Apr 2011 08:53:06 +0200 (CEST)
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
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Mark,

I have a question wrt jack detection, suppose now I have internal
speaker enabled and then headphone is inserted. According to the current
jack code in asoc, the Headphone pin wil be enabled, but it does nothing
to Internal Speaker. There is still sound coming out from speaker.

The possible solution is to let the application make the policy to
switch the output source to Headphone, because the jack event can be
observed. If we decide to let the userspace application make the policy,
then why do we bother to enable the jack pin at the first place?

Hope I'm not missing something here. Could you provide some insights?

Thanks!
-- 
guanqun

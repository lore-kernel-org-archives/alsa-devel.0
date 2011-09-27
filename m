From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: UCM and modem configurations
Date: Tue, 27 Sep 2011 16:47:31 -0500
Message-ID: <1317160051.2197.51.camel@pbossart-Dell-N7010>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id DE0461039BA
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Sep 2011 23:47:57 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

I've had a couple of questions internally on UCM and can't figure out
how things would work with a cellular modem configured through AT
commands (eg Intel/IFX XGOLD). 
For example UCM could be used to set the volumes and routing for a voice
call, but to modify the acoustics processing on the modem one would
still need to send a bunch of AT commands . So what's the best way to
handle this case:
- Is UCM only supposed to be used for non-cellular cases?
- Do we need to wrap all the AT commands as ALSA controls?
- Is there a way to abstract such commands with some UCM syntax?
- Or do we need to implement another layer to abstract ALSA and AT
commands (which essentially means using UCM concepts but not the UCM
tools and configuration files)?
Thanks for your feedback
-Pierre

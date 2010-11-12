From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCHv2 0/3] ASoC: Extend DAPM to handle cross-device
	paths
Date: Fri, 12 Nov 2010 11:23:23 +0200
Message-ID: <1289553806-28625-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id CEC421038DF
	for <alsa-devel@alsa-project.org>; Fri, 12 Nov 2010 10:22:51 +0100 (CET)
Received: by ewy26 with SMTP id 26so1644949ewy.38
	for <alsa-devel@alsa-project.org>; Fri, 12 Nov 2010 01:22:51 -0800 (PST)
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Hi

Here's updated version of previous RFC_ii/iv set:

http://mailman.alsa-project.org/pipermail/alsa-devel/2010-October/033196.html

Patches 1-2 have no remarkable changes, just modified on top of recent changes.

Patch 3 is simpler as it turns out that the dapm_seq_run_coalesced doesn't need
any changes because it's enough to call it with a right DAPM context.
One fix is in beginning of dapm_power_widgets that d->dev_power is zeroed only
for those codecs that have widgets in order to avoid unnecessary widgetless
codec bias shutdowns.

Minor changes are dapm.sys_power renaming to dev_power and long lines are cut.


-- 
Jarkko

From: Takashi Iwai <tiwai@suse.de>
Subject: Procfs cleanup in ALSA core
Date: Wed, 14 Apr 2010 10:17:58 +0200
Message-ID: <1271233083-16310-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by alsa0.perex.cz (Postfix) with ESMTP id 850042447C
	for <alsa-devel@alsa-project.org>;
	Wed, 14 Apr 2010 10:18:41 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.221.2])
	by mx2.suse.de (Postfix) with ESMTP id 6A6238655F
	for <alsa-devel@alsa-project.org>;
	Wed, 14 Apr 2010 10:18:41 +0200 (CEST)
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
List-Id: alsa-devel@alsa-project.org

Hi,

the another fixes are clean-ups of procfs interface in ALSA core.
The patches below are found in sound git tree topic/core-cleanup branch.
(This branch also contains the BKL-cleanup branch, too).

 [PATCH 1/5] ALSA: info - Use standard types for info callbacks
 [PATCH 2/5] ALSA: info - Check file position validity in common layer
 [PATCH 3/5] ALSA: info - Implement common llseek for binary mode
 [PATCH 4/5] ALSA: core - Define llseek fops
 [PATCH 5/5] ALSA: Update the documentation for changes of proc files


Takashi

From: Jani Nikula <jani.nikula@intel.com>
Subject: [for-next] NULL pointer dereference in codec probe
Date: Thu, 30 Apr 2015 13:06:41 +0300
Message-ID: <87fv7i9bgu.fsf@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 82255265ADB
 for <alsa-devel@alsa-project.org>; Thu, 30 Apr 2015 12:04:44 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
Cc: yex.tian@intel.com
List-Id: alsa-devel@alsa-project.org


Hi all, our graphics QA found an issue [1] with the for-next branch of
[2] merged on top of v4.1-rc1. Backtrace in the bug. I didn't really
have time to look into the details, but just letting you know.

BR,
Jani.


[1] https://bugs.freedesktop.org/show_bug.cgi?id=90229
[2] git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git


-- 
Jani Nikula, Intel Open Source Technology Center

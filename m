From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 00/14] conf/ucm: bytcr-rt5651: Various
	improvements + long-name profiles addition
Date: Fri, 20 Jul 2018 09:27:27 +0200
Message-ID: <20180720072741.4632-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id 7F7CA26739D
 for <alsa-devel@alsa-project.org>; Fri, 20 Jul 2018 09:27:45 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, Hans de Goede <hdegoede@redhat.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Hi All,

Here is a set of patches to the bytcr-rt5651 UCM profiles. This series
also adds a bunch of long-name profiles so that users automatically
only see the inputs / outputs which their device actually has.

The long-names are based on the long-names set by the kernel after
the rt5651 patch series which is currently queued in -next:
https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git/log/?h=for-next

With these UCM profile patches and the kernel changes in place all
inputs and outputs as well as jack-detect will work 100% OOTB on
supported bytcr-rt5651 devices, without the user needing to do any
manual config or mixer settings.

Regards,

Hans

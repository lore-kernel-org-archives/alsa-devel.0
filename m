From: "George Spelvin" <linux@horizon.com>
Subject: 2.6.25-rc2 compile error: 'OPL3_PATCH_HASH_SIZE'
	undeclared
Date: Sun, 17 Feb 2008 20:58:16 -0500
Message-ID: <20080218015816.32301.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from science.horizon.com (science.horizon.com [192.35.100.1])
	by alsa0.perex.cz (Postfix) with SMTP id 9CF042433E
	for <alsa-devel@alsa-project.org>; Mon, 18 Feb 2008 02:58:19 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org, linux@horizon.com
List-Id: alsa-devel@alsa-project.org

sound/drivers/opl3/opl3_synth.c:308
sound/drivers/opl3/opl3_synth.c:335

I think it's caused by the fact that I don't have the sequencer enabled.
The definition inside include/sound/opl3.h is insdie an #ifdef, but the
use is not.

CONFIG_SND=y
CONFIG_SND_TIMER=y
CONFIG_SND_PCM=y
CONFIG_SND_HWDEP=y
CONFIG_SND_RAWMIDI=y
# CONFIG_SND_SEQUENCER is not set
# CONFIG_SND_MIXER_OSS is not set
# CONFIG_SND_PCM_OSS is not set
# CONFIG_SND_DYNAMIC_MINORS is not set
# CONFIG_SND_SUPPORT_OLD_API is not set
CONFIG_SND_VERBOSE_PROCFS=y
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set

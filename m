From: "J. Scott Merritt" <alsauser@pragmasoft.com>
Subject: SALSA-Lib: snd_pcm_hw_params fails with MMAP
Date: Sat, 30 Jun 2007 16:23:38 -0400
Message-ID: <20070630162338.5a83238a.alsauser@pragmasoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp6.server.rpi.edu (smtp6.server.rpi.edu [128.113.2.226])
	by alsa0.perex.cz (Postfix) with ESMTP id 2FA8924469
	for <alsa-devel@alsa-project.org>;
	Sat, 30 Jun 2007 22:20:32 +0200 (CEST)
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
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Dear List,

Using SALSA-Lib 0.0.5 ...

After calling snd_pcm_hw_params_set_access with an access mode of
SND_PCM_ACCESS_MMAP_INTERLEAVED, the subsequent call to snd_pcm_hw_params
returns a snd_strerror error code of "Invalid argument".

This same program operates properly in the target environment (ARM PXA270)
when compiled and linked with the standard ALSA LIB 1.0.13.

Thanks, Scott.

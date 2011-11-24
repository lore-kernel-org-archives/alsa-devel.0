From: Oliver Neukum <oneukum@suse.de>
Subject: question on alsa's kernel API concerning
	snd_power_change_state()
Date: Thu, 24 Nov 2011 09:28:02 +0100
Message-ID: <201111240928.02679.oneukum@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by alsa0.perex.cz (Postfix) with ESMTP id 2BA742448E
	for <alsa-devel@alsa-project.org>; Thu, 24 Nov 2011 09:26:57 +0100 (CET)
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
Cc: Takashi Iwai <tiwai@suse.de>, Amit Nagal <helloin.amit@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi,

if this function has been used to tell the sound core that a device
is in a powersave mode, will the soundcore allow user space to open it?

	Regards
		Oliver

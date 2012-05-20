From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: PCM states and snd_pcm_drain()
Date: Sun, 20 May 2012 18:25:30 +0100
Message-ID: <201205201825.30623.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.ip03ir2.opaltelecom.net (out1.ip03ir2.opaltelecom.net
	[62.24.128.239]) by alsa0.perex.cz (Postfix) with ESMTP id B764D24350
	for <alsa-devel@alsa-project.org>;
	Sun, 20 May 2012 19:21:58 +0200 (CEST)
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
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Hi,

Can snd_pcm_drain() be safely called on a non-running stream - particularly 
one in SND_PCM_STATE_XRUN?  I can demonstrate lock-ups (on rather old Alsa 
versions, though) when _drain is called on a stream in Xrun but it does seem 
to vary between hardwares.

However, the docs at:

http://www.alsa-project.org/alsa-doc/alsa-lib/pcm.html

suggest that it should be fine.

In our case it seems safer (for widest compatibility) to always check for 
SND_PCM_STATE_RUNNING, and call snd_pcm_drop() if the stream is not running.

Regards

Alan

From: Reiner <reiner1210@googlemail.com>
Subject: snd_pcm_open device names
Date: Thu, 06 Mar 2008 00:33:54 +0100
Message-ID: <47CF2DE2.3010506@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.155])
	by alsa0.perex.cz (Postfix) with ESMTP id 603031038D8
	for <alsa-devel@alsa-project.org>; Thu,  6 Mar 2008 00:33:56 +0100 (CET)
Received: by fg-out-1718.google.com with SMTP id l27so1692075fgb.44
	for <alsa-devel@alsa-project.org>; Wed, 05 Mar 2008 15:33:55 -0800 (PST)
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

with
snd_pcm_open (handle, "default", SND_PCM_STREAM_PLAYBACK, 0)
I can open a device twice
with
snd_pcm_open (handle, "plughw:0,0", SND_PCM_STREAM_PLAYBACK, 0)
the 2. call fails with error -16.

The docu says:
The default device is equal to plug plugin with hw plugin as slave.


????
Reiner

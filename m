From: pl bossart <bossart.nospam@gmail.com>
Subject: bug in alsa-lib/snd_pcm_plugin_delay for capture?
Date: Tue, 16 Nov 2010 12:38:42 +0530
Message-ID: <AANLkTi=in6g2YxRKwkCi7H_v0jmJ9tOouc2FK-Rg8iDt@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 9D08A24437
	for <alsa-devel@alsa-project.org>; Tue, 16 Nov 2010 08:08:43 +0100 (CET)
Received: by iwn2 with SMTP id 2so466136iwn.38
	for <alsa-devel@alsa-project.org>; Mon, 15 Nov 2010 23:08:42 -0800 (PST)
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
Cc: wim.taymans@collabora.co.uk
List-Id: alsa-devel@alsa-project.org

Since the PulseAudio commit 29acfd0e0413a9bd126782763ee2dcf10357546 I
am seeing errors messages telling me that the information reported by
snd_pcm_avail_delay is not accurate on the capture path, more
specifically the delay is lower than the available samples.
I spent a little bit of time to find the root cause, and I believe
this is a problem with alsa-lib plugins. I never see any errors when
using hw devices. Conversely I always have these errors when using the
front: plugin (the pulseaudio default).
When I looked at the code, I saw that snd_pcm_plugin_delay and
snd_pcm_plugin_avail_update don't really match. There is additional
code in snd_pcm_plugin_avail_update for the capture case that is not
present when in the delay code, and that causes the delta between the
values reported.
Since I don't understand this code that has all kinds of
mmap_commit/forward/undos, I have to ask higher powers for advice.
Jaroslav, could you take a look at the code and let me know if my
analysis is correct?
Thanks,
-Pierre

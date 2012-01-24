From: Dmitrij K <kdiman@live.ru>
Subject: default is working, but hw:0,0 is do not...
Date: Tue, 24 Jan 2012 23:15:13 +0400
Message-ID: <BLU0-SMTP104845BEB7A301DD21ED66CC18B0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from blu0-omc3-s3.blu0.hotmail.com (blu0-omc3-s3.blu0.hotmail.com
	[65.55.116.78]) by alsa0.perex.cz (Postfix) with ESMTP id 6459824395
	for <alsa-devel@alsa-project.org>; Tue, 24 Jan 2012 20:15:23 +0100 (CET)
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

Hi all.

I have problem with openning a device for playback.


this is working code:
snd_pcm_open(&handle, "default", SND_PCM_STREAM_PLAYBACK, 0);


but this is not working:
snd_pcm_open(&handle, "hw:0,0", SND_PCM_STREAM_PLAYBACK, 0);

I get this is: Device or resource busy


PS: I have been started the `phonon' (KDE sound daemon), and the amarok (audio 
player).


My question: what I need to do for correct open "hw:0,0" for multiply playback 
?


Thanks.

The Best Regards.

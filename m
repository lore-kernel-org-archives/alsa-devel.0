From: Guenther Sohler <guenther.sohler@newlogic.com>
Subject: Problem with mixer settings with alsa and creative audixy
Date: Mon, 18 Feb 2002 20:44:05 +0100 (MET)
Message-ID: <XFMail.020218204405.guenther.sohler@newlogic.com>
Reply-To: Guenther Sohler <guenther.sohler@newlogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Received: from enterprise2.newlogic.com (enterprise2.newlogic.at [194.208.88.1])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id UAA07492
	for <alsa-devel@alsa-project.org>; Mon, 18 Feb 2002 20:44:38 +0100
Received: from enterprise2.newlogic.com (enterprise2 [172.27.1.1])
	by enterprise2.newlogic.com (8.9.2/8.9.2) with ESMTP id UAA02370
	for <alsa-devel@alsa-project.org>; Mon, 18 Feb 2002 20:44:05 +0100 (MET)
Received: from ultra1-2.newlogic.at (ultra1-2.newlogic.at [172.27.101.2])
	by enterprise2.newlogic.com (8.9.2/8.9.2) with ESMTP id UAA02366
	for <alsa-devel@alsa-project.org>; Mon, 18 Feb 2002 20:44:05 +0100 (MET)
Received: (from gsohler@localhost)
	by ultra1-2.newlogic.at (8.10.2+Sun/8.10.2) id g1IJi5I11999
	for alsa-devel@alsa-project.org; Mon, 18 Feb 2002 20:44:05 +0100 (MET)
In-Reply-To: <1014060111.935.2766.camel@phantasy>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hallo gang,

I have a problem with my mixer settings when listening to the sequencer(midi)
in my box.
It is far to silent. I have to set my external amplifier to maximum
amplification to be able to hear the tunes in an normal loudness while hearing
the noise quite easy.
When I play pcm data with this settings, its terribly loud and mankind could
think, i'd crash my speakers!!!!
Actually the only sliders which work is music. i hear midi music if this slider
is maximum
And the Slider 'wave' also works. If i put it to minimum I can bear the volume
of the pcm. All the other sliders dont show any effect althought there are so
many

I have included the output of amixer to show you all the available volume
controls

Simple mixer control 'Master',0
  Capabilities: pvolume pswitch pswitch-joined
  Playback channels: Front Left - Front Right 
  Limits: Playback 0 - 31 
  Front Left: Playback 0 [0%] [on] 
  Front Right: Playback 0 [0%] [on] 
Simple mixer control 'Master Mono',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 31 
  Mono: Playback 0 [0%] [on] 
Simple mixer control 'PCM',0
  Capabilities: pvolume pswitch pswitch-joined
  Playback channels: Front Left - Front Right 
  Limits: Playback 0 - 31 
  Front Left: Playback 0 [0%] [on] 
  Front Right: Playback 0 [0%] [on] 
Simple mixer control 'Center',0
  Capabilities: pvolume pvolume-joined pswitch
  Playback channels: Mono
  Limits: Playback 0 - 100 
  Mono: Playback 0 [0%] [on] 
Simple mixer control 'LFE',0
  Capabilities: pvolume pvolume-joined pswitch
  Playback channels: Mono
  Limits: Playback 0 - 100 
  Mono: Playback 0 [0%] [on] 
Simple mixer control 'Wave',0
  Capabilities: pvolume cvolume pswitch
  Playback channels: Front Left - Front Right 
  Capture channels: Front Left - Front Right 
  Limits: Playback 0 - 100 Capture 0 - 100
  Front Left: Playback 2 [2%] [on] Capture 2 [2%] 
  Front Right: Playback 2 [2%] [on] Capture 2 [2%] 
Simple mixer control 'Wave Center',0
  Capabilities: pvolume pvolume-joined pswitch
  Playback channels: Mono
  Limits: Playback 0 - 100 
  Mono: Playback 100 [100%] [on] 
Simple mixer control 'Wave LFE',0
  Capabilities: pvolume pvolume-joined pswitch
  Playback channels: Mono
  Limits: Playback 0 - 100 
  Mono: Playback 98 [98%] [on] 
Simple mixer control 'Wave Surround',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right 
  Limits: Playback 0 - 100 
  Front Left: Playback 98 [98%] [on] 
  Front Right: Playback 98 [98%] [on] 
Simple mixer control 'Music',0
  Capabilities: pvolume cvolume pswitch
  Playback channels: Front Left - Front Right 
  Capture channels: Front Left - Front Right 
  Limits: Playback 0 - 100 Capture 0 - 100
  Front Left: Playback 100 [100%] [on] Capture 100 [100%] 
  Front Right: Playback 100 [100%] [on] Capture 100 [100%] 
Simple mixer control 'Line',0
  Capabilities: pvolume pswitch pswitch-joined cswitch cswitch-joined
cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Front Left - Front Right 
  Capture channels: Front Left - Front Right 
  Limits: Playback 0 - 31 
  Front Left: Playback 31 [100%] [on] Capture [off] 
  Front Right: Playback 31 [100%] [on] Capture [off] 
Simple mixer control 'CD',0
  Capabilities: pvolume pswitch pswitch-joined cswitch cswitch-joined
cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Front Left - Front Right 
  Capture channels: Front Left - Front Right 
  Limits: Playback 0 - 31 
  Front Left: Playback 31 [100%] [on] Capture [off] 
  Front Right: Playback 31 [100%] [on] Capture [off] 
Simple mixer control 'Mic',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined cswitch
cswitch-joined cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Mono
  Capture channels: Front Left - Front Right 
  Limits: Playback 0 - 15 
  Mono: Playback 15 [100%] [on] 
  Front Left: Capture [off] 
  Front Right: Capture [off] 
Simple mixer control 'Mic Boost (+20dB)',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on] 
Simple mixer control 'Video',0
  Capabilities: pvolume pswitch pswitch-joined cswitch cswitch-joined
cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Front Left - Front Right 
  Capture channels: Front Left - Front Right 
  Limits: Playback 0 - 31 
  Front Left: Playback 31 [100%] [on] Capture [off] 
  Front Right: Playback 31 [100%] [on] Capture [off] 
Simple mixer control 'Phone',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined cswitch
cswitch-joined cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Mono
  Capture channels: Front Left - Front Right 
  Limits: Playback 0 - 15 
  Mono: Playback 15 [100%] [on] 
  Front Left: Capture [off] 
  Front Right: Capture [off] 
Simple mixer control 'PC Speaker',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 15 
  Mono: Playback 15 [100%] [on] 
Simple mixer control 'Aux',0
  Capabilities: pvolume pswitch pswitch-joined cswitch cswitch-joined
cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Front Left - Front Right 
  Capture channels: Front Left - Front Right 
  Limits: Playback 0 - 31 
  Front Left: Playback 31 [100%] [on] Capture [on] 
  Front Right: Playback 31 [100%] [on] Capture [on] 
Simple mixer control 'Capture',0
  Capabilities: volume pswitch pswitch-joined
  Playback channels: Front Left - Front Right 
  Capture channels: Front Left - Front Right 
  Limits: 0 - 15
  Front Left: 15 [100%] Playback [on] 
  Front Right: 15 [100%] Playback [on] 
Simple mixer control 'Mix',0
  Capabilities: cswitch cswitch-joined cswitch-exclusive
  Capture exclusive group: 0
  Capture channels: Front Left - Front Right 
  Front Left: Capture [off] 
  Front Right: Capture [off] 
Simple mixer control 'Mix Mono',0
  Capabilities: cswitch cswitch-joined cswitch-exclusive
  Capture exclusive group: 0
  Capture channels: Front Left - Front Right 


  Front Left: Capture [off] 
  Front Right: Capture [off] 
Simple mixer control 'AC97',0
  Capabilities: pvolume cvolume pswitch
  Playback channels: Front Left - Front Right 
  Capture channels: Front Left - Front Right 
  Limits: Playback 0 - 100 Capture 0 - 100
  Front Left: Playback 98 [98%] [on] Capture 98 [98%] 
  Front Right: Playback 98 [98%] [on] Capture 98 [98%] 
Simple mixer control 'Audigy CD',0
  Capabilities: pvolume cvolume pswitch
  Playback channels: Front Left - Front Right 
  Capture channels: Front Left - Front Right 
  Limits: Playback 0 - 100 Capture 0 - 100
  Front Left: Playback 100 [100%] [on] Capture 100 [100%] 
  Front Right: Playback 100 [100%] [on] Capture 100 [100%] 
Simple mixer control 'External Amplifier Power Down',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on] 
Simple mixer control 'SB Live Analog/Digital Output Jack',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on] 

Can anybody help my mixer to work or even to set to reasonably settings ???
rds guenther



_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

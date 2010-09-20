From: Gavin Stark <gavin@gstark.com>
Subject: Spurious "Unable to find definition
	'defaults.pcm.dmix.device'"
Date: Mon, 20 Sep 2010 11:05:45 -0400
Message-ID: <A0740C4B-D41B-4567-9013-4CC0CE8B92F7@gstark.com>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 1FD9D244AC
	for <alsa-devel@alsa-project.org>;
	Mon, 20 Sep 2010 17:05:49 +0200 (CEST)
Received: by gyh4 with SMTP id 4so1696909gyh.38
	for <alsa-devel@alsa-project.org>; Mon, 20 Sep 2010 08:05:48 -0700 (PDT)
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

I am using ALSA in a gstreamer project.  When playing many videos (with audio) in the same application and the same gstreamer instance every once in a while (maybe once every 500 times) I will receive the following errors (in a call chain that passes through snd_pcm_open)

confmisc.c:1286:snd_func_refer: alsalib error: Unable to find definition 'defaults.pcm.dmix.device'
alsa conf.c:4154:_snd_config_evaluate: alsalib error: function snd_func_refer returned error: No such file or directory
alsa conf.c:4633:snd_config_expand: alsalib error: Evaluate error: No such file or directory
alsa pcm.c:2211:snd_pcm_open_noupdate: alsalib error: Unknown PCM default

The next playback will be fine.  Looking through the ALSA code it seems that the configuration data should be cached and re-used unless the number of config files changes, or the files themselves change (name, device, inode. mtime)  So I am wonder why on one instance of snd_pcm_open I'd end up with this error but not on most previous or subsequent calls.

All the ALSA configuration files are the defaults, I have no ~/.asoundrc, and I'm running version 1.0.23

Thank you,
Gavin Stark

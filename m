From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Spurious "Unable to find definition
	'defaults.pcm.dmix.device'"
Date: Fri, 24 Sep 2010 11:58:24 +0800
Message-ID: <AANLkTinU0svw_fGvPH8yJ3E3mJ76wxXS-tcSKdFP0vft@mail.gmail.com>
References: <A0740C4B-D41B-4567-9013-4CC0CE8B92F7@gstark.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id AC97F103970
	for <alsa-devel@alsa-project.org>;
	Fri, 24 Sep 2010 05:58:24 +0200 (CEST)
Received: by eye27 with SMTP id 27so650641eye.38
	for <alsa-devel@alsa-project.org>; Thu, 23 Sep 2010 20:58:24 -0700 (PDT)
In-Reply-To: <A0740C4B-D41B-4567-9013-4CC0CE8B92F7@gstark.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2010/9/20 Gavin Stark <gavin@gstark.com>

> I am using ALSA in a gstreamer project.  When playing many videos (with
> audio) in the same application and the same gstreamer instance every once in
> a while (maybe once every 500 times) I will receive the following errors (in
> a call chain that passes through snd_pcm_open)
>
> confmisc.c:1286:snd_func_refer: alsalib error: Unable to find definition
> 'defaults.pcm.dmix.device'
> alsa conf.c:4154:_snd_config_evaluate: alsalib error: function
> snd_func_refer returned error: No such file or directory
> alsa conf.c:4633:snd_config_expand: alsalib error: Evaluate error: No such
> file or directory
> alsa pcm.c:2211:snd_pcm_open_noupdate: alsalib error: Unknown PCM default
>
> The next playback will be fine.  Looking through the ALSA code it seems
> that the configuration data should be cached and re-used unless the number
> of config files changes, or the files themselves change (name, device,
> inode. mtime)  So I am wonder why on one instance of snd_pcm_open I'd end up
> with this error but not on most previous or subsequent calls.
>
> All the ALSA configuration files are the defaults, I have no ~/.asoundrc,
> and I'm running version 1.0.23
>
> Thank you,
> Gavin Stark
>
> which distribution are you using ?

if your "default" PCM want to find "defaults.pcm.dmix.device" which is
defined in alsa-lib/src/alsa/alsa.conf

defaults.pcm.dmix.device defaults.pcm.device

AFAIK, Mandriva 2010/2010 spring can be reconfigued to use dmix/dsnoop
instead of pulseaudio

But I have no idea how Mandriva 's alsa-lib support "default:0" and
"default:1"

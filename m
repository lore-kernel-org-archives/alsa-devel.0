From: Gavin Stark <gavin@gstark.com>
Subject: Re: Spurious "Unable to find definition
	'defaults.pcm.dmix.device'"
Date: Tue, 21 Sep 2010 14:02:41 -0400
Message-ID: <619D4838-7959-4769-A23E-A0414CF5EE5B@gstark.com>
References: <mailman.10529.1285004508.2074.alsa-devel@alsa-project.org>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179])
	by alsa0.perex.cz (Postfix) with ESMTP id E9A56243F7
	for <alsa-devel@alsa-project.org>;
	Tue, 21 Sep 2010 20:02:45 +0200 (CEST)
Received: by yxj4 with SMTP id 4so2180671yxj.38
	for <alsa-devel@alsa-project.org>; Tue, 21 Sep 2010 11:02:45 -0700 (PDT)
In-Reply-To: <mailman.10529.1285004508.2074.alsa-devel@alsa-project.org>
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

Colin, thanks for the suggestion.  I tried building and running from the current git HEAD version and still had the same problem.  I also noticed that my app has been causing a core dump due to an infinite recursion in snd_config_searcha_hooks.   I'm not sure what would cause both of these problems.  I'm trying going back to stock packages on my system (Ubuntu 9.04) to see if a version incompatibility.

Gavin Stark

On Sep 20, 2010, at 1:41 PM, alsa-devel-request@alsa-project.org wrote:

> Date: Mon, 20 Sep 2010 16:22:02 +0100
> From: Colin Guthrie <gmane@colin.guthr.ie>
> Subject: Re: [alsa-devel] Spurious "Unable to find definition
> 	'defaults.pcm.dmix.device'"
> To: alsa-devel@alsa-project.org
> Message-ID: <i77u6q$2ma$1@dough.gmane.org>
> Content-Type: text/plain; charset=UTF-8
> 
> 'Twas brillig, and Gavin Stark at 20/09/10 16:05 did gyre and gimble:
>> I am using ALSA in a gstreamer project.  When playing many videos
>> (with audio) in the same application and the same gstreamer instance
>> every once in a while (maybe once every 500 times) I will receive the
>> following errors (in a call chain that passes through snd_pcm_open)
>> 
>> confmisc.c:1286:snd_func_refer: alsalib error: Unable to find
>> definition 'defaults.pcm.dmix.device' alsa
>> conf.c:4154:_snd_config_evaluate: alsalib error: function
>> snd_func_refer returned error: No such file or directory alsa
>> conf.c:4633:snd_config_expand: alsalib error: Evaluate error: No such
>> file or directory alsa pcm.c:2211:snd_pcm_open_noupdate: alsalib
>> error: Unknown PCM default
>> 
>> The next playback will be fine.  Looking through the ALSA code it
>> seems that the configuration data should be cached and re-used unless
>> the number of config files changes, or the files themselves change
>> (name, device, inode. mtime)  So I am wonder why on one instance of
>> snd_pcm_open I'd end up with this error but not on most previous or
>> subsequent calls.
>> 
>> All the ALSA configuration files are the defaults, I have no
>> ~/.asoundrc, and I'm running version 1.0.23
> 
> I guess there is an outside chance that this could be some threading
> race condition in the config stuff.
> 
> Jaroslav recently fixed some threading issues in libalsa2 and config
> stuff. Perhaps it's worth pulling across those changes to your alsa lib
> to see if this is related?
> 
> Can't remember the git commit #'s off hand, but git master of libalsa2
> is probably fine.
> 
> 
> Long shot maybe but an relatively easy one to test.
> 
> Col
> 
> -- 
> 
> Colin Guthrie
> gmane(at)colin.guthr.ie
> http://colin.guthr.ie/
> 
> Day Job:
>  Tribalogic Limited [http://www.tribalogic.net/]
> Open Source:
>  Mageia Contributor [http://www.mageia.org/]
>  PulseAudio Hacker [http://www.pulseaudio.org/]
>  Trac Hacker [http://trac.edgewall.org/]
> 
> 
> 

From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: Spurious "Unable to find definition
	'defaults.pcm.dmix.device'"
Date: Mon, 20 Sep 2010 16:22:02 +0100
Message-ID: <i77u6q$2ma$1@dough.gmane.org>
References: <A0740C4B-D41B-4567-9013-4CC0CE8B92F7@gstark.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 89266244B3
	for <alsa-devel@alsa-project.org>;
	Mon, 20 Sep 2010 17:22:19 +0200 (CEST)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1OxiC7-0007iV-Hx
	for alsa-devel@alsa-project.org; Mon, 20 Sep 2010 17:22:15 +0200
Received: from brent.tribalogic.net ([78.86.109.144])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Mon, 20 Sep 2010 17:22:15 +0200
Received: from gmane by brent.tribalogic.net with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Mon, 20 Sep 2010 17:22:15 +0200
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

'Twas brillig, and Gavin Stark at 20/09/10 16:05 did gyre and gimble:
> I am using ALSA in a gstreamer project.  When playing many videos
> (with audio) in the same application and the same gstreamer instance
> every once in a while (maybe once every 500 times) I will receive the
> following errors (in a call chain that passes through snd_pcm_open)
> 
> confmisc.c:1286:snd_func_refer: alsalib error: Unable to find
> definition 'defaults.pcm.dmix.device' alsa
> conf.c:4154:_snd_config_evaluate: alsalib error: function
> snd_func_refer returned error: No such file or directory alsa
> conf.c:4633:snd_config_expand: alsalib error: Evaluate error: No such
> file or directory alsa pcm.c:2211:snd_pcm_open_noupdate: alsalib
> error: Unknown PCM default
> 
> The next playback will be fine.  Looking through the ALSA code it
> seems that the configuration data should be cached and re-used unless
> the number of config files changes, or the files themselves change
> (name, device, inode. mtime)  So I am wonder why on one instance of
> snd_pcm_open I'd end up with this error but not on most previous or
> subsequent calls.
> 
> All the ALSA configuration files are the defaults, I have no
> ~/.asoundrc, and I'm running version 1.0.23

I guess there is an outside chance that this could be some threading
race condition in the config stuff.

Jaroslav recently fixed some threading issues in libalsa2 and config
stuff. Perhaps it's worth pulling across those changes to your alsa lib
to see if this is related?

Can't remember the git commit #'s off hand, but git master of libalsa2
is probably fine.


Long shot maybe but an relatively easy one to test.

Col

-- 

Colin Guthrie
gmane(at)colin.guthr.ie
http://colin.guthr.ie/

Day Job:
  Tribalogic Limited [http://www.tribalogic.net/]
Open Source:
  Mageia Contributor [http://www.mageia.org/]
  PulseAudio Hacker [http://www.pulseaudio.org/]
  Trac Hacker [http://trac.edgewall.org/]

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: Adding ELD control to alsa-lib hdmi device
Date: Mon, 26 Sep 2011 12:59:42 -0500
Message-ID: <1317059983.2197.9.camel@pbossart-Dell-N7010>
References: <1316793246-819-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<000901cc7a21$0a3bea70$1eb3bf50$@bossart@linux.intel.com>
	<4E7EF7F7.1090100@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id 507F42455B
	for <alsa-devel@alsa-project.org>;
	Mon, 26 Sep 2011 20:00:10 +0200 (CEST)
In-Reply-To: <4E7EF7F7.1090100@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


> I'm not the expert here, but if I were you, I would run
> 
> amixer -D hw:x contents
> amixer -D hw:x scontents
> 
> To see if your controls show up there. If it shows up in scontents, that 
> would be the "simple" mixer interface that PulseAudio uses. If not, 
> using the control api (as being done by "contents") should work.
> 
> Anyway, reading the source code to amixer would then be the first step 
> towards understanding how to enumerate and read mixer controls.

That part was done already. I was looking at PulseAudio integration. By
looking at additional source code, I found out I could retrieve the card
and device number with snd_pcm_info_get_card() and
snd_pcm_info_get_device(). 
I can now read the ELD control from PulseAudio, all I need is to add the
ELD parsing and set the codecs supported by the receiver accordingly.
-Pierre

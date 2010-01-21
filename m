From: Anton Yashin <fynjy-007@yandex.ru>
Subject: Re: Problem with PPH plugin
Date: Thu, 21 Jan 2010 12:30:13 +0000 (UTC)
Message-ID: <loom.20100121T132041-859@post.gmane.org>
References: <hj4rap$ofp$2@ger.gmane.org> <s5hr5pljj7a.wl%tiwai@suse.de>
	<loom.20100120T231250-50@post.gmane.org>
	<s5hfx60csn8.wl%tiwai@suse.de>
	<loom.20100121T115627-815@post.gmane.org>
	<s5h7hrbactp.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 57167243D5
	for <alsa-devel@alsa-project.org>; Thu, 21 Jan 2010 13:30:44 +0100 (CET)
Received: from list by lo.gmane.org with local (Exim 4.50) id 1NXwBI-0000Fa-6k
	for alsa-devel@alsa-project.org; Thu, 21 Jan 2010 13:30:36 +0100
Received: from 95-29-147-16.broadband.corbina.ru ([95.29.147.16])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 21 Jan 2010 13:30:36 +0100
Received: from fynjy-007 by 95-29-147-16.broadband.corbina.ru with local
	(Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 21 Jan 2010 13:30:36 +0100
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

Takashi Iwai <tiwai <at> suse.de> writes:

> You need to set up the configuration to use that plugin.  Just installing
> doesn't enable the plugin setup.  See README.
> 

Thanks, after i added:
defaults.pcm.rate_converter "samplerate"
to ~/.asoundrc i got segmentation fault. I added
crash-with-alsa-plugins-samplerate-enabled.txt to the alsa bugtracker.

> 
> How does firefox make sounds by itself?  Since the bug is triggered when
> you enter some error texts in the search field, I guess this is causing
> a beep or whatever tone.
> 

This is what I had in mind. Beep sound played by firefox. No other browser can
not play sounds on events in my system.

thanks,

Anton.

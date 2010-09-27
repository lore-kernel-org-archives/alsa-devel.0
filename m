From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: how to mandate the use of PCM plugin?
Date: Mon, 27 Sep 2010 18:57:04 +0100
Message-ID: <i7qltg$bph$1@dough.gmane.org>
References: <4C9F6409.6010400@aknet.ru> <20100927005858.GD21247@sirena.org.uk>
	<4CA0221D.6030208@aknet.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id EEF82243E4
	for <alsa-devel@alsa-project.org>;
	Mon, 27 Sep 2010 19:57:19 +0200 (CEST)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1P0Hwv-0006k2-RP
	for alsa-devel@alsa-project.org; Mon, 27 Sep 2010 19:57:13 +0200
Received: from cpc1-sgyl30-2-0-cust258.sgyl.cable.virginmedia.com
	([94.173.13.3]) by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Mon, 27 Sep 2010 19:57:13 +0200
Received: from gmane by cpc1-sgyl30-2-0-cust258.sgyl.cable.virginmedia.com
	with local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Mon, 27 Sep 2010 19:57:13 +0200
In-Reply-To: <4CA0221D.6030208@aknet.ru>
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

'Twas brillig, and Stas Sergeev at 27/09/10 05:48 did gyre and gimble:
>   Hello.
> 
> 27.09.2010 04:58, Mark Brown wrote:
>>> Is it possible to somehow mandate the
>>> use of a PCM plugin? For example, the
>>> PC-Speaker.conf defines the use of softvol
>>> plugin for "default" and "front" devices.
>>> It is still possible for the software to bypass
>>> it by the use of "hw", and some software
>>> does exactly that.
>>> Is it possible to somehow make some
>>> plugin a mandatory?
>> What is the actual problem you are trying to solve here?  It's not
>> possible to *mandate* anything to all users, if nothing else someone
>> with administrative access can always rebuild whatever part of the
>> system is trying to restrict them.
> What I am trying to solve, is the problem
> that people have with my snd-pcsp driver.
> Pulseaudio uses "hw" to bypass some pcm
> plugins, and then people are left with the
> non-functional softvol control, and they blame
> my driver.

FWIW, PA does not actually use "hw" to open the device in most cases. It
actually uses front, surround51 etc. etc.

The volume control pipeline can be summed up here if you're not already
familiar with it:
http://pulseaudio.org/wiki/PulseAudioStoleMyVolumes

which explains how the various mixer elements are used.

It is quite common however for incorrect dB data to be presented from
drivers.

This can be rectified by calculating proper dB information and fixing up
the driver. Some details can be found here:
http://www.pulseaudio.org/wiki/BadDecibel

And today, one of the Canonical guys published his version of a tool to
help here:
http://thread.gmane.org/gmane.comp.audio.pulseaudio.general/7542

Hope this helps.

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

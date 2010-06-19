From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: snd_mixer_selem_get_playback_volume return value
 outside allowed range
Date: Sat, 19 Jun 2010 09:11:08 +0100
Message-ID: <hvhu14$cov$2@dough.gmane.org>
References: <AANLkTikQ5cUjiAtVWhLaR348-eF3xzPFoBkfmEdefJU8@mail.gmail.com>	<4C1A2A9C.3000902@ladisch.de>
	<AANLkTimF2iotSHsjFQFtHYo89yuXZRcYvHNvJm79g4Dw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id B10161037FE
	for <alsa-devel@alsa-project.org>;
	Sat, 19 Jun 2010 10:10:23 +0200 (CEST)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1OPt8A-0003g6-2n
	for alsa-devel@alsa-project.org; Sat, 19 Jun 2010 10:10:22 +0200
Received: from cpc1-sgyl30-2-0-cust258.sgyl.cable.virginmedia.com
	([94.173.13.3]) by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Sat, 19 Jun 2010 10:10:22 +0200
Received: from gmane by cpc1-sgyl30-2-0-cust258.sgyl.cable.virginmedia.com
	with local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Sat, 19 Jun 2010 10:10:22 +0200
In-Reply-To: <AANLkTimF2iotSHsjFQFtHYo89yuXZRcYvHNvJm79g4Dw@mail.gmail.com>
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

'Twas brillig, and Raymond Yau at 19/06/10 03:39 did gyre and gimble:
> 2010/6/17 Clemens Ladisch <clemens@ladisch.de>
> 
>> Raymond Yau wrote:
>>> Should snd_mixer_selem_get_playback_volume() perform range check ?
>>
>> No, it's the responsibility of the control implementation to return
>> valid values (and to check that values that are being set are valid).
>>
>>
>> Regards,
>> Clemens
>> _
>>
> 
> The root cause of the bug is gnome-volume-control allow user to set
> PA_VOLUME to 150% and PA return the value outside the allowed range of the
> "master" volume control of the pulse device
> 
> http://git.gnome.org/browse/gnome-media/commit/?id=cfe5cf8d6826f2eacf0d2b109381ec61dda50185

This is not the root cause of the bug Raymond. I have explained this
several times now.

This is perfectly acceptable behaviour in PA.

I have stated the two possible solutions quite clearly (twice!) in one
of the three threads you've managed to create on this topic.

Please stop going on about the issue and please reply just once to each
email, it's incredibly annoying trying to follow any discussion you
comment on due to this deluge of responses.

Col

-- 

Colin Guthrie
gmane(at)colin.guthr.ie
http://colin.guthr.ie/

Day Job:
  Tribalogic Limited [http://www.tribalogic.net/]
Open Source:
  Mandriva Linux Contributor [http://www.mandriva.com/]
  PulseAudio Hacker [http://www.pulseaudio.org/]
  Trac Hacker [http://trac.edgewall.org/]

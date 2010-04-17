From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: wrong decibel data?
Date: Sat, 17 Apr 2010 10:31:33 +0100
Message-ID: <hqbv5m$cmf$1@dough.gmane.org>
References: <q2s98391a7b1004021121sde36d074m8a70acc142f95d93@mail.gmail.com>	<q2t98391a7b1004021325jbc9e7ddal26063e490fe69254@mail.gmail.com>	<hp744t$5b5$1@dough.gmane.org>
	<r2y4f3252891004160648xa8590219i359286b5a9dece4f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id B493C10380F
	for <alsa-devel@alsa-project.org>;
	Sat, 17 Apr 2010 11:31:44 +0200 (CEST)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1O34NL-0007yE-H8
	for alsa-devel@alsa-project.org; Sat, 17 Apr 2010 11:31:43 +0200
Received: from cpc1-sgyl30-2-0-cust258.sgyl.cable.virginmedia.com
	([94.173.13.3]) by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Sat, 17 Apr 2010 11:31:43 +0200
Received: from gmane by cpc1-sgyl30-2-0-cust258.sgyl.cable.virginmedia.com
	with local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Sat, 17 Apr 2010 11:31:43 +0200
In-Reply-To: <r2y4f3252891004160648xa8590219i359286b5a9dece4f@mail.gmail.com>
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

'Twas brillig, and Raymond Yau at 16/04/10 14:48 did gyre and gimble:
> 2010/4/3 Colin Guthrie <gmane@colin.guthr.ie>

Sorry for the top post but....

Raymond. Your replies are often very disjoint. I see no relevance to my
message here and why you're replying here is beyond me.

It's totally unclear what point you are making and which parts of this
message are your comments and which are Lennart's original comments
that's you've just pasted in.

What are you trying to say?

Col

> I don't agree *Lennart Poettering say *"ALSA does not define any reference
> point for the dB scale it exports in its mixer controls "
> 
> For most of the driver with dB scale,  the 0dB point is the reference point
> ,  the reason is PA developer choose a cubic mapping  "It's now cubic, which
> is supposed to be feel more 'natural'."
> 
> 
> https://tango.0pointer.de/pipermail/pulseaudio-discuss/2009-May/003898.html
> 
>>> Because PA exposes the same volume scale mapping on all hardware.
> 
>>> In 0.9.15 we mapped 0% on the volume scale to -90dB and 100% to 0dB,
> in between the mapping between those percentages and the dB scale was
> linear (i.e. to the effect that we had an overall logarithmic
> mapping).
> 
>>> This mapping is not particularly well chosen since it gives too much
> control over the uninteresting parts below -20dB and too little
> control over the 'interesting' parts above -20dB. That's why I modified
> the mapping in PA git. It's now cubic, which is supposed to be feel
> more 'natural'.
> 
>>> So, coming back to how PA maps those volumes to ALSA: alsamixer will expose
> the exact discrete volume steps of the sound card and show dB
> information just as little help at the side. PA however controls the
> volume in dB and if the hw doesn't provide the requested volume step
> we go to the next higher and then attenuate by the remaining factor in
> software. That way we can provide the same volume range and granularity on all
> hardware with the same mapping from the UI to the attenuation
> factor. So basically, while tha mapping from those percentages to the
> loudness is different in PA and alsamixer, the dB scaling is mostly
> the same -- except when it is not...


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

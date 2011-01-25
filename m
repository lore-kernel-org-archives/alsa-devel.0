From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: Should "Master" control the "Line In" volume
	(loopback)
Date: Tue, 25 Jan 2011 11:38:28 +0000
Message-ID: <ihmcnk$ol3$1@dough.gmane.org>
References: <ihhp04$h9d$1@dough.gmane.org>	<s5h39oi8mf9.wl%tiwai@suse.de>
	<AANLkTik1xUCsy5Fh_pC++c-jwHzsVtV_WKDGehQBOdWx@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 9F79B10391D
	for <alsa-devel@alsa-project.org>; Tue, 25 Jan 2011 12:38:51 +0100 (CET)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1PhhEP-0001Ce-76
	for alsa-devel@alsa-project.org; Tue, 25 Jan 2011 12:38:41 +0100
Received: from brent.tribalogic.net ([78.86.109.144])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Tue, 25 Jan 2011 12:38:41 +0100
Received: from gmane by brent.tribalogic.net with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Tue, 25 Jan 2011 12:38:41 +0100
In-Reply-To: <AANLkTik1xUCsy5Fh_pC++c-jwHzsVtV_WKDGehQBOdWx@mail.gmail.com>
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

'Twas brillig, and Raymond Yau at 25/01/11 02:32 did gyre and gimble:
> 2011/1/24 Takashi Iwai <tiwai@suse.de>
> 
>> At Sun, 23 Jan 2011 17:37:07 +0000,
>> Colin Guthrie wrote:
>>>
>>> Hi,
>>>
>>> I have a question-by-proxy from a user who is confused because his
>>> "Master" kcontrol is affecting the volume via Line In (which he uses to
>>> loopback an analog signal to his speakers).
>>>
>>> I've not got much hardware here for comparison, but I'm pretty sure that
>>> Master usually doesn't affect Line In.
>>>
>>> So couple of questions:
>>>  1. Is it typical that Master affects Line In?
>>
>> Yes, but only for the loopback volume.  It's independent from the
>> line-in capture volume.
>>
>>
> 
>>> ALSA info here: https://bzattachment.mandriva.com/attachment.cgi?id=18170
> 
>>> (for reference the full bug is here:
>>> https://qa.mandriva.com/show_bug.cgi?id=62218<https://qa.mandriva.com/show_bug.cgi?id=62218>
> )
> 
>>> (1) KDE kmix is now pulseaudio aware and as such, kmix does not show the
>>> individual channels in the mixer
>>> I have my Sirrus/XM satellite radio plugged into LINE-IN and I listen to
> it
>>> while using the computer.
> 
> "virtual master" already have "Front" and "Headphone" as slaves
> 
> if the user want to hear the satelite radio from LINE_IN
> 
> Why Kmix does not control those  "Mic Playback" and "Line Playback" any more
> ?
> 
> 
> The max dB of Line and Mic playback volume are +12dB while those slave
> volume controls are only +3dB
> 
> 
> 	control.1 {
> 		comment.access 'read write'
> 		comment.type INTEGER
> 		comment.count 2
> 		comment.range '0 - 63'
> 		comment.dbmin -9150
> 		comment.dbmax 300
> 		iface MIXER
> 		name 'Front Playback Volume'
> 		value.0 61
> 		value.1 61
> 	}
> 
>  control.3 {
> 		comment.access 'read write'
> 		comment.type INTEGER
> 		comment.count 2
> 		comment.range '0 - 63'
> 		comment.dbmin -9150
> 		comment.dbmax 300
> 		iface MIXER
> 		name 'Headphone Playback Volume'
> 		value.0 61
> 		value.1 61
> 	}
> 
> 
> 	control.11 {
> 		comment.access 'read write'
> 		comment.type INTEGER
> 		comment.count 2
> 		comment.range '0 - 31'
> 		comment.dbmin -3450
> 		comment.dbmax 1200
> 		iface MIXER
> 		name 'Line Playback Volume'
> 		value.0 28
> 		value.1 28
> 	}
> 
> 
> 
> http://www.analog.com/en/audiovideo-products/audio-codecs/ad1983/products/product.html

The problem is not to do with the kcontrols you mention ("Mic Playback"
and "Line Playback"). The problem is that the user does NOT want Master
kcontrol to interfere with it, but it does. Obviously PulseAudio
controls the whole mixer pipeline, including Master and thus, the
general "Sink Volume" of his device is affecting the volume of
loopbacked audio.

I thought I had stated this clearly, but I guess not :s

Col

PS Of course when KMix is using PulseAudio support all this complexity
is hidden from the user. We do ultimately (in PA) need to provide a neat
way to pass through certain kcontrols to the user - possibly by way of a
virtual stream of some kind - but this is a different issue and
unrelated to the primary question I was asking.

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

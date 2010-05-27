From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: wrong decibel data?
Date: Thu, 27 May 2010 15:43:59 +0100
Message-ID: <htm0et$eb4$1@dough.gmane.org>
References: <q2s98391a7b1004021121sde36d074m8a70acc142f95d93@mail.gmail.com>	<q2t98391a7b1004021325jbc9e7ddal26063e490fe69254@mail.gmail.com>	<hp744t$5b5$1@dough.gmane.org>	<r2y4f3252891004160648xa8590219i359286b5a9dece4f@mail.gmail.com>	<hqbv5m$cmf$1@dough.gmane.org>	<g2t4f3252891004201932k53dae8a1me8f7e968f8a28b5b@mail.gmail.com>	<hqmbmm$hsj$1@dough.gmane.org>	<i2r4f3252891004211816ldfedff21nfe61537043c9b22f@mail.gmail.com>	<htls4d$phr$1@dough.gmane.org>
	<4BFE7840.4070004@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 6CFC7103A7E
	for <alsa-devel@alsa-project.org>;
	Thu, 27 May 2010 16:43:54 +0200 (CEST)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1OHeJM-0001ja-Rq
	for alsa-devel@alsa-project.org; Thu, 27 May 2010 16:43:52 +0200
Received: from brent.tribalogic.net ([78.86.109.144])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 27 May 2010 16:43:52 +0200
Received: from gmane by brent.tribalogic.net with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 27 May 2010 16:43:52 +0200
In-Reply-To: <4BFE7840.4070004@ladisch.de>
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

'Twas brillig, and Clemens Ladisch at 27/05/10 14:48 did gyre and gimble:
> Colin Guthrie wrote:
>> state.Intel {
>> 	control.1 {
>> 		comment.access 'read write'
>> 		comment.type INTEGER
>> 		comment.count 2
>> 		comment.range '0 - 31'
>> 		comment.dbmin -4650
>> 		comment.dbmax 0
>> 		iface MIXER
>> 		name 'Master Playback Volume'
>> 		value.0 30
>> 		value.1 30
>> 	}
> 
> This is the hardware volume control.
> 
>> 	control.11 {
>> 		comment.access 'read write user'
>> 		comment.type INTEGER
>> 		comment.count 2
>> 		comment.range '0 - 255'
>> 		comment.tlv '0000000100000008ffffec1400000014'
>> 		comment.dbmin -5100
>> 		comment.dbmax 0
>> 		iface MIXER
>> 		name 'PCM Playback Volume'
>> 		value.0 253
>> 		value.1 253
>> 	}
> 
> This is the emulated software volume control that is created by the
> softvol plugin.  This control gets recreated by "alsactl restore" even
> when the plugin is not running.
> 
> Might it be possible that PA is trying to use this, but that it doesn't
> have any effect because PA is using PCM device hw:0?  (Try unloading
> snd-hda-intel and then deleting that entry from /etc/asound.state.)

PA should play nice with the softvol plugin so I don't think this is the
bit that is at fault.

I strongly suspect that the reason has already been correctly identified
a while ago, which is that this card considers -48dB silent where as PA
assumes this level is -200dB. I believe it was Raymond who pointed out
the -48dB level in the HDA spec before on this list.

I'm not sure of the internals, but things do indeed go silent when the
volume reaches the magic -48dB mark (which is around the 14% mark with
the current cubic mapping).

I suspect that if I were to define infinity to be 48.0 in PA, everything
would work nicely.

What I think is then ultimately needed is a way to ensure that everyone
sings from the same hymn sheet regarding the real world value of -inf dB.


I was hoping Lennart would have commented on this thread by now, so I'll
try and prod him to get some proper input as I'm very much flailing
around wildly in the dark!


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

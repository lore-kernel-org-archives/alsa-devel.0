From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: [snd_via82xx] EAGAIN on snd_pcm_prepare after
	EPIPE on mmap_commit
Date: Fri, 24 Jul 2009 17:12:24 +0100
Message-ID: <h4cmh8$fip$2@ger.gmane.org>
References: <494d907f0907230821ga09abcflb770b020b21b3735@mail.gmail.com>
	<s5hocrbwgu6.wl%tiwai@suse.de>
	<494d907f0907231023h26829d85ub13caec4a56ddec8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 81DA024665
	for <alsa-devel@alsa-project.org>;
	Fri, 24 Jul 2009 18:15:06 +0200 (CEST)
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1MUNQF-0006oK-EG
	for alsa-devel@alsa-project.org; Fri, 24 Jul 2009 16:15:03 +0000
Received: from brent.tribalogic.net ([78.86.109.144])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Fri, 24 Jul 2009 16:15:03 +0000
Received: from gmane by brent.tribalogic.net with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Fri, 24 Jul 2009 16:15:03 +0000
In-Reply-To: <494d907f0907231023h26829d85ub13caec4a56ddec8@mail.gmail.com>
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

'Twas brillig, and rom1dep at 23/07/09 18:23 did gyre and gimble:
> 2009/7/23 Takashi Iwai <tiwai@suse.de>:
>> At Thu, 23 Jul 2009 17:21:44 +0200,
>> rom1dep wrote:
>>> Hello !
>>> I am encountering some issues with pulseaudio : after some time and
>>> for no evident reason PA stops routing the sound.
>>> That's what I get with $pulseaudio -vvv :
>>> http://pastebin.mandriva.com/13648 (got from a 2.6.29.6_mdv kernel)
>>> running $pacmd list-sinks when stuck gives :
>>> http://pastebin.mandriva.com/13649
>>>
>>> Our pulseaudio integrator Colin Guthrie concluded :
>>> "OK, so what is happening is that some alsa level problem is occurring
>>> (due to mmap). Pulse tries to recover from this but cannot. The alsa
>>> sink (and the whole card) is subsequently unloaded due to this fatal
>>> error."
>>> And now.. a quick paste from irc :
>>> "[00:44:20] <coling> Jul 22 14:04:29 <mezcalero>     coling: driver
>>> issue i am pretty sure
>>> [00:44:20] <coling> Jul 22 14:04:33 <mezcalero>     i saw that before once
>>> [00:44:20] <coling> Jul 22 14:04:55 <mezcalero>     coling: i.e.
>>> EAGAIN on snd_pcm_prepare after EPIPE on mmap_commit
>> This is odd.  EAGAIN is returned only at open, read/write and drain
>> ioctls.
>>
>> Could you track with strace?
>>
>>
>> Takashi
>>
> 
> It wasn't easy : that big output made my config swap and finally
> pulseaudio leave for "E: cpulimit.c: Received request to terminate due
> to CPU overload."
> but :
> http://pastebin.mandriva.com/13665

You probably want to repost using a different pastebin... our stupid one 
cuts the posts short at some pointlessly low value... I've asked about 
this to get it made bigger but I don't know who looks after it. I'd 
recommend pastebin.com.

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

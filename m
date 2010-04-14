From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: ALSA application programming: route audio from one
	PCM to another
Date: Wed, 14 Apr 2010 10:00:11 +0100
Message-ID: <hq406t$sjk$1@dough.gmane.org>
References: <4BC48C74.5010102@gmail.com> <hq25p7$8kd$1@dough.gmane.org>
	<4BC58082.6090508@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 46BCF244C0
	for <alsa-devel@alsa-project.org>;
	Wed, 14 Apr 2010 11:00:33 +0200 (CEST)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1O1ySW-0005JZ-U1
	for alsa-devel@alsa-project.org; Wed, 14 Apr 2010 11:00:32 +0200
Received: from brent.tribalogic.net ([78.86.109.144])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 14 Apr 2010 11:00:32 +0200
Received: from gmane by brent.tribalogic.net with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 14 Apr 2010 11:00:32 +0200
In-Reply-To: <4BC58082.6090508@gmail.com>
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

'Twas brillig, and Stefan Schoenleitner at 14/04/10 09:44 did gyre and
gimble:
> Colin Guthrie wrote:
>> 'Twas brillig, and Stefan Schoenleitner at 13/04/10 16:23 did gyre and
>> gimble:
>>> Hi,
>>>
>>> I finally managed to write an ALSA I/O plugin that does what I want.
>>> The plugin supports both playback and capture.
>>>
>>> Now I would like to write a simple audio application that takes audio
>>> samples
>>>
>>> 	* from the microphone and plays it back on my plugin
>>> and
>>> 	* from the plugin (capture) and plays it back on the speakers
>>>
>>
>> This sounds like something that would be more appropriate for jack
>> http://jackaudio.org/
> 
> Thanks for your response, that really sounds like a job for JACK.
> 
> However, due to the nature of jack it seems that running the jack-daemon
> is always necessary.
> As my code is supposed to work on a very small scale embedded target, I
> would prefer to have a small stand-alone application that does not
> require a running jack-daemon.
> 
> * Do you know if it is possible to use the jack functionality without
> having to run the jack-daemon ?

I'm afraid not. Like PulseAudio, Jack needs the daemon to do all the
hard stuff.

I guess you'll just have to write some small app that does the
record/playback. I doubt it'll be that hard.

That said, with this approach, the fact that you've got an alsa plugin
doing the processing in the middle seems slightly irrelevant... why not
have your app sample the input, do the DSP it needs to do, then play the
output? No need to: sample, play [process] sample, play. Rather: sample
[process] play.

Perhaps I'm not understanding the other needs/use cases of the plugin
tho'. Just idle thoughts :)

>>> Hence as long as the application is running, it should do the above.
>>>
>>> * Is there a special ALSA way to route audio from one PCM to another ?
>>>
>>> * If not, I suppose it would just work if I open the plugin PCM and the
>>> hw PCM at the same time and copy audio frames between them ?
>>
>> Dealing with this can be quite complex, especially if the pcms are
>> clocked of different sources, you have to deal with a degree of
>> resampling to ensure that clock skew doesn't get out of control.
> 
> Both PCMs are on the same machine, hence they should be clocked from the
> same source as well ?

I believe this is quite likely, but I'm not really certain that it holds
true in all cases.

Someone more clued up than me may be able to comment.

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

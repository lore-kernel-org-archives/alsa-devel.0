From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: Adding a "capture" device naming scheme
Date: Wed, 12 Jan 2011 11:12:42 +0000
Message-ID: <igk2ba$mfs$1@dough.gmane.org>
References: <igi861$q8o$1@dough.gmane.org>	<AANLkTikGo8FMVf_9UMBa+iOhgXXdtWFdePk_7=6zwDhA@mail.gmail.com>	<s5h62tuipeh.wl%tiwai@suse.de>
	<igjr5i$jjb$1@dough.gmane.org>
	<alpine.LNX.2.00.1101121013330.28150@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 0214324519
	for <alsa-devel@alsa-project.org>; Wed, 12 Jan 2011 12:13:00 +0100 (CET)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1PcydJ-00051f-TJ
	for alsa-devel@alsa-project.org; Wed, 12 Jan 2011 12:12:53 +0100
Received: from brent.tribalogic.net ([78.86.109.144])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 12 Jan 2011 12:12:53 +0100
Received: from gmane by brent.tribalogic.net with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 12 Jan 2011 12:12:53 +0100
In-Reply-To: <alpine.LNX.2.00.1101121013330.28150@eeebox2.perex-int.cz>
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

'Twas brillig, and Jaroslav Kysela at 12/01/11 09:17 did gyre and gimble:
> On Wed, 12 Jan 2011, Colin Guthrie wrote:
> 
>> 'Twas brillig, and Takashi Iwai at 12/01/11 06:53 did gyre and gimble:
>>> I read Colin meant front:CARD=x is incorrect while hw:CARD is a lowlevel
>>> access that one doesn't always want.
>>
>> For capture. Yes that's what I was meaning.
>>
>>> I'm fine with creating a new name, but wondering which name is best.
>>> Basically what you want here is the default use-case but without
>>> dsnoop like the current "default".  (If dsnoop were acceptable,
>>> "default" should have been used in most places.)
>>> "capture" may be also too ambiguous for defining that, I'm afraid.
>>
>> Yeah, "default" wont work here due to it being redirected to PulseAudio
>> (as opposed to dsnoop) in this use case, so we need to avoid that name :s
>>
>> IMO "capture" is quite clear (or at least as clear as "front" is for
>> playback!), but here are a few other suggestions:
>>
>> "record"
>> "input"
>> "read"
>>
>>
>> Personally, "input" and "capture" are my two favourites.
> 
> The question is, if we should identify more the source of the captured 
> data. The default device does the basic job.
> 
> analogin
> iec958in
> 
> Eventually:
> 
> linein
> micin
> iec958in


Well in the case of digital in I think "iec958" (or spdif) is used
directly (but could be wrong).

In 98% of cases, using front for recording works fine, but it is
technically wrong as Raymond pointed out several times on other threads.
Is it "technically wrong" to use iec958 for input? If so the then same
change we'll need to add for analog recoding would also cope quite fine
with digital recording, so adding a iec958in wouldn't really be a
problem in my book.

As for line vs mic etc, is this not usually handled by different
[sub]devices and/or switch elements? Would it really be possible to wrap
up such permutations in a config name without a lot of extra work?
(please forgive my ignorance here)


If we can't decide, we'll just have to tweak PA to use hw: directly for
input but it would seem like a cleaner design to have a proper name for it.

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

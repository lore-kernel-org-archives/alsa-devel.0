From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: alsactl adds volume controls?
Date: Wed, 29 Sep 2010 15:26:38 +0100
Message-ID: <i7viav$kjb$1@dough.gmane.org>
References: <4C77CE1D.2070501@canonical.com>
	<4C77DD09.3060909@ladisch.de>	<4C78059B.50801@canonical.com>	<AANLkTi=cgE30nh1LPj84=Jv+YfJZWTj8BF3B5kNSGMTb@mail.gmail.com>	<s5h4oec8r6f.wl%tiwai@suse.de>
	<4C7BABA9.1010100@canonical.com>	<s5hlj7ont8e.wl%tiwai@suse.de>	<4C7E549E.4080505@canonical.com>
	<s5hr5hczi06.wl%tiwai@suse.de>	<4C7F6D5D.7020101@canonical.com>	<alpine.LNX.2.00.1009021553460.10278@eeebox2.perex-int.cz>	<4C7FB2CF.5060505@ladisch.de>	<alpine.LNX.2.00.1009021721100.10278@eeebox2.perex-int.cz>	<4C7FC85B.4000009@ladisch.de>
	<alpine.LNX.2.00.1009021926120.10278@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 116741038D1
	for <alsa-devel@alsa-project.org>;
	Wed, 29 Sep 2010 16:26:49 +0200 (CEST)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1P0xcN-00068T-Se
	for alsa-devel@alsa-project.org; Wed, 29 Sep 2010 16:26:47 +0200
Received: from brent.tribalogic.net ([78.86.109.144])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 29 Sep 2010 16:26:47 +0200
Received: from gmane by brent.tribalogic.net with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 29 Sep 2010 16:26:47 +0200
In-Reply-To: <alpine.LNX.2.00.1009021926120.10278@eeebox2.perex-int.cz>
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

Hi all,

I'm just re-kickstarting this thread after discussing this issue with
David on IRC.

'Twas brillig, and Jaroslav Kysela at 02/09/10 18:28 did gyre and gimble:
> On Thu, 2 Sep 2010, Clemens Ladisch wrote:
> 
>> Jaroslav Kysela wrote:
>>> On Thu, 2 Sep 2010, Clemens Ladisch wrote:
>>>> What is the reason for alsactl not trying to restore inactive controls?
>>>
>>> Most (maybe all - need to check drivers) of inactive control values are
>>> reset to the original value when they're going to the active state.
>>
>> (There are both kinds of inactive controls.)
>>
>> It wouldn't hurt to restore controls that will be reset later.
>>
>>> Maybe we need to add another flag - inactive but persistent.
>>
>> This is more or less implied by the current documentation:
>> /* control does actually nothing, but may be updated */
>>
>> I'd rather add a flag for controls that will be reset by the driver,
>> because this is an action that is done in addition to the 'normal'
>> control behaviour.
>>
>> One could also say that inactive controls that will be reset have a
>> value only as long as they are active, i.e., while inactive, there is
>> no current value.  In other words, while inactive, they should be
>> neither readable nor writable.  (Hmm, one could make them just readonly
> 
> Another good idea.

Ultimately there are a lot of ideas here on how to solve this, but I'd
also like to see something quite practical (new APIs etc. can be useful
but I'm still not quite understanding things as they work currently, so
perhaps my naive summary can provide some insight by being so out of
touch! (I live in hope!)).


>From what I understand:
 1. *All* HDA devices have a PCM softvol control. Some use this actively
due to the fact they lack a real h/w volume control. Others do not
technically "use" it.

 2. The PCM softvol has a 51dB range. When it's "active" this presumably
works. When it's inactive (which appears to be the case on my primary
machine), regardless of what the it's set to, there will be 0dB change.

 3. There is a flag when opening PCM device (SND_PCM_NO_SOFTVOL) that
will cause the PCM mixer to not have any impact in *all* cases rather
than just in the "inactive" case.

 4. When looking at only mixer elements (e.g. not opening any streams)
there is no way to know whether a given mixer is active or not (with
current APIs), i.e. From using only the mixer related API calls, the PCM
volume range is always presented as being 0 -> -51dB for the PCM
softvol, even when it actually has no effect (i.e. the information
presented is highly misleading).  Is there a way to know which mixers
are active when you open a pcm stream? (and this question applies to
both with and without using the SND_PCM_NO_SOFTVOL flag). I don't
personally know the API hence this newbie-level question.


Firstly, are all of the above statements correct? Have I fundamentally
misunderstood something?


Moving on, here are my observations about some of the comments on this
thread so far.

1. The point about opening "front" for both playback and capture in PA
is valid but irrelevant in this case. We are, for the moment, only
concerned about playback streams and ensuring that the mixers apparently
used to control the volume for that stream are accurate.

2. Using the UCM system to indicate whether a mixer element is relevant
or not is a potential nice solution in the future, but it's not
available now and it will also require that UCM metadata is available.
Perhaps some internal awareness of a mixer being "active" or not can
expose this UCM rule automatically? If that is not the case then it will
take years for static UCM metadata to be produced to fix this problem
and also years for alsa clients to actually use it (thankfully there are
not that many alsa clients what would *need* to make use of this -
mostly just PA and some independent mixer apps).

3. Using SND_PCM_NO_SOFTVOL at all times would mean we would have to
ignore all softvol mixer elements. It is perfectly possible to control
the mixer pipeline with no streams active. This could be a solution,
(i.e. using this flag at all times in PA, and ignore all softvol mixers)
but is it the right one?

I'm also not 100% sure about using this in PA. It was used back in 2008:

commit ff3f43525d0b528d43a0480d596973d07c920580
Author: Lennart Poettering <lennart@poettering.net>
Date:   Wed Jul 16 11:12:07 2008 +0200

    try to bypass alsa softvol, since it is broken when used with
snd_pcm_rewind()

but it was removed again in:

commit 1c4ad4b64be168d13a31c8147505b88967be4afb
Author: Lennart Poettering <lennart@poettering.net>
Date:   Sun Aug 31 16:25:37 2008 +0200

    rework device opening code: work around broken SND_PCM_NO_AUTO_xxx
support in ALSA <= 1.0.17a


I'm not 100% sure if this second commit intended to remove the
NO_SOFTVOL option of if it was simply removed in the wash accidentally.
I'll try and confirm with Lennart.



Potential solutions would include:
 1. If the "correct" solution is to just use SND_PCM_NO_AUTO in PA, and
then deliberately/actively ignore any softvol mixers, then nothing needs
done at the alsa level I guess.

 2. Simply fixing things to NOT add the inactive PCM mixer when it's not
needed. I'm not sure I actually understand why this isn't an option to
fix this problem but that generally seems to be the suggestion by those
in the know. I would rather this mixer was simply absent on my machine.

 3. Add an API to know whether a mixer element is active (IMO
is_writable() is insufficient. If the current value of PCM says it's set
to e.g. -28dB then we need to believe what it says. Even if we decide
not to write new values to PCM mixer, we have to believe what it says -
we is_writable() does not solve the overall problem of knowing the
ultimate product of the various attenuations in the pipeline).

 4. *Always* activate PCM softvol. I mean, why is it even inactive in
the first place? If it worked to provide "extra" attenuation in addition
to the Master (which is presumably h/w based) control in the cases where
softvol wasn't really needed, then it would not be lying about the dB
range it claims to support. David did suggest that by always activating
it, it would result in extra memory/copy (and thus power) overhead which
is a valid reason for not adopting this approach. It would however solve
the immediate problem of the lies the mixer current tells! Perhaps some
flag could be added to enable this by default but allow it to be turned
off when power-saving is of critical importance?

 5. Would it be possible to adjust the range reported by the softvol
plugin when it is inactive. e.g. could a an "active" PCM say "I offer
51dB range in 255" steps while an "inactive" one could say "I offer
0.1dB range in 1 step". PA could easily be patched to ignore a mixer
which has such a trivially low range.



I'm not sure how sensible any of the above suggestions, nor how accurate
the observations, but hopefully it'll be enough to kick start the
discussion again.

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

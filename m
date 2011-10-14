From: David Henningsson <david.henningsson-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
Subject: Re: [pulseaudio-discuss] alsa ucm in pulseaudio
Date: Fri, 14 Oct 2011 10:57:08 +0200
Message-ID: <4E97F964.4080701@canonical.com>
References: <CAJ4+uhUoBqTfDdDGEo_cKpzpdOmCPODfts7Afij1vafW+hwG=w@mail.gmail.com>
	<4E97D81E.4080607@canonical.com>
	<CAJ4+uhUL-mR_=Tot4XBbQuMRgbg45raL+058prXgEmrpG5Jukg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <CAJ4+uhUL-mR_=Tot4XBbQuMRgbg45raL+058prXgEmrpG5Jukg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: Feng Wei <feng.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, General PulseAudio Discussion <pulseaudio-discuss-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Colin Guthrie <gmane-D409yXkIzt2rnn0nCzrM/w@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Liam Girdwood <lrg-l0cyMroinI0@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On 10/14/2011 09:39 AM, Feng Wei wrote:
> 2011/10/14 David Henningsson<david.henningsson-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>:
>> On 10/14/2011 04:47 AM, Feng Wei wrote:
>>>
>>> Hi Liam, Mark, Colin, and all,
>>>    I study the codes in pulseaudio and alsa ucm patch recently, and
>>> create a page of my study result. I appreciate your feedback. The page
>>> is at
>>> https://wiki.linaro.org/WorkingGroups/Middleware/Multimedia/Specs/1111/AudioIntegration/UCMPulseAudio/Analyzation.
>>>    Also if needed, I'm glad to contribute to the integration of alsa
>>> ucm in pulseaudio.
>>>    Thank you.
>>
>> Oh, nice diagrams :-) Some of them might be useful additions to the
>> PulseAudio wiki.
> Thanks :-)
>>
>> I think the modelling of UCM concepts onto PulseAudio concepts is an
>> important discussion. In PulseAudio, profiles are mainly connected to device
>> strings, how to open the devices, channels supported, whereas ports are just
>> alsa mixer kcontrol changes. UCM verbs, as I understand it, contain both.
> My understanding is profile:port and verb:device/modifier are both
> hierarchical. e.g. we have an alsa device string hw:0,0, and some
> mixer controls for route speaker or headset. In pa profile, we
> describe a profile output:analog-stereo with two ports, one for
> speaker, and the other for  headset. In ucm, we define verb "hifi" and
> two excluded devices speaker and headset, both of the devices have
> PlaybackPCM hw:0,0. And we can also define two modifiers to switch
> between speaker and headset. So we can create profile by verb and
> create profile input/output mappings by devices(merge the same hw
> device) and create ports by modifier. I'm not sure if it break the
> original ucm concepts, but I think it can work.

There is also the "Use Case" concept in UCM, Is there always exactly one 
verb for every use case? If not, one might wonder if "Use Case" or 
"Verb" is what should correspond to the "Profile" concept.

Card, Sink/Source, Profile and Port are the core concepts in PulseAudio. 
I think UCM should use alsa-sink, alsa-card and alsa-source, but the 
rest of the stuff: pa_alsa_profile_*, pa_alsa_path_*, pa_alsa_mapping - 
in short, everything in alsa-mixer.h, I don't think the UCM 
implementation should touch them. They are too tightly coupled with the 
existing ideas of how to map ALSA kcontrols to Profiles and Ports, 
something that UCM does in its own way. So in my opinion, you should 
forget about mappings - it's Profile and Port (and Sink/Source) we need 
to match against.

As for ports, this again depends on what is mutually exclusive and what 
could be used in parallel, I vaguely remember "Modifiers" as something 
that could be used in parallel with existing streams, if so, they need 
to be separate sinks/sources.

>> In this context, I have a question: Can more than verb be active at a time
>> for a specific card (e g can both "hifi" and "record" be active for the
>> panda), and if so, how is it described in UCM what verbs that can coexist
>> and which ones are mutually exclusive? I believe PulseAudio is going to need
>> that information in order to be able to know how to create its profiles.
> In current alsa ucm implementation, only an active verb is permitted,
> but it can have more than one devices enabled. In my mind, in "hifi"
> mode, we can still record something because we have some devices
> (playback or capture) available.

Hmm, for every sink/source, there can only be one active port at a time. 
Also, ports on the same sink/source can be changed on the fly without 
restarting the stream. Does this fit with the description of a UCM "Device"?

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic

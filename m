From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH] ascenario: Add scenario support to alsa-lib
Date: Tue, 6 Oct 2009 11:00:18 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0910061048410.31529@eeebox2.perex-int.cz>
References: <1254390436-5283-1-git-send-email-stefan@datenfreihafen.org>
	<1254390436-5283-2-git-send-email-stefan@datenfreihafen.org>
	<20091001122835.GC14417@sirena.org.uk>
	<20091001131948.GA5936@excalibur.local>
	<20091001150849.GE5936@excalibur.local>
	<20091005082747.GA3983@excalibur.local>
	<alpine.LNX.2.00.0910051111220.31529@eeebox2.perex-int.cz>
	<20091005093502.GC3983@excalibur.local>
	<alpine.LNX.2.00.0910060949070.31529@eeebox2.perex-int.cz>
	<s5hzl847w3q.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 2934C10381F
	for <alsa-devel@alsa-project.org>;
	Tue,  6 Oct 2009 11:00:19 +0200 (CEST)
In-Reply-To: <s5hzl847w3q.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA development <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Ian Molton <ian@mnementh.co.uk>, Graeme Gregory <gg@slimlogic.co.uk>, Stefan Schmidt <stefan@datenfreihafen.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, 6 Oct 2009, Takashi Iwai wrote:

> At Tue, 6 Oct 2009 10:23:56 +0200 (CEST),
> Jaroslav Kysela wrote:
>>
>> Hi,
>>
>>  	Some ideas, proposal for further discussion...
>>
>> On Mon, 5 Oct 2009, Stefan Schmidt wrote:
>>
>>> Hello.
>>>
>>> On Mon, 2009-10-05 at 11:14, Jaroslav Kysela wrote:
>>>> On Mon, 5 Oct 2009, Stefan Schmidt wrote:
>>>>
>>>>> On Thu, 2009-10-01 at 17:08, Stefan Schmidt wrote:
>>>>>>
>>>>>> For an updated patch with all your comments inlcuded see below.
>>>>>
>>>>> Here is another update on this patch. Fixed a problem I introduced in the last
>>>>> iteration and changed the config tokens from MasterPlaybackVolume to Master
>>>>> Playback Volume, etc. That's based on a siggestion from Mark which we had
>>>>> offlist. Let me quote it here to explain the good reasoning behind it.
>>>>
>>>> Question: What's the IDs (integers) returned with
>>>> snd_scenario_get_master_playback_volume() etc. functions?
>>>
>>> That is part of the code Liam wrote, but let me answer it (and maybe
>>> Liam chime in if it is wrong or needs more explanation).
>>>
>>> It's just the numid of an alsa control which should be used as master
>>> playback, etc in this scenario. It aliases the function we can use with
>>> ascenario to the real ones in alsa which can bedifferent for different
>>> scenarios.
>>
>> It's not very clear. The exported functions should be documented at least
>> with doxygen.
>>
>> Also, I would move all _get_ functions to one with this interface:
>>
>> #define SND_SCENARIO_KEY_KCTL_MASTER_PLAYBACK_VOLUME	1
>> .....
>>
>> int snd_scenario_get(scenario, int key, void *result);
>>
>> It will allow us to extend this interface without adding many functions in
>> future, something like:
>>
>> #define SND_SCENARIO_KEY_PCM_PLAYBACK			11
>> .....
>
> I find it's good to have a generic interface, too, but a void pointer
> is discouraging.  It's too ambiguous and inconvenient when you use it
> ("What type do I have to pass for SND_SCENARIO_XXX on earth???").

It might be solved with inline functions in header files to cover all 
types. My opinion is to not use so much function in alsa-lib for each 
trivial interfaces.

> I personally have no particular preference regarding the configuration
> syntax between these two, but...
>
>> Also, I would like to consider moving the parser from alsactl
>> initialization code (see alsactl_init.c in alsa-utils package) to alsa-lib
>> and use this parser also for these files. It gives much flexibility,
>> although udev-like syntax is not ideal, I know.
>
> Not ideal, it's awful :)  So please don't spread it over...

It's not so awful. The base syntax is very clear in form key->value 
binding. What's awful on this?

CTL{reset}="mixer"
CTL{name}="Master Playback Volume", CTL{value}="-21dB"
CTL{name}="Master Playback Switch", CTL{value}="on"
CTL{name}="Headphone Playback Switch", CTL{value}="on,on"
CTL{name}="Front Playback Volume", CTL{value}="-29dB,-29dB"
CTL{name}="Front Playback Switch", CTL{value}="on,on"
CTL{name}="PCM Playback Volume", CTL{value}="0dB,0dB"

Solving complex tasks requires complex description. I'm open to 
discuss things to make this udev-like syntax more nice. The most 
irritating thing in this syntax are build-in commands for me, but having 
another special key for these actions are not a big win, because 
configuration writers must learn them.

 						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.

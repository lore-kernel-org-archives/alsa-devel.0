From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [RFC] Add scenario management
Date: Fri, 2 Oct 2009 11:58:47 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0910021113500.31529@eeebox2.perex-int.cz>
References: <1254390436-5283-1-git-send-email-stefan@datenfreihafen.org>
	<s5hws3egnwc.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 879E5103988
	for <alsa-devel@alsa-project.org>;
	Fri,  2 Oct 2009 11:58:49 +0200 (CEST)
In-Reply-To: <s5hws3egnwc.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Stefan Schmidt <stefan@datenfreihafen.org>
List-Id: alsa-devel@alsa-project.org

On Fri, 2 Oct 2009, Takashi Iwai wrote:

> At Thu,  1 Oct 2009 11:47:14 +0200,
> Stefan Schmidt wrote:
>>
>> Hello.
>>
>> This patchset add support for scenario management, aka use cases, in alsa-lib
>> and example programs in alsa-utils. It allows to adjust the current audio kcontrol
>> settings from a prespective of a changed use case like the switch from listening
>> to music on your phone to an incoming phone call and back.
>
> Great, I've been waiting for this :)
>
>> To achieve this it offers control aliasing for playback, capture master and
>> switch as well as the option to post- and prefix a sequence of control changes
>> avoiding pops and other unwanted noise.
>>
>> This is of course not meant to replace gstreamer, PulseAudio or a sound server,
>> but is meant to work in tandem with such audio software. We think alsa-lib is
>> the best place for this as it will be used on small embedded system which only
>> use alsa from the full stack of audio libs in linux. We see potential for
>> desktop usage as well though.
>
> Agreed.  If any need, I can merge it to salsa-lib, too.

I'm not very persuaded to merge such thing to alsa-lib (at least not to 
alsa-lib.so file - I may accept another library in the alsa-lib package). 
My comments:

1) configuration syntax

    - I know, simple text files are fine, but there are some structured
      things - we have already configuration parsers in alsa-lib for
      structured texts which can be migrated to XML some day

2) mixing high-level and low-level things

    - the idea is to "hide" some hardware details introducing some
      abstraction, but the scenario API ended with "ctl interface" instead
      using a mixer API for apps?
    - I would like to see handling all "virtual card" stuff in the scenario
      API, so user chooses one scenario and gets mixer controls,
      preconfigured pcm devices for playback and capture, rawmidi devices,
      timer devices etc.; it means that user can divide - for example - one
      physical card to more virtual ones with a custom configuration

 						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.

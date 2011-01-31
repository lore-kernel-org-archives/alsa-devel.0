From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: UCM list/set/get
Date: Mon, 31 Jan 2011 15:07:06 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1101311454510.6272@eeebox2.perex-int.cz>
References: <AANLkTi=pwNpK-c+h_xSkiQG8V8nhLZs-9X8+DceDw0S3@mail.gmail.com>
	<20110131112257.GC11937@sirena.org.uk>
	<1296482038.3316.160.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 8493E1038D9
	for <alsa-devel@alsa-project.org>; Mon, 31 Jan 2011 15:07:07 +0100 (CET)
In-Reply-To: <1296482038.3316.160.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: pl bossart <bossart.nospam@gmail.com>, ALSA development <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Margarita Olaya <magi@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, 31 Jan 2011, Liam Girdwood wrote:

> On Mon, 2011-01-31 at 11:22 +0000, Mark Brown wrote:
>> On Fri, Jan 28, 2011 at 11:36:47AM -0600, pl bossart wrote:
>>> I've been trying to figure out what exactly needs to be filled in UCM
>>> configuration files, and so far it's been a pretty frustrating
>>> experience with alsa-utils/alsaucm :-(
>>
>> CCing in Liam - please always remember to CC maintainers.
>>
>>> The interactive mode in alsa-utils/alsaucm is broken, I fixed a couple
>>> of segfaults and bad output (patches attached), but so far the only
>>> thing I can do is list the verbs...It looks like
>>> alsa-lib/include/use-case.h and alsa-utils/alsaucm are not aligned,
>>> whenever I query with predefined identifiers alsaucm seg faults or
>>> provides an error message that doesn't help much. This happens with
>>> the latest code.
>
>>>
>>> [ume@plb alsaucm]$ ./alsaucm listcards
>>>   0: AudioPC
>>>     this is my AudioPCI card
>>>   1: SDP4430
>>>     this is my SDP4430 card
>>>   2: TestHDA
>>>     A test HDA card
>>> [ume@plb alsaucm]$ ./alsaucm -c AudioPCI list _verbs
>>>   0: HiFi
>>>     Play and record HiFi quality Music.
>>>   1: Voice
>>>     Full duplex low-power voice call
>>>
>>> So far so good. Now the fun begins
>>>
>>> [ume@plb alsaucm]$ ./alsaucm -c AudioPCI list _devices
>>> ./alsaucm: error failed to get list _devices: No such file or directory
>>> [ume@plb alsaucm]$ ./alsaucm -c AudioPCI set _verb HiFi
>>> ALSA lib main.c:1250:(set_verb_user) error: failed to initialize new
>>> use case: HiFi
>>> ./alsaucm: error failed to set _verb=HiFi: No such device
>>> [ume@plb alsaucm]$ ./alsaucm -c AudioPCI get _verb
>>> ./alsaucm: error failed to get _verb: No such file or directory
>>>
>
> It looks like we need to improve the config file error reporting here.
> Adding line numbers would be good.

It looks like a processing error rather than a parsing error.

>>> Likewise if the .conf file contains a cset in the default values, then
>>> the parser fails (I took the example from src/ucm/parser.c).
>>> Commenting out the cset is the only solution. What exactly is this
>>> index supposed to mean?
>>> SectionDefaults [
>>> cdev "hw:AudioPCI"
>>> cset "name='Master Playback Switch',index=2 1,1"
>>> ]
>
> Jaroslav is probably best placed to answer about the cset syntax.
>
> The "index" is not required :-
>
> cset "name='Master Playback Switch' 1,1"

For complete cset command look to 'amixer cset' syntax. You may get list 
of available identifiers using 'amixer controls'.

Anyway, I fixed some issues in alsaucm (interactive mode) and alsa-lib 
now.

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.

From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: ALSA UCM
Date: Fri, 12 Nov 2010 17:55:50 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1011121743180.29422@eeebox2.perex-int.cz>
References: <AANLkTimFdKg=_KDv8fbSJry6XTEsZqyQz7GhzaPxXDYP@mail.gmail.com>
	<1288865349.3277.14.camel@odin>
	<AANLkTim1Aopc2ALEXoWorPjzua0gGoSef8CpH+At4_cp@mail.gmail.com>
	<1288890598.3277.81.camel@odin>
	<alpine.LNX.2.00.1011041932410.29422@eeebox2.perex-int.cz>
	<1288896461.3277.98.camel@odin>
	<alpine.LNX.2.00.1011041949180.29422@eeebox2.perex-int.cz>
	<1288897628.3277.99.camel@odin>
	<AANLkTikn6Q+6KUpZaDGXuX=bGHrbV_9s91C6u+rS5e22@mail.gmail.com>
	<1289046396.3318.53.camel@odin>
	<AANLkTina11GuK4jqP=DtD-OEjTiRtNa_yG0QKy7XDuxs@mail.gmail.com>
	<alpine.LNX.2.00.1011101608250.29422@eeebox2.perex-int.cz>
	<1289576480.3480.101.camel@odin>
	<alpine.LNX.2.00.1011121722090.29422@eeebox2.perex-int.cz>
	<1289580140.3480.117.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 66B7E103939
	for <alsa-devel@alsa-project.org>; Fri, 12 Nov 2010 17:55:51 +0100 (CET)
In-Reply-To: <1289580140.3480.117.camel@odin>
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
Cc: alsa-devel@alsa-project.org, abraham duenas <aduejazz@gmail.com>, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Fri, 12 Nov 2010, Liam Girdwood wrote:

> On Fri, 2010-11-12 at 17:25 +0100, Jaroslav Kysela wrote:
>> On Fri, 12 Nov 2010, Liam Girdwood wrote:
>>
>>> On Wed, 2010-11-10 at 16:11 +0100, Jaroslav Kysela wrote:
>>>> On Tue, 9 Nov 2010, abraham duenas wrote:
>>>>
>>>
>>>>> I'm getting the expected error ONLY for the last element: listed in
>>>>> the EnableSequence field:
>>>>> e.g:
>>>>> ALSA lib main.c:137:(execute_sequence) cset not yet implemented:
>>>>> 'name='DL2 Media Playback Volume' 90'
>>>>> ALSA lib main.c:137:(execute_sequence) cset not yet implemented:
>>>>> 'name='MUX_UL10' 10'
>>>>>
>>>>> i'll keep on digging as time permits :)
>>>>
>>>> I fixed the sequence parser. It should work now ok. So the only missing
>>>> part is to add the 'snd_ctl_*' backend for cset commands. The parsing
>>>> functions for ctl strings are available in my ucm branch now:
>>>
>>> Is it the intention to reuse the cset functionality from amixer here ?
>>
>> Yes, basically to avoid double ASCII syntax for same thing. I expect that
>> the amixer will be recoded to use parser functions implemented in
>> alsa-lib.
>
> Ok, so with any luck this will mostly involve copy and pasting the cset
> code from amixer and alsa-lib.

It's done :-) The only missing part is the integration of this code to 
UCM. Note that my UCM implementation does not assume that only one 
soundcard can be touched, so we probably need additional command to select 
the ctl device for which will be cset commands applied. Also, Mark said 
something that your code used some transformations for controls to specify 
how the controls will be changed, but not-specified controls will be set 
from previous (probably default) state, something like this:

1) default initalization - grab actual control values from driver and
    overwrite with specified values from the configuration file (it can be
    just subset of all controls provided from the driver)
2) setting verb/mod etc.. - specify just changes for the default state

I think that we can do this with some named control sets and adding 
commands like:

create_cset (optional filter - which values should be handled or all if
 	     not specified)
handle_cset - operate with initial or current values (maybe we can have
               two commands to distincts this behaviour)
  ... all new cset commands to change the named cset ...
apply_cset - push (write) whole cset to the driver

Eventually commands like copy_cset etc. might be implemented. There are 
plenty of possibilities. My point is that the UCM behaviour should be 
specified in the configuration files without any hardcoded things.

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.

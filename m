From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH 0/3] alsa-lib: UCM - Use Case Manager
Date: Wed, 22 Sep 2010 16:06:56 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1009221544480.6226@eeebox2.perex-int.cz>
References: <alpine.LNX.2.00.1008250925540.10278@eeebox2.perex-int.cz>
	<1282728400.2991.114.camel@odin>
	<alpine.LNX.2.00.1008251128140.10278@eeebox2.perex-int.cz>
	<1282732983.2991.161.camel@odin>
	<alpine.LNX.2.00.1008251831330.10278@eeebox2.perex-int.cz>
	<1283864698.3048.26.camel@odin>
	<alpine.LNX.2.00.1009071618230.10278@eeebox2.perex-int.cz>
	<i781vn$nhb$1@dough.gmane.org>
	<AANLkTin8fTA0CoUiPzASG4kepbSyWiDf7xrX-iJB8EQA@mail.gmail.com>
	<alpine.LNX.2.00.1009211938110.6226@eeebox2.perex-int.cz>
	<20100922132052.GC32476@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 8C75A2447D
	for <alsa-devel@alsa-project.org>;
	Wed, 22 Sep 2010 16:06:56 +0200 (CEST)
In-Reply-To: <20100922132052.GC32476@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Chris Winter <elwintro@gmail.com>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 22 Sep 2010, Mark Brown wrote:

> On Tue, Sep 21, 2010 at 08:11:35PM +0200, Jaroslav Kysela wrote:
>
>> There are two things and I think that we both talking about different
>> ones.
>
>> 1) Which devices can be used simultaneously in the system
>>     (basically determining the number of handled streams).
>> 2) Physical output (or input) switching (I mean physical jacks etc.).
>
>> I don't want to add any complex manager. I just think that the UCM layer
>> should give the information to the application which PCM streams can be
>> used concurrently for a named card. Something like stream grouping.
>
> This is what the snd_use_case_*_pcm() functions are all about -
> identifying which of the many available streams should be used for a
> given output stream.  With modern mobile audio architectures the ability
> to route different kind of audio to different PCM streams is essential.

But it's not possible to guess if streams are independant from the PCM 
device name. Some hardware has restrictions or driver can offer more PCM 
devices for one hardware (for example stereo only devices and multichannel 
devices sharing same hardware portion).

> Now, it's true that it doesn't explicitly support grouping multiple PCMs
> together into a single use case which is probably a good extension to
> think about - perhaps returning arrays would cover it, though to be
> honest I'm not sure how often that'd get used (and I'd expect apps to
> fail to cope).

Maybe a simple extension to the current API might cover also this issue: 
Add a third state for devices and modifiers - "blocked". This state will 
be active when hardware has inter-device/modifier contraints or when 
another application uses hardware in the blocking way.

>> The question is how we can make much flexible the passing of these values
>> from the configuration files. I think that we may use just a direct way
>> between the "identifier" from the snd_use_case_get/set function and the
>> configuration files, having syntax something like:
>
> There's some scaling issues that need to be dealt with - for example, if
> you're asking for the controls for an EQ you likely want to be able to
> get an array back with the per-band gains and possibly trimming options
> for the bands since there's quite a bit of range in the control offered
> by EQs.  This means we will need to be able to return a variably sized
> set of controls.

Sure, but you can describe this array in a string with some delimiters.

>> SectionDevice."Headphones".0 {
>>  	...
>>  	Value."_ctl_/_pctlsw" "name='Master Playback Switch'"
>>  	...
>> }
>
> This sort of thing is quite different to what you were suggesting
> previously and much less problematic.

I just finished the implementation for all functions in my GIT tree 
(except card listing). Also, the "Value {}" section is implemented as I 
proposed - it means that users can pass any read-only values to the API 
user.

The code is not tested, I need to write a simple command line tool for 
testing the API and also move the control/mixer ID and value handling 
code from the alsa-utils/amixer utility to alsa-lib.

So, please, check the use-case.h again:

http://git.alsa-project.org/?p=alsa-lib.git;a=blob;f=include/use-case.h;h=fdbcaca04c032b22de41cce2d42ab5b84edd37f4;hb=404cd090b279b329c86514984dc74439dedf2e90

Note that this code is almost complete rewrite to use the kernel style 
lists (alsa-lib/include/list.h).

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.

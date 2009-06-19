From: Robert Schweikert <rschweikert@novell.com>
Subject: Re: LSB inclusion of ALSA
Date: Fri, 19 Jun 2009 07:39:32 -0400
Message-ID: <4A3B78F4.7000407@novell.com>
References: <4A3296D0.4080701@novell.com> <4A378931.8010102@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from victor.provo.novell.com (victor.provo.novell.com
	[137.65.250.26]) by alsa0.perex.cz (Postfix) with ESMTP id D5985244ED
	for <alsa-devel@alsa-project.org>;
	Fri, 19 Jun 2009 13:39:49 +0200 (CEST)
In-Reply-To: <4A378931.8010102@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



Clemens Ladisch wrote:
> Robert Schweikert wrote:
>   
>> Currently ALSA is a trial use module for LSB
>> (http://www.linuxfoundation.org/collaborate/workgroups/lsb) 4.0 and it
>> is the intention to make ALSA mandatory with the LSB 4.1 release
>> targeted for Q1 2010. One of the requirements of a mandatory module is
>> the existence of a test suite for the module that covers a good chunk of
>> the interfaces provided by the LSB spec. An initial exploratory look at
>> the existing test cases showed that tests appear to be tied to hardware
>> drivers and are interactive.
>>
>> Is this initial impression correct?
>>     
>
> Yes.
>
>   
>> From an LSB testing perspective, interface testing is  very important;
>> i.e. I call the interface with the arguments required and I get the
>> expected result back.
>>     
>
> In the case of a hardware interface library like libasound, there is not
> always a result that comes back where it could by easily tested.
>
> While many parts of the library can be tested without special hardware
> (config, sequencer+MIDI, timers), the parts that are most likely to be
> used (PCM, mixer) require at least some kernel driver and contain many
> functions that are used to handle hardware differences.
>   
Understood, but this is functional testing (current tests seem to cover
this) and would required the appropriate hardware (a gazilion sound
cards). LSB makes no guarantees that the drivers exist and have no bugs.
LSB does strive to guarantee that a particular interface exists and
behaves as specified.

So for interfaces that require a driver one could test that an
appropriate error condition is returned if no driver exists, and we
could test that no error condition is triggered when a dummy driver is
connected. Correct?
>   
>> 1.) Is there interest from the community side to participate in this
>> effort and accept patches?
>>     
>
> I'm just an individual and cannot speak for "the community", whatever
> that is, but there is certainly interest to accept patches.
>
>   
>> 2.) Is it reasonable to expect that the existing tests can be used in
>> some way by using a dummy sound device or a sound loop device to verify
>> output?
>>     
>
> There is a loopback driver, but it is not part of the LSB specification.
> This means that a test using this driver would not work with any
> alternate ALSA implementation.
>
> I can easily imagine LSB-compliant computers that do not have any sound
> card (e.g., most servers).  Even if the ALSA interface (i.e., libasound)
> is installed, some parts cannot be used in any meaningful way.  What is
> a test supposed to do in this case?  It could just exit with "pass",
> but this wouldn't actually _test_ much.
>
> (Hmmm, a dummy ALSA implementation that just returns -ENODEV when the
> application tries to open a device would be compliant, because it cannot
> be distinguished from the 'real' ALSA with no installed sound card.  :-)
>   
Sorry, didn't quite get this, why a dummy ALSA implementation. Shouldn't
the ALSA interfaces that depend on a driver already return -ENODEV today?

But you raise a good point w.r.t. hardware tie in. Within the LSB work
group we are working on a concept to allow an application to test for
module/component/subcomponent (name not yet decided) presence. For
example a distribution can be LSB certified, but on a server install
libasound may not be present. An LSB certified application at install
time can query whether the LSB module/component/subcomponent that
contains libasound is installed on the system and then take appropriate
action. This would solve the problem you point out.
>   
>> 3.) Would the community be more comfortable if this is an effort that
>> creates new tests separate from the existing HW focused tests?
>>     
>
> The current interactive tests are mostly intended to test drivers, not
> the interface.  I don't think it would be desirable or even possible to
> integrate them into a test suite with strict pass/fail requirements.
>   
Good to know, sounds like we are better of starting from scratch.
>   
>> 4.) Is anyone interested in helping with this effort, writing tests,
>> answering questions about ALSA for those not familiar with the interface
>> and or sound in general?
>>     
>
> Yes.
>
> Since most of libasound is somewhat undocumented (the doxygen reference
> is just a skeleton), I'm wondering who is going to write the tests ...
>   
I have some time to work on this, but not having much of a clue how
sound works, and maybe that is not needed, I will need some amount of
hand holding.

Robert
>
> Best regards,
> Clemens
>   

-- 
Robert Schweikert                           MAY THE SOURCE BE WITH YOU
Software Engineer Consultant                          LINUX
rschweikert@novell.com 
781-464-8147

Novell
Making IT Work As One

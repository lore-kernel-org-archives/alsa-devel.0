From: Robert Schweikert <rschweikert@novell.com>
Subject: Re: LSB inclusion of ALSA
Date: Fri, 19 Jun 2009 08:07:10 -0400
Message-ID: <4A3B7F6E.6070604@novell.com>
References: <4A3296D0.4080701@novell.com>	<4A378931.8010102@ladisch.de>
	<s5h3a9z46ne.wl%tiwai@suse.de> <4A38AED6.4060009@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from victor.provo.novell.com (victor.provo.novell.com
	[137.65.250.26])
	by alsa0.perex.cz (Postfix) with ESMTP id 98A7410381B
	for <alsa-devel@alsa-project.org>;
	Fri, 19 Jun 2009 14:07:24 +0200 (CEST)
In-Reply-To: <4A38AED6.4060009@ladisch.de>
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



Clemens Ladisch wrote:
> Takashi Iwai wrote:
>   
>> Clemens Ladisch wrote:
>>     
>>> There is a loopback driver, but it is not part of the LSB specification.
>>> This means that a test using this driver would not work with any
>>> alternate ALSA implementation.
>>>       
>> Yes, I mentioned about this in the last conf call with LSB guys.
>>
>> Another candidate is alsa-lib file plugin (and null plugin).  They can
>> be used to simulate in a certain level of I/O.
>>     
>
> I don't think that LSB guarantees the availability of these plugins
> either.  (And they don't get the timing correct, but maybe we don't care
> about that.)
>   
If we need special libraries for testing that's fine. These do not have
to be part of the LSB.
>   
>>> I can easily imagine LSB-compliant computers that do not have any sound
>>> card (e.g., most servers).  Even if the ALSA interface (i.e., libasound)
>>> is installed, some parts cannot be used in any meaningful way.  What is
>>> a test supposed to do in this case?  It could just exit with "pass",
>>> but this wouldn't actually _test_ much.
>>>       
>> The test can never cover 100% all real cases.
>> So, the primary question is: what kind of test do we need.
>>
>> From the LSB perspective, I suppose, the API compatibility is the
>> biggest issue.  The functionality, either working or not on the real
>> hardware, is a subsystem bug.  And, the subtle tests would be likely
>> needed done manually with the real hardware.
>>     
>
> So ALSA's LSB tests would be like the Qt4 tests, whose description is:
> | check run-time presence of interfaces and absence of critical errors
> | in simple use cases
>   
Well, hopefully not quite that rudimentary but definitely in line with
this train of thought. Just like the ALSA project cannot test all
possible configurations, neither can the LSB. From a driver - hardware
perspective the LSB probably can test less than those more deeply
involved in the project.

One of the key parts of any effort is that the tests are accepted by the
project and maintained in some way. If we just create LSB tests that are
separate from the project things will diverge and become stale.
>   
>>> (Hmmm, a dummy ALSA implementation that just returns -ENODEV when the
>>> application tries to open a device would be compliant, because it cannot
>>> be distinguished from the 'real' ALSA with no installed sound card.  :-)
>>>       
>> You mean the dummy sound driver?
>>     
>
> No.  I meant that the ALSA interfaces, in case they are only required
> for strict LSB compliance but not for actual sound output, could be
> implemented like this to save memory:
>
> 	int snd_pcm_open(...)
> 	{
> 		return -ENODEV;
> 	}
>
> This is purely theoretical, but my point is that this would be a
> conforming implementation of the ALSA interface.
>   
But this would fail the test where we load the dummy driver and test
another return value (see previous post for more details).
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

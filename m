From: Pavel Hofman <pavel.hofman@insite.cz>
Subject: Re: PATCH - ESI Juli driver
Date: Mon, 17 Mar 2008 09:57:49 +0100
Message-ID: <47DE328D.1080009@insite.cz>
References: <47DD1934.3000003@insite.cz> <s5hod9du6gb.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server.insite.cz
	(171-43-207-85.zapcechy.adsl-llu.static.bluetone.cz [85.207.43.171])
	by alsa0.perex.cz (Postfix) with ESMTP id B594E2441D
	for <alsa-devel@alsa-project.org>; Mon, 17 Mar 2008 09:57:57 +0100 (CET)
In-Reply-To: <s5hod9du6gb.wl%tiwai@suse.de>
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
Cc: ALSA development <alsa-devel@alsa-project.org>, Rainer Zimmermann <mail@lightshed.de>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Sun, 16 Mar 2008 13:57:24 +0100,
> Pavel Hofman wrote:
>> Hi Takashi,
> 
> I feel there are too many additional callbacks in your patch.
> Since we don't need too subtle tuning, can we simplify this?

There are only two callbacks which Juli does not redefine. These could 
be removed. Though I felt it was cleaner to have all the clock-specific 
stuff potentially redefinable for other cards.

I did not want to copy/paste any algorithmical code from ice1724.c to 
juli.c as it complicates future maintenance. Now, the vt1724 code in 
ice1724.c is pretty much about general algorhitms, specific routines are 
in stdclock_... I tested the original clock with Prodigy192 which 
provided testing analog/SPDIF signals. There are no functional changes.


> 
> Regarding the separate rate setting for each stream, we should
> consider about Maya44 support, too.

I have been following the discussion. Unfortunately, I did not get to 
see any patch of ice1724.c, iirc the last patch included the whole 
modified ice1724.c copied to alsa-driver.

Rainer, what are the changes?

Now each card can specify its own stream parameters. E.g. Juli has a 
modified list of available frequencies for analog streams.


> 
>> The driver is tested, only analog-in and digital-in monitors are not 
>> working. I have coded according to manufacturer's documentation, the 
>> same procedure is in OSS Juli driver. I described the issue in detail in 
>> the code, perhaps someone will do more research.
>>
>> The card itself has no HW master volume control. It would have to be 
>> implemented as a virtual control manipulating internal values of PCM and 
>> monitor volume controls. I will take a look at it later. For now, 
>> perhaps we could rename the PCM Volume to Master Volume, as most people 
>> will not need the monitoring anyway. I will leave it to your decision.
>>
>> Signed-off-by: Pavel Hofman <dustin@seznam.cz>
>>
>> * moving all clock-specific code to card-specific routines
>> * support for ESI Juli
>> * to-be-researched - monitoring of analog/digital inputs
>> * missing - master volume control, will have to be implemented as 
>> virtual, no HW support.
> 
> vmaster can be used for this now.  It was moved to core directory
> after 1.0.16 release.

Thanks, I did not know about vmaster. I will try to implement it tonight.

The Juli support is one of the very called-for features, I guess it 
would be a pitty to keep a functional patch out of repository.

Thanks,

Pavel.

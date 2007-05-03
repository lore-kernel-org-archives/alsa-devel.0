From: Pieter Palmers <pieterp@joow.be>
Subject: Re: Support for SAM9407?
Date: Thu, 03 May 2007 08:26:04 +0200
Message-ID: <4639807C.4030901@joow.be>
References: <20070502214719.0616916427C@ws1-4.us4.outblaze.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from weequay.is.scarlet.be (weequay.is.scarlet.be [193.74.71.24])
	by alsa0.perex.cz (Postfix) with ESMTP id F40A0243E6
	for <alsa-devel@alsa-project.org>;
	Thu,  3 May 2007 08:26:43 +0200 (CEST)
In-Reply-To: <20070502214719.0616916427C@ws1-4.us4.outblaze.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ash Willis <ashwillis@programmer.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Ash Willis wrote:
> Hi Pieter,
> 
>> Are you interested in joining the FFADO project? (short into: FFADO =
>> new FreeBoB = drivers for FireWire Audio Interfaces / www.ffado.org).
>>
> 
> I have absolutely zero experience in firewire audio and firewire in
> general to be honest, but the project does sound interesting.
>
You don't need any FireWire experience, because libffado abstracts 
everything FireWire from the user (in this case user = ALSA plugin).

>> To be frank/direct here, I think that ALSA is better 'completed' with
>> FFADO support than with driver support for obsolete cards. But of course
>> I'm a little biased here :).
> 
> Be as Frank as you want, I totally agree with you :) The thing is, I have
> limited time and experience (I have written one ALSA driver). Although
> supporting older hardware doesn't bring a whole lot to the project, it
> does provide me with a training ground so I can be of greater use in the
> future. I can work at my own pace on an area that nobody else will be
> working on. I can improve my skills without stepping on other people's
> toes.
ALSA support for FFADO is not being done by anyone currenlty, so no toes 
to step on there.

If you already have written one ALSA driver, you already have the 
experience required I guess. The ALSA support take the form of an ALSA 
plugin, which should be easier to write than a driver. In any case it is 
userspace, so no kernel oops'es.

> 
> Your project sounds interesting but I don't feel I have the knowledge to
> keep up on a project like this. This is why I'm messing around with this
> stuff, so that I can do some 'real work' some day soon ;)

I think you do... I think I was at about the same level as you are now 
when Daniel and I started FreeBoB. We do this to learn, and as long as 
nobody else steps up, nobody has the right to criticize you. And over 
the 3 year's we're already working on this, there hasn't been anyone 
stepping up for the ALSA support. So I guess you're clear :).

Again, it would be very nice if you could join us. You would make a 
difference for a lot of people.

Greets,

Pieter

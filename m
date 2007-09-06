From: Rene Herman <rene.herman@gmail.com>
Subject: Re: [PATCH] Gallant SC-6000 driver (4th version)
Date: Thu, 06 Sep 2007 23:16:39 +0200
Message-ID: <46E06E37.4090304@gmail.com>
References: <46dfa2e7d6be4@wp.pl>	<46DFD29A.6020601@gmail.com>
	<20070906231206.2ba8f939.krzysztof.h1@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.groni1.gr.home.nl (smtpq1.groni1.gr.home.nl
	[213.51.130.200])
	by alsa0.perex.cz (Postfix) with ESMTP id 4FD86103829
	for <alsa-devel@alsa-project.org>;
	Thu,  6 Sep 2007 23:23:13 +0200 (CEST)
In-Reply-To: <20070906231206.2ba8f939.krzysztof.h1@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Krzysztof Helt <krzysztof.h1@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 09/06/2007 11:12 PM, Krzysztof Helt wrote:

> On Thu, 06 Sep 2007 12:12:42 +0200
> Rene Herman <rene.herman@gmail.com> wrote:
> 
>> On 09/06/2007 08:49 AM, Krzysztof Helt wrote:
>>
>>> Actually, the parport_pc driver is loaded by the udev by default, so the
>>> IRQ7 cannot be requested (I tested - IRQ7 request failed even if I had 
>>> not used the printer).
>> Not everybody uses udev. But more importantly, only if the hardware in 
>> question is discoverable. [...]
>>
>> And _then_ there's the bit about the ISA probing being a huge gaping race by 
>> design. There's really no defending that massive junk. All ISA autoprobing 
>> is bad engineering and should be ripped out and shot, period. It's broken 
>> both by design and implementation. The solution to making things nicer is 
>> not autoprobing but not using legacy ISA -- and basically noone is other 
>> than for entertainment purposes.
>>
> 
> I am quite sure we won't agree on this one. My reason (to keep autodection)
> is sheer laziness of giving two numbers. Even giving them does not make
> user free of problems how to avoid irqs and dmas with installed devices 
> but not visible in the /proc/interrupts file).

No, but then at least you aren't hiding the problem by promising the user to 
figure it all out automatically. And as said, /etc/modprobe.conf works...

> I would like to ask Takashi to decide on this issue. I will done as he says.

Oh, I've not much doubt he'll not mind it terribly. Still many drivers in 
sound/isa that do probing. Doesn't change that it's all counter-productive, 
broken junk though!

> Will this driver be included? I found a bug in probing - if something is wrong
> after the SB region is requested it won't be released. So the next version is
> needed to be done anyway (or a small patch later).

Still testing with snd-galaxy here and haven't really looked at integrating 
them yet. Will do, but I believe I saw some differences stand out already.

Rene.

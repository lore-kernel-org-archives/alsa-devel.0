From: Rene Herman <rene.herman@gmail.com>
Subject: Re: [PATCH] remove email addresses from MODULE_AUTHOR
 tag
Date: Fri, 11 May 2007 23:12:58 +0200
Message-ID: <4644DC5A.7060905@gmail.com>
References: <4643C20C.8050105@gmail.com> <s5hd517ich2.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.175])
	by alsa0.perex.cz (Postfix) with ESMTP id A0A51244D5
	for <alsa-devel@alsa-project.org>;
	Fri, 11 May 2007 23:15:30 +0200 (CEST)
Received: by ug-out-1314.google.com with SMTP id j3so664066ugf
	for <alsa-devel@alsa-project.org>; Fri, 11 May 2007 14:15:30 -0700 (PDT)
In-Reply-To: <s5hd517ich2.wl%tiwai@suse.de>
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
Cc: ALSA devel <alsa-devel@alsa-project.org>, Jaroslav Kysela <perex@suse.cz>
List-Id: alsa-devel@alsa-project.org

On 05/11/2007 05:52 PM, Takashi Iwai wrote:

>> Following up the recent MODULE_MAINTAINER discussion on LKML:
>>
>> http://lkml.org/lkml/2007/4/4/170
>>
>> that concluded with MODULE_MAINTAINER not being a good idea, here's a patch 
>> that just deletes the email addresses from the MODULE_AUTHOR tags for ALSA.
>>
>> The email address is the problem I was trying to fix; with multiple current 
>> and non-current authors and maintainers who might not even be authors the 
>> address(es) available from the tag confuse the issue of whom to contact. 
>> It's moreover also information that easily outdated.
>>
>> A bit more than half of the tags in the kernel don't include an email 
>> address already (the core contributors typically don't include any) and I'll 
>> submit patches removing more.
> 
> Did we get consensus about this removal action?
> I've seen only one follow up by Krzysztof.
> (I personlly don't mind to remove mail addresses, though.)

Yep, Krysztof was the only one to specifically ACK but seeing as how I asked 
for objections:

http://lkml.org/lkml/2007/4/27/488

I took not seeing any as more ACKs. Alan Cox is objecting a bit again though 
preferring the originally proposed MODULE_MAINTAINER:

http://lkml.org/lkml/2007/5/10/628

I seem unlikely to convince him but I believe it's upto specific subsystems 
whether or not they'll take patches removing the email adresses from the 
tag, ie, in the case of ALSA upto you and Jaroslav.

I do believe it actually solves a problem. In the end, all that I really 
care about are the ones that I specifically want to take on (which in the 
case of ALSA is eventually most or all of isa/, but I'm not sufficiently 
upto speed yet, and certainly not on the _real_ driver code as opposed to 
the bus glue) but in a global sense, I'd like to just see them all go.

Rene.

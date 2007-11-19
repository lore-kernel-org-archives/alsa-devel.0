From: Dominique Larchey-Wendling <Dominique.Larchey-Wendling@loria.fr>
Subject: Re: Strange bug in .asoundrc ??
Date: Mon, 19 Nov 2007 16:06:13 +0100
Message-ID: <4741A665.1030600@loria.fr>
References: <47416E4D.3050207@loria.fr>
	<1195482005.19167.1222125449@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail4-relais-sop.national.inria.fr
	(mail4-relais-sop.national.inria.fr [192.134.164.105])
	by alsa0.perex.cz (Postfix) with ESMTP id 3F305248B5
	for <Alsa-devel@alsa-project.org>; Mon, 19 Nov 2007 16:06:14 +0100 (CET)
In-Reply-To: <1195482005.19167.1222125449@webmail.messagingengine.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <cladisch@fastmail.net>
Cc: Alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

 > It appears this behaviour is by design.

Ok so this is not a bug but a feature ;-)
However, it is not specified in the doc that alsa-lib makes a semantic 
distinction between the types of objects in the alisp language.

What is strange is that the same function is called in alsa-lib to
expand hw:0 whether it is prefixed with "ctl" or "pcm" :

snd_config_search_definition(root, "ctl", name, &ctl_conf);

and

snd_config_search_definition(root, "pcm", name, &pcm_conf);

----------

Of course there is the workaround

ctl.tata { type hw card 0 }

but my question was more why is it designed this way ? Perhaps I do not
see some tricky problem but it should not be difficult to modify 
alsa-lib so that the behavior is coherent between the "ctl" and "pcm" 
contexts ?

Regards,

Dominique

> Dominique Larchey-Wendling wrote:
>> It seems that neither the current ctl.hw function nor the following
>> simplified function ctl.!hw work correctly when the argument CARD is
>> given to the function. It works however when no argument is given as the
>> following test examples show it.
>>
>> Is this a know bug of alsa-lib ? It is strange because this bug does not
>>    show up with pcm.hw for example.
>>
>> ctl.rha  "hw"
>> ctl.tata "hw:0"
>>
>> rha % amixer -D rha info
>> Card rha 'Intel'/'HDA Intel at 0xfebfc000 irq 16'
>> ...
>> rha % amixer -D tata info
>> ALSA lib control.c:781:(snd_ctl_open_conf) Invalid type for CTL tata definition
> 
> Using a string with parameters works only with PCM devices; the code in
> alsa-lib that handles other device types doesn't bother to try to look
> the string up.
> 
> It appears this behaviour is by design.
> 
> To get your own definition, write something like this:
>   ctl.tata { type hw card 0 }
> 
> 
> Regards,
> Clemens

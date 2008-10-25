From: Jelle de Jong <jelledejong@powercraft.nl>
Subject: Re: volume scaling of usb audio class headset
Date: Sat, 25 Oct 2008 17:47:44 +0200
Message-ID: <49033FA0.705@powercraft.nl>
References: <49020760.9080900@powercraft.nl>	
	<74eb1fe20810241113q7ee8aa9ah63cf5346c6b940c1@mail.gmail.com>	
	<4902E3DD.3020304@powercraft.nl>
	<74eb1fe20810250800h5b9fece0m4d6f4acefe542603@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from node03.cambriumhosting.nl (node03.cambriumhosting.nl
	[217.19.16.164]) by alsa0.perex.cz (Postfix) with ESMTP id 8ABAA2444C
	for <alsa-devel@alsa-project.org>;
	Sat, 25 Oct 2008 17:48:13 +0200 (CEST)
In-Reply-To: <74eb1fe20810250800h5b9fece0m4d6f4acefe542603@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sean McNamara <smcnam@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Sean McNamara wrote:
> I've had success with Plantronics headsets. In particular, the
> Plantronics DSP-500 works well. I've tested it with numerous ALSA
> releases, from 1.0.14 - 1.0.17 and some post-1.0.17 GIT builds. I've
> never had a mixer problem with it.
> 
> This is just *me* speaking, of course, not alsa-project... any implied
> endorsement is my personal one alone ;-)
> 
> Sean
> 

Thank you for you comments, anybody else got experiences with other usb
headsets?

Hmmm, I got some Plantronics USB .Audio 510 Headsets and they are kind
of bad. They have wrong dB initialization, incorrect bandwidth
allocation when connected to usb hubs but this can also be an kernel
usb-audio and/or usbcore bug. And are build out of 3 usb interfaces, 2x
usb audio and one hid device (speakers, mic, and not functional uinput
keypad)

I think I will see if I can get my hands on some Plantronics or Logitech
usb headset.

Kind regards,

Jelle

> 
> 
> On Sat, Oct 25, 2008 at 5:16 AM, Jelle de Jong
> <jelledejong@powercraft.nl> wrote:
>> Sean McNamara wrote:
>>> There is a *huge* (83 replies) thread in the alsa-devel ML archives
>>> about this problem. Lennart Poettering raised the issue regarding his
>>> Logitech external USB speakers.
>>>
>>> http://article.gmane.org/gmane.linux.alsa.devel/52524
>>>
>>> Sort through the replies to see if you can make any sense out of the
>>> workarounds, patches, and so on that resulted from this discussion. If
>>> possible, try the latest GIT alsa-driver and alsa-lib.
>>>
>>> Sean
>>>
>>> On Fri, Oct 24, 2008 at 1:35 PM, Jelle de Jong
>>> <jelledejong@powercraft.nl> wrote:
>>>> Hello everybody,
>>>>
>>>> I got a question, I got a few usb headsets that seem to apply to the usb
>>>> audio class and the volume scale is way to big with alsa. with the
>>>> control on 10 of the 100 you are almost getting deaf. So my question is
>>>> how does alsa make an scaling for such devices and how to fix it so that
>>>> the full range can be used in a normal volume spectrum.
>>>>
>>>> Thank in advance,
>>>>
>>>> Jelle
>> Thank you Sean for responding to the question, it seems I was not the
>> only one with this issue. I got one more following question, which usb
>> headset and usb audio adapters can I buy right now that are not effected
>> by this issue? Or should I just wait until the upcoming releases that
>> will hopefully fix the problem for all usb audio devices, or is this
>> false hope?
>>
>> Best regards,
>>
>> Jelle
>>

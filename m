From: Clemens Ladisch <clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>
Subject: Re: [alsa-devel] [RFC] MIDI over Bluetooth Low Energy
Date: Thu, 1 Oct 2015 13:53:38 +0200
Message-ID: <560D1EC2.8010603@ladisch.de>
References: <CAGrhNMyY7rJVZ35p5P5FnGvJPYZuKndau1vNY5k+GCHHYzZtzQ@mail.gmail.com>
	<560D1893.6040509@ladisch.de>
	<CAGrhNMxmtt-5kZO-6me2sPQYeQ5wcpvonKqzbx7CEB5=RJ724Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAGrhNMxmtt-5kZO-6me2sPQYeQ5wcpvonKqzbx7CEB5=RJ724Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Tonello <eu-NLnRV5p3vwDxYxTyqlRmvgC/G2K4zDHf@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Felipe Tonello wrote:
> On Thu, Oct 1, 2015 at 12:27 PM, Clemens Ladisch <clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org> wrote:
>> Felipe Tonello wrote:
>>> I am planning to start the support of MIDI BLE profile[1].
>>>
>>> I suggest two main goals:
>>>  * To be transparent to applications, i.e., use rawmidi and sequencer
>>> ALSA interfaces to interact.
>>>  * To support peripheral and central BLE roles.
>>>
>>> My question is: what is the best way possible of doing it?
>>
>> Just write a (user-space) sequencer client.
>
> But this will limit to seq interface only. It will not be available
> via rawmidi interface, right?

Yes.  And why would this be a problem?

>>> They all have the problem of context switching between bluez plugin
>>> and alsa midi driver.
>>
>> Why would context switches be a problem?
>
> It is just too much travelling around.

It hasn't been a problem with any other MIDI application.


Regards,
Clemens

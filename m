From: Felipe Tonello <eu-NLnRV5p3vwDxYxTyqlRmvgC/G2K4zDHf@public.gmane.org>
Subject: Re: [alsa-devel] [RFC] MIDI over Bluetooth Low Energy
Date: Thu, 1 Oct 2015 12:35:48 +0100
Message-ID: <CAGrhNMxmtt-5kZO-6me2sPQYeQ5wcpvonKqzbx7CEB5=RJ724Q@mail.gmail.com>
References: <CAGrhNMyY7rJVZ35p5P5FnGvJPYZuKndau1vNY5k+GCHHYzZtzQ@mail.gmail.com>
	<560D1893.6040509@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <560D1893.6040509-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Clemens Ladisch <clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Hi Clemens,

On Thu, Oct 1, 2015 at 12:27 PM, Clemens Ladisch <clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org> wrote:
> Felipe Tonello wrote:
>> I am planning to start the support of MIDI BLE profile[1].
>>
>> I suggest two main goals:
>>  * To be transparent to applications, i.e., use rawmidi and sequencer
>> ALSA interfaces to interact.
>>  * To support peripheral and central BLE roles.
>>
>> My question is: what is the best way possible of doing it?
>
> Just write a (user-space) sequencer client.

But this will limit to seq interface only. It will not be available
via rawmidi interface, right? Unless I load snd-virtmidi, correct?
That was what I was suggesting at first, but I don't really like the
idea of loading snd-virtmidi for that.

>
>> [...]
>> They all have the problem of context switching between bluez plugin
>> and alsa midi driver.
>
> Why would context switches be a problem?

It is just too much travelling around. GATT messages are parsed in
userspace by BlueZ, so it sounds unnecessary to copy buffers to the
kernel and copy back to user space to the application (ALSA).

Felipe

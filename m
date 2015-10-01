From: Luiz Augusto von Dentz <luiz.dentz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC] MIDI over Bluetooth Low Energy
Date: Thu, 1 Oct 2015 12:34:10 +0300
Message-ID: <CABBYNZ+iR-LXvMDkGiOkh8+X_=PWjrbGs3kveYFMo1UdhHVaNA@mail.gmail.com>
References: <CAGrhNMyY7rJVZ35p5P5FnGvJPYZuKndau1vNY5k+GCHHYzZtzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAGrhNMyY7rJVZ35p5P5FnGvJPYZuKndau1vNY5k+GCHHYzZtzQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Tonello <eu-NLnRV5p3vwDxYxTyqlRmvgC/G2K4zDHf@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, "linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Hi Felipe,

On Thu, Oct 1, 2015 at 11:41 AM, Felipe Tonello <eu-NLnRV5p3vwDxYxTyqlRmvgC/G2K4zDHf@public.gmane.org> wrote:
> Hi guys,
>
> I am planning to start the support of MIDI BLE profile[1]. This
> profile is not officially supported yet, but it will most likely be
> very similar, so development efforts are still valid.
>
> I suggest two main goals:
>  * To be transparent to applications, i.e., use rawmidi and sequencer
> ALSA interfaces to interact.
>  * To support peripheral and central BLE roles.
>
> My question is: what is the best way possible of doing it?
>
> My initial though is to write a GATT BlueZ profile plugin that will
> load snd-virtmidi module with id and midi_devs parameters, then read
> and write seq events from/to it. I am not sure if this is really
> possible.

If that doesn't involve creating new threads that would be the
direction I would suggest.

> Another way of implementing is as a rawmidi and a seq plugin using the
> BlueZ GATT D-Bus interface. IMO this is not ideal because it requires
> a lot more work (rawmidi and seq plugins, maybe even a library to
> avoid code duplication) and has an overhead of using dbus.

D-Bus is not meant for data, in fact GATT is not meant for byte stream
either since the channel is shared with all other profiles it can
cause delay.

> It is also possible to write a kernel module to handle ALSA
> card/device setup and reads and writes from the bluez plugin (perhaps
> this simplifies things because it has less dependencies).

Well if it uses the profile uses ATT/GATT then this is not possible
since that is implemented in userspace, I guess creating virtual cards
would be better (we do that for HoG using uhid), but I guess that is
not currently possible otherwise we would have done that for A2DP/HFP
already.

> They all have the problem of context switching between bluez plugin
> and alsa midi driver. I would prefer to use a shared ring buffer
> between ALSA e BlueZ.

You can use anything you want but don't expose bluetoothd to attacks,
so probably no shmem, actually if your concern is latency then as I
said you shouldn't be using ATT/GATT, instead L2CAP CoC should be used
but I don't think Apple has implemented it yet.

> Any ideas and comments?
>
> [1] https://developer.apple.com/bluetooth/Apple-Bluetooth-Low-Energy-MIDI-Specification.pdf

It seems the specs is pretty old, from 2012, that probably explain why
L2CAP CoC was not used.

> PS: I am at #bluez and #alsa as ftonello.
>
> Felipe Tonello
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz

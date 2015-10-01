From: Felipe Tonello <eu-NLnRV5p3vwDxYxTyqlRmvgC/G2K4zDHf@public.gmane.org>
Subject: [RFC] MIDI over Bluetooth Low Energy
Date: Thu, 1 Oct 2015 09:41:46 +0100
Message-ID: <CAGrhNMyY7rJVZ35p5P5FnGvJPYZuKndau1vNY5k+GCHHYzZtzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Hi guys,

I am planning to start the support of MIDI BLE profile[1]. This
profile is not officially supported yet, but it will most likely be
very similar, so development efforts are still valid.

I suggest two main goals:
 * To be transparent to applications, i.e., use rawmidi and sequencer
ALSA interfaces to interact.
 * To support peripheral and central BLE roles.

My question is: what is the best way possible of doing it?

My initial though is to write a GATT BlueZ profile plugin that will
load snd-virtmidi module with id and midi_devs parameters, then read
and write seq events from/to it. I am not sure if this is really
possible.

Another way of implementing is as a rawmidi and a seq plugin using the
BlueZ GATT D-Bus interface. IMO this is not ideal because it requires
a lot more work (rawmidi and seq plugins, maybe even a library to
avoid code duplication) and has an overhead of using dbus.

It is also possible to write a kernel module to handle ALSA
card/device setup and reads and writes from the bluez plugin (perhaps
this simplifies things because it has less dependencies).

They all have the problem of context switching between bluez plugin
and alsa midi driver. I would prefer to use a shared ring buffer
between ALSA e BlueZ.

Any ideas and comments?

[1] https://developer.apple.com/bluetooth/Apple-Bluetooth-Low-Energy-MIDI-Specification.pdf

PS: I am at #bluez and #alsa as ftonello.

Felipe Tonello

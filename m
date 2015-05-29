From: Adam Goode <agoode@google.com>
Subject: Reflections on implementing Web MIDI on top of ALSA seq
Date: Fri, 29 May 2015 17:56:20 -0400
Message-ID: <CAOf41Nk_xFEPn+42R8mMyaUi0Senwk3FA1gScOtL4-hd-j1=bg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vn0-f54.google.com (mail-vn0-f54.google.com
 [209.85.216.54])
 by alsa0.perex.cz (Postfix) with ESMTP id AC991266969
 for <alsa-devel@alsa-project.org>; Fri, 29 May 2015 23:56:41 +0200 (CEST)
Received: by vnbg190 with SMTP id g190so9929708vnb.3
 for <alsa-devel@alsa-project.org>; Fri, 29 May 2015 14:56:40 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

Chrome 43 is now in beta, with Web MIDI support.
(http://blog.chromium.org/2015/04/chrome-43-beta-web-midi-and-upgrading.html)

The Linux (and Chrome OS) version of Chrome uses ALSA seq to implement
Web MIDI. I wanted to reflect a bit on some of the issues I discovered
while implementing this new API on top of seq.

This is a little bit long, so the tl;dr is:
* ALSA seq worked pretty well for implementing Web MIDI, but I need a
way to get the card number for a given client, before my assumptions
about the kernel break.



Here is a quick overview of Web MIDI (http://www.w3.org/TR/webmidi/):
 - provides hotplug events for port connect/disconnect
 - incoming events are timestamped
 - outgoing events can be timestamped for future delivery by the system
 - timestamps are high precision, and use a monotonic clock
 - the port abstraction contains "name", "manufacturer", and "version" fields
 - open ports auto-reconnect if the port disappears and reappears, for
both send and receive
 - input and output ports are distinct: there are no duplex ports
 - uses MIDI bytestreams (not an event structure), but requires full
MIDI messages to be sent

The initial prototype of Chrome's Web MIDI support was built on top of
rawmidi. I rewrote it to use seq instead (to get multiple client and
user client access).

Here are my observations:
 - Getting the "manufacturer" is very hard from seq. I needed to join
against udev data, which relies on the current implementation of ALSA
in the kernel. These udev attributes are also used to match for
transparent reconnect.
 - I could not use the kernel seq timestamp, either for send or
receive, since I could not get it to just use a CLOCK_MONOTONIC
offset. Instead, timestamping is done in userspace.
 - Hotplug was tricky, since I needed to listen to both seq events and
udev events. I would prefer just to use udev, since I have to anyway.

I definitely want to fix the kernel so that I can stop relying on a
few implementation details. Here are the current assumptions I am
making:
 - Card based clients start at 16. (I need to know which clients
actually have cards)
 - Clients are in the same order as cards.
 - There is a 1:1 correspondence between clients and OPL3+rawmidi devices.

One way to fix these assumptions would be to fully expose all seq
events through sysfs. Right now, there is a seq device in sysfs but it
has no information.

Here are some ways that the kernel might be extended to simplify the
code and/or fix bad assumptions:
 1. Expose all seq clients+ports as kobjects, with a symlink to the
card if it's a hardware device
 2. Expose all subscriptions through sysfs
 3. Add a simplified timestamp mechanism that just uses a configurable
system clock, with at least CLOCK_MONOTONIC available (something like
what sound/core/timer.c does with tread?)

The first change would allow me to eliminate all the hardcoded
assumptions about which cards correspond to which clients. I believe
it would also allow me to drive the hotplug logic directly from udev,
instead of both udev and seq.
The second change is not strictly necessary, but would remove more
need to react to seq events for some uses.
The third change would allow me to use the kernel timestamp reliably,
since right now I timestamp events with CLOCK_MONOTONIC in userspace.


If I had to start today and create a new MIDI kernel interface for
ALSA, it would look like this: not-quite-raw-midi:
 - hotplug events completely driven by sysfs
 - ability to interoperate with existing seq clients (for kernel and
user clients)
 - non-exclusive access
 - reads and writes use a simple structured format, with timestamp and
a midi message as bytes
 - no or minimal alsa-lib needed
 - one device file per port (no subdevices)
 - some mechanism for creating userspace clients, preferably with some
number of key-value attributes (so I can report "manufacturer" and
other things if the user client sets it)


Thanks for reading these reflections. Comments are welcome.


Adam

From: mailing-list-recipient@silverblade.co.uk
Subject: Ideas - Support for multiple MIDI devices on a single
	interface
Date: Fri, 2 Jun 2006 19:18:08 -0700 (PDT)
Message-ID: <1633.212.69.53.77.1149301088.squirrel@webmail.silverblade.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi guys, I'm new to this list so be gentle :)

I've got a pretty in-depth knowledge of the MIDI standard/protocol, and
have been working with it for a few years (both as a user of it, and as a
developer of software using it.)

For a considerable amount of time, I've been trying to identify ways in
which MIDI can be made a bit more user-friendly.

Up until now, I've just hacked together bits of code that work for the
equipment I use (not a lot, to be honest.)

I realise that a lot of MIDI equipment these days have USB ports, and that
they appear to a host computer as a separate individual MIDI interface.
But I'm sure there's plenty of existing equipment out there sporting the
traditional 5-pin DIN interface, and other MIDI accessories. So the ideas
within this message apply mostly to users of such equipment.

The name I coined for this project was "MAL" - "MIDI Abstraction Layer".
Loosely based on the "hardware abstraction layer" concept, this basically
abstracts the MIDI protocol and provides an API which can deal with MIDI
messages and provide a standard and easy way to manage patch lists,
controller settings, etc.

What's all this got to do with ALSA? Well I think this would benefit ALSA
more than if it were just a stand-alone project of my own. (I will still
refer to these ideas as "MAL" in this message, to attempt to avoid
confusion.)

So to start with, you have your MIDI interfaces. These are typically
hardware ports, or they might be an internal device or software synth. In
many cases, this is where the story ends - one MIDI device is attached to
one MIDI interface.

Some musicians may have several MIDI devices connected to a single
interface (port.) In this case, the user would be able to specify which
device(s) listen or send on each channel. Some users may have more than
one device listening to a channel.

Each device has a patch list, possibly organised into categories. If a
particular channel on an interface is shared between multiple devices,
somehow the patch lists for each device could be merged, or displayed in
such a way that the user can clearly see what sounds they can expect to
hear if they select a particular patch.

This may be as follows:
"Grand Piano / Soft Strings"
(the latter being a non-standard MIDI patch that has the same patch number
as Grand Piano for the 2nd device.)

Additionally, each device may respond to different controllers, and may
ignore some completely. In this case, a "controller map" would be useful.
The most basic implementation would simply map a meaningful name to a
controller ID, whilst more advanced methods might take into account SysEx
messages (such as those employed by Yamaha XG devices) and possibly
indicating how to represent the MIDI controller data (eg: decibels.)

If you wish for the MIDI devices to be ultimately tweakable, ideally the
patch and controller mapping would be handled by a script of some form.
But it could also work just as a compiled library - a rather basic driver.

The idea is that the MAL API talks to such drivers, which would construct
MIDI messages for MAL to send out to MIDI devices.

To actually use a channel, it would need allocating first. This would
ensure that one channel is exclusively "owned" by an application. But it
would be pretty nice to be able to allow the user to just say "give me a
melody channel" and have one picked from the available melody channels, or
"give me a rhythm channel".

It'd be nice to dynamically reallocate channels on an "on-demand" basis.
The problem with that though, is that there might be some interruption in
performance as controller values are copied over from one channel to
another and notes stop/start, etc. (The controller values would somehow
need to be cached in order for this to work.)

Then there are the more advanced features such as SoundFont loading,
sample dumping (SDS), sequencer control, etc. Some of these may be handled
by the MAL API directly (particularly the sequenceer control.)

These are "auxiliary" functions, and would most likely require a user
interface of some form. So perhaps a good solution would be to implement
the functionality in a library, and the devices that make use of such
features can link to the library and make use of it. The GUIs for such
things would probably be best as a separate program/library, and called up
by the program being used.

For MIDI input, I haven't got that far with the design yet...

In summary, it's pretty much "MIDI Mapper" from the older versions of
Windows, but with a lot more flexibility.


The only problem I can see with this, is that - as I said earlier -
traditional MIDI devices and accessories are being replaced by USB
versions, which defeats most of the point of MAL.

But with that taken into account, it would still be nice for there to be a
standardized way in which applications could find out about what patches
and controllers are implemented by MIDI devices.


Thanks for reading. It's my hope that these ideas may be of value to the
ALSA developer community, and also the developers and users of music
applications on Linux.

If anyone wants further information, feel free to ask here or contact me
privately by email.

And if it's a completely pointless idea, let me know also ;)


Regards


Andrew Greenwood

From: Drake Wilson <drake@libcom.com>
Subject: Sequencer documentation follow-up
Date: Sun, 8 Jun 2003 22:06:30 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030608220629.A7532@octothorpe.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZfOjI3PrQbgiZnxM"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--ZfOjI3PrQbgiZnxM
Content-Type: multipart/mixed; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

... I have a draft, or part thereof.  It is in similar spirit to the
module overviews in the API reference, and I hope it to be of some
use, if not optimal.

I was going to post this earlier, but a) it's written in a weird XML
schema, in XSLTing which to HTML I have not had much success, b) I've
been somewhat ill recently, and c) I was hesitant to do so for unknown
reasons.

It should probably be integrated with the doxygeneratees in some form;
my initial impulse was to convert it to Texinfo, but that may not be
the best of ideas.  Comments are appreciated.  No warranty or
guarantee of any sort is made, naturally.

Attached: alsa-seq.fooml, 13 KB, XML.

   ---> Drake Wilson

--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="alsa-seq.fooml"
Content-Transfer-Encoding: quoted-printable

?xml version=3D"1.0" encoding=3D"utf-8"?> <!-- -*- XML -*- -->
<!DOCTYPE document SYSTEM "fooml.dtd">
<document xml:lang=3D"en-US">
<title>ALSA 0.9.x Sequencer Interface Overview</title>
<version>Draft 0.0.0</version>
<author>Drake Wilson</author>
<copy>Copyright &copy; 2003 Drake Wilson.  Permission is granted to
copy, distribute and/or modify this document under the terms of the
GNU Free Documentation License, Version 1.1 or any later version
published by the Free Software Foundation, with no Invariant Sections,
no Front-Cover Texts, and no Back-Cover Texts.  A copy of the License
may be found at <xref uri=3D"http://www.gnu.org/licenses/fdl.html" />.</cop=
y>

<section id=3D"open_close"><name>Opening and Closing</name>

<par>In order to use the ALSA sequencer, one must first open it.  This
is done with a call to <fun>snd_seq_open</fun>, giving the name of
the sequencer device one wishes to open and the mode thereof,
similarly to an <fun>open</fun> call.  Closing the device is
accomplished with <fun>snd_seq_close</fun>, which is
similarly similar to <fun>close</fun>.  The following constants are
used for opening the sequencer device:</par>

<tablei idx=3D"const_idx" elt=3D"const">
<ti><til>SND_SEQ_OPEN_OUTPUT</til><tir>open for output only</tir></ti>
<ti><til>SND_SEQ_OPEN_INPUT</til><tir>open for input only</tir></ti>
<ti><til>SND_SEQ_OPEN_DUPLEX</til><tir>open for both input and
output</tir></ti>
<ti><til>SND_SEQ_NONBLOCK</til><tir>make I/O non-blocking; see also
<fun>snd_seq_nonblock</fun></tir></ti>
</tablei>

</section>
<section id=3D"clients_ports"><name>Clients and Ports</name>

<par>In ALSA, each connection to a sequencer device is represented as a
client.  Usually, a process only connects to a sequencer device once,
and thus has only one client representation.  Each is given a client
ID, an unsigned one-byte integer (between 0 and 255 inclusive).  Each
client may have zero or more ports open; each port within a client is
given a port ID, another unsigned one-byte integer.  Client and port
IDs are fixed and are assigned by the ALSA system.  Generally,
user-space clients start at 128, MIDI device clients start at 64, and
system clients start at 0.  Each client and each port has a name,
which is an ASCII string.  Normally, ports are given names when they
are created; clients are given a default name when they are created,
which is changed later with <fun>snd_seq_set_client_name</fun>.</par>

<par>A client ID and a port ID together comprise a sequencer address,
stored as a <type>snd_seq_addr_t</type>,
with respective <code>client</code> and <code>port</code> fields.
Usually, when an address is written as a string, it is written as
client, then port, separated by either a colon or period.  The port
number is given in decimal; the client may be either given as a
decimal number or a name string.  The function
<fun>snd_seq_parse_address</fun>
parses an address in this format from ASCII string into
<type>snd_seq_addr_t</type> structure.</par>

<par>The easiest way to create and delete ports is to use the
<fun>snd_seq_create_simple_port</fun> and
<fun>snd_seq_delete_simple_port</fun> functions.  When creating a port
in this manner, one specifies a port name, as well as capabilities and
type.  The capabilities associated with a port describe what
permissions the host client has with the port, and what permissions
potential subscribers to the port have.  The type of the port
describes what sort of device is at the end.  The following constants
are used for this:</par>

<tablei idx=3D"const_idx" elt=3D"const">
<ti><til>SND_SEQ_PORT_CAP_READ</til><tir>allow read from port</tir></ti>
<ti><til>SND_SEQ_PORT_CAP_SUBS_READ</til><tir>allow read
subscription from port</tir></ti>
<ti><til>SND_SEQ_PORT_CAP_WRITE</til><tir>allow write to port</tir></ti>
<ti><til>SND_SEQ_PORT_CAP_SUBS_WRITE</til><tir>allow write
subscription to port</tir></ti>
<ti><til>SND_SEQ_PORT_CAP_NO_EXPORT</til><tir>disallow external
routing</tir></ti>
</tablei>

<tablei idx=3D"const_idx" elt=3D"const">
<ti><til>SND_SEQ_PORT_TYPE_APPLICATION</til><tir>port is attached
to an application device</tir></ti>
<ti><til>SND_SEQ_PORT_TYPE_SAMPLE</til><tir>port is attached to a
sampling device</tir></ti>
<ti><til>SND_SEQ_PORT_TYPE_DIRECT_SAMPLE</til><tir>port is
attached to a sampling device supporting download</tir></ti>
<ti><til>SND_SEQ_PORT_TYPE_MIDI_GENERIC</til><tir>port is attached
to a generic MIDI device</tir></ti>
<ti><til>SND_SEQ_PORT_TYPE_MIDI_GM</til><tir>port is attached to a
GM compatible device</tir></ti>
<ti><til>SND_SEQ_PORT_TYPE_MIDI_GS</til><tir>port is attached to a
GS compatible device</tir></ti>
<ti><til>SND_SEQ_PORT_TYPE_MIDI_MT32</til><tir>port is attached to
an MT-32 compatible device</tir></ti>
<ti><til>SND_SEQ_PORT_TYPE_MIDI_XG</til><tir>port is attached to
an XG compatible device</tir></ti>
<ti><til>SND_SEQ_PORT_TYPE_SYNTH</til><tir>port is attached to a
synthesizer device</tir></ti>
<ti><til>SND_SEQ_PORT_TYPE_SPECIFIC</til><tir>port is attached to
a hardware-specific type of device</tir></ti>
</tablei>

<par>It is also possible to use a <type>snd_seq_port_info_t</type>,
with <fun>snd_seq_create_port</fun> and <fun>snd_seq_delete_port</fun>
(which acts exactly or almost exactly like
<fun>snd_seq_delete_simple_port</fun>).  A
<type>snd_seq_port_info_t</type> contains a port's owning client,
name, capability bits, and type, as specified separately in
<fun>snd_seq_create_simple_port</fun>, but also information about the
number of MIDI channels and voices and the number of synthesized
voices available at a given port.  It is also possible to iterate
through ports on another client using
<fun>snd_seq_query_next_port</fun>.  Iterating through clients is
accomplished with the corresponding <type>snd_seq_client_info_t</type>
structure and <fun>snd_seq_query_next_client</fun> function.</par>

</section>
<section id=3D"subscriptions"><name>Subscriptions</name>

<par>When ports are created with the appropriate capabilities, other
clients may subscribe to them.  Thus may events be communicated
between clients; events from a port to which other clients have
read-subscribed may be set to be broadcast to all subscribers with
<fun>snd_seq_ev_set_subs</fun>.  Events may also be set to be
broadcast to all clients and all ports with
<fun>snd_seq_ev_set_broadcast</fun>; however, excessive use of such is
not recommended, and multicasting by subscription is generally a much
better approach.</par>

<par>Subscribing to ports is done most simply with the
<fun>snd_seq_connect_from</fun> and <fun>snd_seq_connect_to</fun>
functions.  These functions take a port on the current client, and
respectively a source or destination client/port pair.  Note that the
port which is being subscribed on the current client does not have to
have subscription capability from other clients in order for it to be
connected to other ports which do have such capability.</par>

</section>
<section id=3D"queues"><name>Queues</name>

<par>Each client may have one or more queues associated with it.  Queues
are used for scheduling events.  Each queue, like each client and each
port, also has an identification number, which is an integer and
specific to the client to which it is attached, and a name, which is
an ASCII string.  Events may be scheduled on queues with
<fun>snd_seq_ev_schedule_tick</fun>
for times in ticks or <fun>snd_seq_ev_schedule_real</fun>
for times in nanoseconds (or actually seconds and
nanoseconds&em;see <type>snd_seq_real_time_t</type>).</par>

<par>The primary structures that deal with queues are
<type>snd_seq_queue_info_t<type>, <type>snd_seq_queue_status_t</type>,
<type>snd_seq_queue_tempo_t</type>, and
<type>snd_seq_queue_timer_t</type>.  A queue info structure contains
relatively permanent data: a queue's name, owner client, flags, and
lockedness.  A queue status structure, on the other hand, contains
more transient and time-dependent data: the number of events in a
queue, the running status bits, and the time on the queue in ticks and
seconds/nanoseconds.  A queue tempo structure contains the speed
information for a queue: the PPQ resolution, &mu;sPQ tempo, and timer
skew (expressed as integers <code>skew/skew_base</code>).  A queue
timer structure contains the less mutable timer information for a
queue: the timer ID, resolution, and type.</par>

<par>Queues may be created with <fun>snd_seq_create_queue</fun>, or
just allocated with <fun>snd_seq_alloc_queue</fun> or
<fun>snd_seq_alloc_named_queue</fun>.
They may be deleted with <fun>snd_seq_free_queue</fun>.</par>

</section>
<section id=3D"events"><name>Events</name>

<par>The primary unit of information passed through the ALSA sequencer
is the event.  Many sequencer events correspond to MIDI events; others
are control events for ALSA itself, for communication between
applications, or for other purposes.</par>

<par>To create events, one usually uses
the macros in the middle-level interface.  For MIDI events, one
generally sets an event of type
<const>SND_SEQ_EVENT_<msv>FOOBAR</msv></const> using the corresponding
macro <fun>snd_seq_ev_set_<msv>foobar</msv></fun>.  (Note
the difference in case.)  The arguments to the macro are a pointer to
the event, and the data for the event.  The following MIDI event types
are defined:</par>

<tablei idx=3D"const_idx" elt=3D"const">
<ti><til>SND_SEQ_EVENT_NOTEON</til>
<til>SND_SEQ_EVENT_NOTEOFF</til><tir>note on and note off.  Takes
channel, note number, and velocity
(<type>snd_seq_ev_note_t</type>).</tir></ti>
<ti><til>SND_SEQ_EVENT_NOTE</til><tir>note on <em>combined</em> with
note off.  Takes channel, note number, velocity, and duration in ticks
(<type>snd_seq_ev_note_t</type>).</tir></ti>
<ti><til>SND_SEQ_EVENT_KEYPRESS</til><tir>polyphonic pressure.  Takes
channel, note number, and velocity
(<type>snd_seq_ev_note_t</type>).</tir></ti>
<ti><til>SND_SEQ_EVENT_CHANPRESS</til><tir>channel pressure.  Takes
channel and value (<type>snd_seq_ev_ctrl_t</type>).</tir></ti>
<ti><til>SND_SEQ_EVENT_CONTROLLER</til><tir>continuous controller
data.  Takes channel, controller number, and value
(<type>snd_seq_ev_ctrl_t</type>).</tir></ti>
<ti><til>SND_SEQ_EVENT_PGMCHANGE</til><tir>program change.  Takes
channel and program (<type>snd_seq_ev_ctrl_t</type>).</tir></ti>
<ti><til>SND_SEQ_EVENT_PITCHBEND</til><tir>pitch bend.  Takes channel
and value, with value between -8192 and 8191
(<type>snd_seq_ev_ctrl_t</type>).</tir></ti>
<ti><til>SND_SEQ_EVENT_SYSEX</til><tir>system exclusive data.  Takes
length and pointer to data (<type>snd_seq_ev_ext_t</type>).</tir></ti>
</tablei>

<par>Each event also has a source, destination, and scheduling mode.
The source client is determined by the handle to which an event is
output.  The source port and destination may be set by
<fun>snd_seq_ev_set_source</fun>
and <fun>snd_seq_ev_set_dest</fun>
(which takes a client and port as separate arguments).  Broadcasting
to all and broadcasting to subscribers are special destinations, which
may be set by <fun>snd_seq_ev_set_broadcast</fun>
and <fun>snd_seq_ev_set_subs</fun>,
respectively.  The scheduling mode of an event determines whether it
is sent directly or on a queue, and if on a queue, which queue, and
when.  Direct scheduling may be set with <fun>snd_seq_ev_set_direct</fun>,
which takes only the event.  Queue scheduling may be set with
<fun>snd_seq_ev_schedule_tick</fun>,=20
to give a time in ticks, or <fun>snd_seq_ev_schedule_real</fun>,
to give a time using a <fun>snd_seq_real_time_t</fun>.
Each takes event, queue ID (see <ref to=3D"queues">Queues</ref>),
relativity (true iff the scheduling is relative to the current time),
and time (in a format dependent on which scheduling macro is being
used).</par>

<par>Events may be queried by means of the event C structure,
<type>snd_seq_event_t</type>, which has the
following elements:</par>

<tablei elt=3D"code">
<ti><til>type</til><tir>a <type>snd_seq_event_type_t</type> with the
type of the event.</tir></ti>
<ti><til>source</til><til>dest</til><tir>
<type>snd_seq_addr_t</type> fields containing the source and
destination ports</ti>
<ti><til>queue</til><til>time</til><tir>the queue associated with
the event, and its timestamp for input or output as a
<type>snd_seq_timestamp_t</type>.</tir></ti>
<ti><til>note</til><til>control</til><til>ext</til><tir>MIDI
data associated with the event.  Which one is used depends on the type
of event; see the table above.  They are of types
<type>snd_seq_ev_note_t</type>, <type>snd_seq_ev_ctrl_t</type>, and
<type>snd_seq_ev_ext_t</type>, respectively.</tir></ti>
</tablei>

</section>
<section id=3D"read_write"><name>Reading and Writing</name>

<par>Synchronous (blocking) I/O is primarily accomplished with the
functions <fun>snd_seq_event_output</fun> and
<fun>snd_seq_event_input</fun>.  These functions behave much like
standard blocking write and read calls.  There are also
<fun>snd_seq_event_output_buffer</fun> and
<fun>snd_seq_event_output_direct</fun>, which output without flushing
the buffer and output without buffering, respectively.  Nonblocking
I/O can be accomplished by setting nonblocking mode with the
<fun>snd_seq_nonblock</fun> call; waiting for I/O is a little bit more
complicated, and involves <fun>poll</fun>ing.  One must first call
<fun>snd_seq_poll_descriptors_count</fun> to obtain the number of
descriptors to poll, then allocate space for such and use
<fun>snd_seq_poll_descriptors</fun> to obtain the actual descriptors,
followed by a <fun>poll</fun> on them.</par>

</section>
<section id=3D"reference"><name>Reference</name>

</section>
</document>

--EeQfGwPcQSOJBaQU--

--ZfOjI3PrQbgiZnxM
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE+4+ul1fuSPH+onEsRAsnOAJ4wx2IJD7kHFudDw/Lm/zljbdCVVgCg/RiF
yrjzg4H/4NJ/F5HgfMJqUAU=
=bxzg
-----END PGP SIGNATURE-----

--ZfOjI3PrQbgiZnxM--


-------------------------------------------------------
This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
thread debugger on the planet. Designed with thread debugging features
you've never dreamed of, try TotalView 6 free at www.etnus.com.

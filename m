From: "Ronald S. Bultje" <rbultje@ronald.bitfreak.net>
Subject: why do elements disappear?
Date: Tue, 15 Feb 2005 22:12:53 +0100
Message-ID: <1108501973.2845.87.camel@tux.lan>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7BIT
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

a mixer app of mine (you know, one of those controlling volumes) is
updating itself (if other apps change settings) by continuously running
get-volume (et al) on all mixer elements every once in a while (10Hz).
Right, so I could use signals or whatever it is that libalsa provides,
but this is what OSS and such require, so I'm using this for now. This
all works really well, except if new applications are started accessing
the soundcard and the soundcard is a sb!live (which is true for quite a
bunch of people). It will then sometimes crash. Backtraces look like
this:

#3  <signal handler called>
#4  0x001ef7a2 in _dl_sysinfo_int80 () from /lib/ld-linux.so.2
#5  0x023cb955 in raise () from /lib/tls/libc.so.6
#6  0x023cd319 in abort () from /lib/tls/libc.so.6
#7  0x023c4f41 in __assert_fail () from /lib/tls/libc.so.6
#8  0x00b5e237 in snd_mixer_selem_get_playback_volume ()
   from /lib/libasound.so.2

Here's some more debug on the track we're accessing (this is GStreamer
information, but you'll get the idea):

(gdb) print *alsa_track
$1 = {parent = {parent = {g_type_instance = {g_class = 0x8a37870},
ref_count = 3, qdata = 0x8ab1528}, label = 0x8a63488 "EMU10K1 PCM",
flags = GST_MIXER_TRACK_OUTPUT, num_channels = 3, min_volume = 0,
max_volume = 65535}, element = 0x8a7bb00, track_num = 40, alsa_flags =
2, volumes = {65535, 65535, 65535, 0 <repeats 29 times>}}

OK, so this is specific to the EMU10K1 PCM tracks (there's 32 of them).
Those are *not* the first elements, definately, I don't know what they
do exactly though though... But it's something specific to them.

I figured I could be an idiot, so here's valgrind:

==20529== Invalid read of size 4
==20529==    at 0x1BB870B0: snd_mixer_selem_has_playback_switch (in
/lib/libasound.so.2.0.0)
==20529==    by 0x1D01AB2B: gst_alsa_mixer_update (gstalsamixer.c:412)
==20529==    by 0x1D01AC4A: gst_alsa_mixer_get_volume
(gstalsamixer.c:439)
==20529==    by 0x1C416998: gst_mixer_get_volume (mixer.c:185)
==20529==  Address 0x1CE2B678 is 0 bytes inside a block of size 44
free'd
==20529==    at 0x1B904FB1: free (vg_replace_malloc.c:153)
==20529==    by 0x1BB8390C: snd_mixer_elem_remove (in
/lib/libasound.so.2.0.0)
==20529==    by 0x1BB86630: (within /lib/libasound.so.2.0.0)
==20529==    by 0x1BB8668C: (within /lib/libasound.so.2.0.0)

It appears that alsa removes the EMU10K1 PCM elements when I call
snd_mixer_handle_events(). Why does it do that, how do I make it stop
doing it and/or how do I handle this?

Thanks,

Ronald
-- 
Ronald S. Bultje <rbultje@ronald.bitfreak.net>



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click

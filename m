From: Sacher Khoudari <alsa-devel@craesh.net>
Subject: Need some help for a metronome
Date: Sat, 31 Jul 2004 01:31:48 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <410ADA64.6020006@craesh.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Mailing list for ALSA developers <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi!

I need some help to get my litle metronome to work. I'm an Alsa-Newbie,
so I'm sorry for this - probably - stupid question. I've copied some
code from tutorials and other Alsa-programs, so probably I've forgotten
some details. But I don't know what.

The error has to be in this function, it gets called every time a "tick"
has to be played, but it doesn't send any MIDI-events. At least,
fluidsynth doesn't play anything (nor prints any events in verbose mode).

- --snip--

void schedule_event( guint8 i_velocity, guint i_ticks ) {
	guint i_channel = 10;
	guint i_note = 33;
	guint i_duration = 1;

	snd_seq_event_t ev;

	snd_seq_ev_clear( &ev );
	//ev.type = SND_SEQ_EVENT_USR0;
	//ev.type = SND_SEQ_EVENT_NOTE;
	snd_seq_ev_set_source( &ev, my_port );
	snd_seq_ev_set_subs( &ev );
	//snd_seq_ev_set_dest( &ev, i_dest_client, i_dest_port );
	snd_seq_ev_set_note( &ev, i_channel, i_note, i_velocity, i_duration );
	snd_seq_ev_schedule_tick( &ev, my_queue, 0, i_ticks );
	printf( "channel: %d, note: %d, velocity: %d, duration: %d, i_ticks
%d", i_channel, i_note, i_velocity, i_duration, i_ticks );

	snd_seq_event_output( handle, &ev );
	snd_seq_drain_output( handle );
}

- --snap--

The printf gets called, and the values are ok. I've also tried the
things which are commented out. Whats wrong, or missing? Can anyone help me?

Thanks!
Sacher
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBCtpjdiWjuQmpvxoRApCaAKCtqGGsUeu3/ubPDbHR2WiHKBcr5QCg7SQY
XtvpXQYgTP/Tzs7gttVgpHo=
=xmct
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com

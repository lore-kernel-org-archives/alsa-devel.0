From: fn ln <neplace1@yahoo.ca>
Subject: recording MIDI with linux (2.4.8?), v_midi, perl ?
Date: Wed, 27 Mar 2002 04:40:45 -0500 (EST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020327094045.41579.qmail@web21304.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net, midi@perl.org
List-Id: alsa-devel@alsa-project.org


 hi,

 I'm getting a bit desparate here. I'm trying to
record
tunes from extenal MIDI device.

 I have Mandrake 8.1 (kernel 2.4.8,
alsa-driver-0.5.11)
and serial-port MIDI connection, so I use a v_midi
driver (with handwritten character shunt between
/dev/ttyS0 and /dev/midi1; v_midi is then an internal
shunt between /dev/midi1 and /dev/midi).

 Now since I would like to control the computer with
certain combination of events on the input MIDI
stream,
I would like to use perl to process & to record the
incoming MIDI. The only way I heard it is possible
with
perl is to use MIDI::Music. But MIDI::Music requires
some IOCTLs don't seem to be present under Linux 2.4.8
alsa-0.5.11, so it refuses to do "realtime", which in
turn means that length of notes cannot be preserved
(when I play back a 3-minute tune I recorded without
"realtime", it plays back within about 5 seconds).

 Is anybody out here who either has same or similar
setup working, or knows how to get it to work, or can
give me pointers on as to how do I get it to work ?

  I'm getting a bit desparate -- I'll be greateful for
any relevant response.

   thx,

       John


______________________________________________________________________ 
File your taxes online! http://taxes.yahoo.ca

From: Haakon Riiser <haakon.riiser@fys.uio.no>
Subject: SysEx overflow when using the MIDI sequencer event
	interface
Date: Sat, 19 Aug 2006 12:24:21 +0200
Message-ID: <20060819102421.GA1991@fox>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
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

I'm trying to fix a problem with the DOSBox emulator that occurs
when it's sending SysEx events to an external Roland MIDI device
(CM-32L in my case).

After a little investigation, I discovered that the problem is that
SysEx messages sent via the sequencer event interface are pushed out
faster than my Roland CM-32L can process them.

This bug only affects the event interface:  Sending the SysEx
commands using the rawmidi interface (for example by using 'amidi
-s <sysex-file>') works perfectly.  I can reproduce DOSBox's
problems using a toy version of amidi that uses the event interface.
Here's what my implementation does:

  snd_seq_open(&handle, "hw", SND_SEQ_OPEN_DUPLEX, 0);
  snd_seq_create_simple_port(handle, NULL, SND_SEQ_PORT_CAP_WRITE |
                                           SND_SEQ_PORT_CAP_SUBS_WRITE |
                                           SND_SEQ_PORT_CAP_READ,
                             SND_SEQ_PORT_TYPE_MIDI_GENERIC);
  snd_seq_connect_to(handle, 0, 16, 0);

  while (get_next_sysex_command(sysex_data, &sysex_len)) {
          snd_seq_event_t ev;
          snd_seq_ev_clear(&ev);
          snd_seq_ev_set_source(&ev, 0);
          snd_seq_ev_set_subs(&ev);
          snd_seq_ev_set_direct(&ev);
          snd_seq_ev_set_sysex(&ev, sysex_len, sysex_data);
          snd_seq_event_output(handle, &ev);
          snd_seq_drain_output(handle);
          snd_seq_sync_output_queue(handle);
  } 

As an example of how much data is lost, consider that it took less
than 1.5 seconds to send 18 kB of SysEx messages using my program,
while it takes amidi over 6 seconds.

If I insert a delay of, say, 100 ms between each sent SysEx
command, my program appears to work, but there _has_ to be a
better way to ensure that the SysEx message is processed before
starting to send a new one.

Is this a bug in the ALSA code, or is there a synchronization
call or something like that I can use?

-- 
 Haakon

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642

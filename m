From: Brix <brix82@libero.it>
Subject: troubles programming with the sequencer
Date: Fri, 23 Jan 2004 19:05:32 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040123190532.1f335a80.brix82@libero.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi, i'm developing an ear-trainer (an application to improve musical ears) and i must use the MIDI synth to play out chords, but i can't let the alsa sequencer work.
My code doesn't return any error, i just can't hear anything. If i do it via the RawMIDI API, it works fine (but it's, bleahh, horrible to use).
I thought it was because i didn't assign any path/instrument to the midi channels, so i tried to set them via RawMIDI, but it still doesn't work.

Here is the code:


#include <alsa/asoundlib.h>

snd_rawmidi_t *handle_out;

void set_chan_instr( int chan, int instrument ) { // sets patch/instrument number on a channel
  int ch = 0xC0 + chan;
  snd_rawmidi_write(handle_out, &ch, 1);
  ch = instrument;
  snd_rawmidi_write(handle_out, &ch, 1);
}  

snd_seq_t *open_client() { // creates a client
  snd_seq_t *handle;
  int err;
  err = snd_seq_open(&handle, "default", SND_SEQ_OPEN_DUPLEX, 0);
  if (err < 0)
    return NULL;
  snd_seq_set_client_name(handle, "My Client");
  return handle;
}

int main() {

  snd_seq_t *seq;
  snd_seq_queue_tempo_t *tempo;
  snd_seq_event_t ev;
  snd_seq_port_info_t *port_info, *wavetable;
  int port;
  int queue;

  // now we try to set up channel 0 via RawMIDI
  if ( snd_rawmidi_open( NULL, &handle_out, "hw:0,1", 0) ) {
    printf( "snd_rawmidi_open() failed\n" );
    return -1;
  }
  // ok, let's assign instrument #4
  set_chan_instr( 0, 4 );

  // we create a client...
  if ( ( seq = open_client() ) == NULL ) {
    printf( "Error in: snd_seq_open" );
    return -1;
  }
  // and a port
  port = snd_seq_create_simple_port(seq, "my port", SND_SEQ_PORT_CAP_DUPLEX, SND_SEQ_PORT_TYPE_APPLICATION);
  queue = snd_seq_alloc_queue(seq); // do allocate a queue
  snd_seq_queue_tempo_alloca(&tempo);
  snd_seq_queue_tempo_set_ppq(tempo, 96); // 96 pulses per quarter
  snd_seq_queue_tempo_set_tempo(tempo, 1000000); // 60 BPM
  snd_seq_set_queue_tempo(seq, queue, tempo);

  snd_seq_ev_clear(&ev); 
  snd_seq_ev_set_dest(&ev, 65, 0); // 65:0 works fine with pmidi!
  snd_seq_ev_set_source(&ev, port);
  snd_seq_ev_schedule_tick(&ev, queue, 0, 4); // starts at 4 ticks
  snd_seq_ev_set_note(&ev, 0, 60, 127, 8); // length 8 ticks
  snd_seq_event_output(seq, &ev);
  snd_seq_ev_schedule_tick(&ev, queue, 0, 12);
  snd_seq_ev_set_note(&ev, 0, 67, 127, 8);
  
  // let's play! (we hope..)
  snd_seq_event_output(seq, &ev);
  snd_seq_drain_output(seq);
  snd_seq_start_queue(seq, queue, NULL);
  snd_seq_drain_output(seq);

  return 0;
}


Note that i can play midi files using pmidi on port 65:0.
Hope you can help me,

	Marco

-- 

	Hardware is never old.
	People just choose the wrong OS.


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn

From: Gerald Grabner <gerald.grabner@gmx.net>
Subject: seq: maximum number of events w.r.t. ordering in queue
Date: Sun, 04 Feb 2007 20:04:49 +0100
Message-ID: <45C62E51.3050608@gmx.net>
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

Hi there,

for simultaneously playing many midi tracks each with a large number
of events, it would be convenient to output one track after the other
in a simple loop, without caring about the ordering of the events.

Of course, this requires an output buffer large enough to hold all
events, otherwise events of the later are postponed every time the
buffer is full. But one question remains, at least for me:
Is there a maximum number of events w.r.t. the ordering in a queue?

Below is a simple test program that pumps a number of events in
reverse tick order into the output buffer, i.e. starting with the
latest tick (high hotes) and finishing with tick=0 (low notes).
output_buffer_size, client_pool_output and client_pool_output_room are
increased to have the capacity for all events. But still, the (high)
notes with the lowest ticks are played only towards the end instead of
at the beginning - obviously because they were output last. The
ordering is failing.

Is there a way to ensure that all events are played in correct order,
regardless of when the are outputted?

Many thanks,
Gerald

BTW: alsa version = 1.0.11

**

#include <alsa/asoundlib.h>
#include <stdio.h>

int main()
{
  // open sequencer
  snd_seq_t* seq;
  snd_seq_open(&seq, "default", SND_SEQ_OPEN_DUPLEX, 0) ;
  int my_port = snd_seq_create_simple_port
    ( seq, "standard port",
      SND_SEQ_PORT_CAP_READ | SND_SEQ_PORT_CAP_SUBS_READ,
      SND_SEQ_PORT_TYPE_APPLICATION) ;

  // number of events
  unsigned int n = 600 ;

  // buffer size for all events
  unsigned int b = (n+1)*sizeof(snd_seq_event_t);

  // set output buffer and client pool size
  if ( snd_seq_set_output_buffer_size(seq,b) )
    printf("Error setting output_buffer_size\n");
  if ( snd_seq_set_client_pool_output(seq,b) )
    printf("Error setting client_pool_output\n");
  if ( snd_seq_set_client_pool_output_room(seq,b) )
    printf("Error setting client_pool_output_room\n");

  // connect to 21:0 (OPL3)
  snd_seq_connect_to(seq, my_port, 21, 0);

  // queue (default: 96 PPQ and 120 BPM)
  int queue = snd_seq_alloc_queue(seq);
  snd_seq_start_queue (seq, queue, NULL);
  snd_seq_drain_output(seq);

  // set and schedule events
  snd_seq_event_t ev ;
  snd_seq_ev_clear(&ev);
  snd_seq_ev_set_subs(&ev);
  snd_seq_ev_set_noteon(&ev,0,60,127);
  unsigned int i;
  for ( i=0 ; i<n ; i++ )
    {
      // note range: 12-107
      ev.data.note.note = (unsigned char) (12+(107-12)*i/(n-1));
      // tick in decreasing order, total length = 4 quarters
      snd_seq_ev_schedule_tick(&ev, queue, 0, (n-1-i)*96*4/n);
      // output event
      snd_seq_event_output(seq, &ev);
    }
  printf("scheduling done...\n");

  // send events and wait for end
  snd_seq_drain_output(seq);
  snd_seq_sync_output_queue(seq);
  sleep(1);

  // done
  snd_seq_close ( seq ) ;
  return 0 ;
}

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642

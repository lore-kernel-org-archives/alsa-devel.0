From: Michael Geis <michaelgeis11@yahoo.com>
Subject: removing events from queue according to tag
Date: Wed, 2 Mar 2005 03:58:58 -0800 (PST)
Message-ID: <20050302115858.69453.qmail@web51902.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
I am trying to remove events from a queue after having
scheduled them with a tag. The following minimal
program re-produces the problem. If I choose to remove
events not acc. to tag but all events in the queue
(via SND_SEQ_REMOVE_OUTPUT), things work fine. 
I.e. only the first note out of ten should is played.
Have I overlooked sth obvious regarding tags? 
Any suggestions on are much appreciated.

//demo.cpp
//compile with g++ demo.cpp -o demo -lasound
#include <alsa/asoundlib.h>
using namespace std;

int main() {
    snd_seq_t* seq;
    snd_seq_open(&seq,"default",SND_SEQ_OPEN_DUPLEX,
0);
    int client_id=snd_seq_client_id(seq);
    int queue = snd_seq_alloc_queue(seq);       
    snd_seq_start_queue(seq,queue,NULL);
    snd_seq_drain_output(seq);
    unsigned int  capability=SND_SEQ_PORT_CAP_READ|
SND_SEQ_PORT_CAP_SUBS_READ;
    int
port_id=snd_seq_create_simple_port(seq,"",capability,SND_SEQ_PORT_TYPE_APPLICATION);
    //fill in source and destination
    snd_seq_addr_t sender, dest;
    sender.client = client_id;
    sender.port =  port_id;
    dest.client =  128;
    dest.port = 0;
 
    //add them to the subscription
    snd_seq_port_subscribe_t *subs;
    snd_seq_port_subscribe_alloca(&subs);
    snd_seq_port_subscribe_set_sender(subs, &sender);
    snd_seq_port_subscribe_set_dest(subs, &dest);
    snd_seq_port_subscribe_set_queue(subs,queue);
    snd_seq_port_subscribe_set_time_update(subs, 1);
    snd_seq_port_subscribe_set_time_real(subs, 1);
    snd_seq_subscribe_port(seq, subs);

    //repeat the same note of length 1 second ten
times.    
    int tag=1;
    int channel=0;
    int pitch=64;
    int dynamics=64;
    for(int i=0;i<10;++i) {
      snd_seq_event_t ev;
      snd_seq_ev_clear(&ev);
      snd_seq_ev_set_subs(&ev);
      snd_seq_ev_set_source(&ev, port_id);
      ev.tag=tag;      
      snd_seq_real_time_t time_stamp;
      //nanosecond component
      time_stamp.tv_nsec=0;
      //send NoteOn event
      time_stamp.tv_sec=i;
      snd_seq_ev_schedule_real(&ev, queue,
0,&time_stamp);	 
     
snd_seq_ev_set_noteon(&ev,channel,pitch+i,dynamics);
      snd_seq_event_output(seq, &ev);
      //send NoteOff event
      time_stamp.tv_sec=i+1;
      snd_seq_ev_schedule_real(&ev, queue,
0,&time_stamp);	 
     
snd_seq_ev_set_noteoff(&ev,channel,pitch+i,dynamics);
      snd_seq_event_output(seq, &ev);

      snd_seq_free_event(&ev);
    }
    snd_seq_drain_output(seq);
    //erase tag
    snd_seq_remove_events_t* remove;;
    snd_seq_remove_events_alloca(&remove);
//   
snd_seq_remove_events_set_condition(remove,SND_SEQ_REMOVE_OUTPUT);
    
snd_seq_remove_events_set_condition(remove,SND_SEQ_REMOVE_TAG_MATCH);
 
    snd_seq_remove_events_set_tag(remove, tag);
    snd_seq_remove_events(seq,remove);
    snd_seq_drain_output(seq);
    sleep(10);
    return 0;
}

Thanks in advance,

Michael


	
		
__________________________________ 
Celebrate Yahoo!'s 10th Birthday! 
Yahoo! Netrospective: 100 Moments of the Web 
http://birthday.yahoo.com/netrospective/


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click

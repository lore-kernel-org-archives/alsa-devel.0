From: Michael Geis <michaelgeis11@yahoo.com>
Subject: queue time not increasable with snd_seq_ev_set_queue_pos_real
Date: Thu, 3 Mar 2005 04:21:33 -0800 (PST)
Message-ID: <20050303122133.41334.qmail@web51907.mail.yahoo.com>
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

Hi, I thought I had all ALSA components of my app
working
when I noticed that I can change queue times backwards
but not forwards via snd_seq_ev_set_queue_pos_real.
I.e. if the queue time is at 5.0 seconds and I call
snd_seq_ev_set_queue_pos_real with a desired time of
1.0 seconds, the queue time will be set to 1.0.
If, however, the queue time is 0.0 and I call
snd_seq_ev_set_queue_pos_real with desired time 5.0,
the queue time remains unaffected.
in the below program, setting bool forward=true shows
the case of a forward jump, which is working. Setting
it to false for a backward jump, however, reveals that
the queue time is unaffected by the call to
snd_seq_ev_set_queue_pos_real.
Does that imply that forward and backward jumps need
to be handled differently?

// compile with g++ -o demo demo.cpp -lasound
#include <alsa/asoundlib.h>
#include <iostream>

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

    //set to true to jump forward in queue time. Set
to false to jump backward.
    bool forward=true;
    float secs;
    //set the queue time to 5 seconds.
    if(forward) secs=5.0;
    //wait 5 seconds, then set teh queue time to 1.0
    else  {
      sleep(5);
      secs=1.0;
    }
    snd_seq_event_t ev;
    snd_seq_ev_clear(&ev);
    snd_seq_ev_set_subs(&ev);
    snd_seq_ev_set_source(&ev, port_id);
    snd_seq_real_time_t time_stamp;
    time_stamp.tv_sec=(int)secs;
   
time_stamp.tv_nsec=(int)((secs-time_stamp.tv_sec)*1000000000);
    snd_seq_ev_schedule_real(&ev, queue,
0,&time_stamp);
    snd_seq_ev_set_queue_pos_real(&ev,
queue,&time_stamp);
    snd_seq_event_output(seq, &ev);
    snd_seq_drain_output(seq);
    snd_seq_free_event(&ev);

    snd_seq_queue_status_t *info;
    snd_seq_queue_status_alloca(&info);
    snd_seq_get_queue_status(seq, queue,info);    
    const snd_seq_real_time_t*     
time=snd_seq_queue_status_get_real_time(info);
    float
actual_time=time->tv_sec+time->tv_nsec*.000000001;

    cout<<"Set time to "<<actual_time<<endl;
    return 0;
}


Thanks in advance,
Michael

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click

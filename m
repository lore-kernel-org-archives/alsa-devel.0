From: Michael Geis <michaelgeis11@yahoo.com>
Subject: Re: obtaining timestamps from sequencer events
Date: Tue, 21 Dec 2004 16:38:22 -0800 (PST)
Message-ID: <20041222003822.42138.qmail@web51908.mail.yahoo.com>
References: <Pine.LNX.4.58.0412211011120.1746@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1309357562-1103675902=:39310"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0412211011120.1746@pnote.perex-int.cz>
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

--0-1309357562-1103675902=:39310
Content-Type: text/plain; charset=us-ascii

Thanks Jaroslav. I played around with those functions. I now set up the port manually.
I also check the queue time at very incoming event. Still, after setting a time stamp
for my port, all timestamps remain 0.
I gather that the queue is running properly, since omitting snd_seq_start_queue keeps all
events from arriving and polling works once snd_seq_start_queue is called.
The time functions snd_seq_port_info_set_timestamping() and snd_seq_port_info_set_timestamp_real() get arguments of 1 to switch on the time_stamping
and making it real time. The events are realtime, so I am not trying to cout events of the wrong kind.
Also, there are no more functions relating to setting up a timestamp for a port than those I used, so I cant really have missed anything there. 
My code now look slike this:
 
 
#include <alsa/asoundlib.h>
#include <iostream>
using namespace std;
int  main() {
    snd_seq_t* seq;     
    snd_seq_open(&seq,"default",SND_SEQ_OPEN_INPUT, 0);
    snd_seq_port_info_t * port_info;
    snd_seq_port_info_malloc(&port_info);
    int port_id=0;
    snd_seq_port_info_set_client(port_info,snd_seq_client_id(seq) );
    snd_seq_port_info_set_port(port_info,port_id);
    snd_seq_port_info_set_name(port_info, "Hallo Welt");
    snd_seq_port_info_set_capability(port_info,SND_SEQ_PORT_CAP_WRITE | SND_SEQ_PORT_CAP_SUBS_WRITE);
    snd_seq_port_info_set_type(port_info,SND_SEQ_PORT_TYPE_APPLICATION);
  
    snd_seq_port_info_set_timestamping(port_info, 1);
    snd_seq_port_info_set_timestamp_real(port_info,1);
    int queue = snd_seq_alloc_queue(seq);       
    snd_seq_port_info_set_timestamp_queue(port_info, queue);
    snd_seq_create_port(seq, port_info);
    snd_seq_port_info_free(port_info);
   
    //fill in source and destination
    snd_seq_addr_t sender, dest;
    sender.client = 72;
    sender.port =  0;
    dest.client = snd_seq_client_id(seq); 
    dest.port =port_id;
    //add them to the subscription
    snd_seq_port_subscribe_t *subs;
    snd_seq_port_subscribe_alloca(&subs);
    snd_seq_port_subscribe_set_sender(subs, &sender);
    snd_seq_port_subscribe_set_dest(subs, &dest);
    //add the queue to the subscription
    snd_seq_port_subscribe_set_queue(subs, 1);
    snd_seq_port_subscribe_set_time_update(subs, 1);
    snd_seq_port_subscribe_set_time_real(subs, 1);
    
    //make the subscription
    snd_seq_subscribe_port(seq, subs);
    snd_seq_start_queue(seq,queue,NULL);
    //get teh queue time before polling events
    snd_seq_queue_status_t * queue_status;
    snd_seq_queue_status_malloc(&queue_status);
    snd_seq_get_queue_status(seq, queue, queue_status);
    const snd_seq_real_time_t* time=snd_seq_queue_status_get_real_time(queue_status); 
    cout<<"queue time at start"<<time->tv_sec<<endl;
    //open poll descriptor
    struct pollfd* pfd = (struct pollfd *)alloca(sizeof(struct pollfd));
    snd_seq_poll_descriptors(seq, pfd, 1, POLLIN);
    while (1) {
      int success=poll(pfd, 1, 100000);
      if (success > 0) {
        snd_seq_event_t *ev;
        do {          
   snd_seq_event_input(seq, &ev);   
   snd_seq_get_queue_status(seq, queue, queue_status);
   const snd_seq_real_time_t* time=snd_seq_queue_status_get_real_time(queue_status); 
          cout<<"received event at queue time: "<<time->tv_sec<<endl;
   if(snd_seq_ev_is_real(ev)) cout<<"received event with real time stamp: "<<ev->time.tick<<endl;
   switch (ev->type) {
      case SND_SEQ_EVENT_NOTEOFF: 
    cout<<"NoteOff"<<endl;
    break;        
      case SND_SEQ_EVENT_NOTEON:
                  cout<<"NoteOn"<<endl;
                  break;        
   }
   snd_seq_free_event(ev);
          //input pending with fetch sequencer =0;
        } while (snd_seq_event_input_pending(seq, 0) > 0);
      }  
    }
     snd_seq_queue_status_free(queue_status);
     free(&pfd);
     return 0;
  }

Any further ideas?
Thanks very much,
 
Michael

		
---------------------------------
Do you Yahoo!?
 Send holiday email and support a worthy cause. Do good.
--0-1309357562-1103675902=:39310
Content-Type: text/html; charset=us-ascii

<DIV>Thanks Jaroslav. I played around with those functions. I now set up the port manually.</DIV>
<DIV>I also check the queue time at very incoming event. Still, after setting a time stamp</DIV>
<DIV>for my port, all timestamps remain 0.</DIV>
<DIV>I gather that the queue is running properly, since omitting snd_seq_start_queue keeps all</DIV>
<DIV>events from arriving and polling works once snd_seq_start_queue is called.</DIV>
<DIV>The time functions snd_seq_port_info_set_timestamping() and snd_seq_port_info_set_timestamp_real() get arguments of 1 to switch on the time_stamping</DIV>
<DIV>and making it real time. The events are realtime, so I am not trying to cout events of the wrong kind.<BR>Also, there are no more functions relating to setting up a timestamp for a port than those I used, so I cant really have missed anything there. </DIV>
<DIV>My code now look slike this:</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;</DIV>
<DIV>#include &lt;alsa/asoundlib.h&gt;<BR>#include &lt;iostream&gt;<BR>using namespace std;</DIV>
<DIV>int&nbsp; main() {<BR>&nbsp;&nbsp;&nbsp; snd_seq_t* seq;&nbsp;&nbsp;&nbsp;&nbsp; <BR>&nbsp;&nbsp;&nbsp; snd_seq_open(&amp;seq,"default",SND_SEQ_OPEN_INPUT, 0);</DIV>
<DIV>&nbsp;&nbsp;&nbsp; snd_seq_port_info_t * port_info;<BR>&nbsp;&nbsp;&nbsp; snd_seq_port_info_malloc(&amp;port_info);<BR>&nbsp;&nbsp;&nbsp; int port_id=0;<BR>&nbsp;&nbsp;&nbsp; snd_seq_port_info_set_client(port_info,snd_seq_client_id(seq) );<BR>&nbsp;&nbsp;&nbsp; snd_seq_port_info_set_port(port_info,port_id);<BR>&nbsp;&nbsp;&nbsp; snd_seq_port_info_set_name(port_info, "Hallo Welt");<BR>&nbsp;&nbsp;&nbsp; snd_seq_port_info_set_capability(port_info,SND_SEQ_PORT_CAP_WRITE | SND_SEQ_PORT_CAP_SUBS_WRITE);<BR>&nbsp;&nbsp;&nbsp; snd_seq_port_info_set_type(port_info,SND_SEQ_PORT_TYPE_APPLICATION);</DIV>
<DIV>&nbsp; <BR>&nbsp;&nbsp;&nbsp; snd_seq_port_info_set_timestamping(port_info, 1);<BR>&nbsp;&nbsp;&nbsp; snd_seq_port_info_set_timestamp_real(port_info,1);<BR>&nbsp;&nbsp;&nbsp; int queue = snd_seq_alloc_queue(seq);&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>&nbsp;&nbsp;&nbsp; snd_seq_port_info_set_timestamp_queue(port_info, queue);<BR>&nbsp;&nbsp;&nbsp; snd_seq_create_port(seq, port_info);<BR>&nbsp;&nbsp;&nbsp; snd_seq_port_info_free(port_info);</DIV>
<DIV>&nbsp;&nbsp; <BR>&nbsp;&nbsp;&nbsp; //fill in source and destination<BR>&nbsp;&nbsp;&nbsp; snd_seq_addr_t sender, dest;<BR>&nbsp;&nbsp;&nbsp; sender.client = 72;<BR>&nbsp;&nbsp;&nbsp; sender.port =&nbsp; 0;<BR>&nbsp;&nbsp;&nbsp; dest.client = snd_seq_client_id(seq); <BR>&nbsp;&nbsp;&nbsp; dest.port =port_id;<BR>&nbsp;&nbsp;&nbsp; //add them to the subscription<BR>&nbsp;&nbsp;&nbsp; snd_seq_port_subscribe_t *subs;<BR>&nbsp;&nbsp;&nbsp; snd_seq_port_subscribe_alloca(&amp;subs);</DIV>
<DIV>&nbsp;&nbsp;&nbsp; snd_seq_port_subscribe_set_sender(subs, &amp;sender);<BR>&nbsp;&nbsp;&nbsp; snd_seq_port_subscribe_set_dest(subs, &amp;dest);<BR>&nbsp;&nbsp;&nbsp; //add the queue to the subscription<BR>&nbsp;&nbsp;&nbsp; snd_seq_port_subscribe_set_queue(subs, 1);<BR>&nbsp;&nbsp;&nbsp; snd_seq_port_subscribe_set_time_update(subs, 1);<BR>&nbsp;&nbsp;&nbsp; snd_seq_port_subscribe_set_time_real(subs, 1);<BR>&nbsp;&nbsp;&nbsp; <BR>&nbsp;&nbsp;&nbsp; //make the subscription<BR>&nbsp;&nbsp;&nbsp; snd_seq_subscribe_port(seq, subs);</DIV>
<DIV>&nbsp;&nbsp;&nbsp; snd_seq_start_queue(seq,queue,NULL);<BR>&nbsp;&nbsp;&nbsp; //get teh queue time before polling events<BR>&nbsp;&nbsp;&nbsp; snd_seq_queue_status_t * queue_status;<BR>&nbsp;&nbsp;&nbsp; snd_seq_queue_status_malloc(&amp;queue_status);<BR>&nbsp;&nbsp;&nbsp; snd_seq_get_queue_status(seq, queue, queue_status);<BR>&nbsp;&nbsp;&nbsp; const snd_seq_real_time_t* time=snd_seq_queue_status_get_real_time(queue_status); <BR>&nbsp;&nbsp;&nbsp; cout&lt;&lt;"queue time at start"&lt;&lt;time-&gt;tv_sec&lt;&lt;endl;</DIV>
<DIV>&nbsp;&nbsp;&nbsp; //open poll descriptor<BR>&nbsp;&nbsp;&nbsp; struct pollfd* pfd = (struct pollfd *)alloca(sizeof(struct pollfd));<BR>&nbsp;&nbsp;&nbsp; snd_seq_poll_descriptors(seq, pfd, 1, POLLIN);<BR>&nbsp;&nbsp;&nbsp; while (1) {<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int success=poll(pfd, 1, 100000);<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (success &gt; 0) {<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; snd_seq_event_t *ev;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; do {&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>&nbsp;&nbsp; snd_seq_event_input(seq, &amp;ev);&nbsp;&nbsp; <BR>&nbsp;&nbsp; snd_seq_get_queue_status(seq, queue, queue_status);<BR>&nbsp;&nbsp; const snd_seq_real_time_t* time=snd_seq_queue_status_get_real_time(queue_status); <BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cout&lt;&lt;"received event at queue time: "&lt;&lt;time-&gt;tv_sec&lt;&l
 t;endl;<BR>&nbsp;&nbsp; if(snd_seq_ev_is_real(ev)) cout&lt;&lt;"received event with real t
 ime
 stamp: "&lt;&lt;ev-&gt;time.tick&lt;&lt;endl;<BR>&nbsp;&nbsp; switch (ev-&gt;type) {<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SND_SEQ_EVENT_NOTEOFF: <BR>&nbsp;&nbsp;&nbsp; cout&lt;&lt;"NoteOff"&lt;&lt;endl;<BR>&nbsp;&nbsp;&nbsp; break;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </DIV>
<DIV>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SND_SEQ_EVENT_NOTEON:<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cout&lt;&lt;"NoteOn"&lt;&lt;endl;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>&nbsp;&nbsp; }<BR>&nbsp;&nbsp; snd_seq_free_event(ev);<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //input pending with fetch sequencer =0;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } while (snd_seq_event_input_pending(seq, 0) &gt; 0);<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }&nbsp; <BR>&nbsp;&nbsp;&nbsp; }<BR>&nbsp;&nbsp;&nbsp;&nbsp; snd_seq_queue_status_free(queue_status);<BR>&nbsp;&nbsp;&nbsp;&nbsp; free(&amp;pfd);<BR>&nbsp;&nbsp;&nbsp;&nbsp; return 0;<BR>&nbsp; }<BR></DIV>
<DIV>Any further ideas?</DIV>
<DIV>Thanks very much,</DIV>
<DIV>&nbsp;</DIV>
<DIV>Michael</DIV><p>
		<hr size=1>Do you Yahoo!?<br> 
Send holiday email and support a worthy cause. <a href="http://us.rd.yahoo.com/evt=29911/*http://celebrity.mail.yahoo.com/">Do good.</a>
--0-1309357562-1103675902=:39310--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/

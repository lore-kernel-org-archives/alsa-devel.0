From: Michael Geis <michaelgeis11@yahoo.com>
Subject: obtaining timestamps from sequencer events
Date: Tue, 21 Dec 2004 01:08:54 -0800 (PST)
Message-ID: <20041221090854.16216.qmail@web51904.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1922052644-1103620134=:13429"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from web51904.mail.yahoo.com (web51904.mail.yahoo.com [206.190.39.47])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with SMTP id 30CBA275
	for <alsa-devel@alsa-project.org>; Tue, 21 Dec 2004 10:09:31 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--0-1922052644-1103620134=:13429
Content-Type: text/plain; charset=us-ascii

Hello.
I wanted to add recording capability to my module to have an additional way of "importing"
musical scores. One of Dr. Mathias Nagorni's examples shows exactly how to retrieve events from an external device. I get stuck, though, when I want to retrieve timestamps from those events. Following is a minimal program that sets up a connection to an external keyboard 
(72:0 in my case) and polls events. The problem lies in the fact that the time of of the incoming events is always zero. 
 
 
#include <alsa/asoundlib.h>
#include <iostream>
using namespace std;
 int  main() {
    snd_seq_t* seq; 
    unsigned int client_type=SND_SEQ_OPEN_INPUT;  
    snd_seq_open(&seq,"default", client_type, 0);
unsigned int capability=SND_SEQ_PORT_CAP_WRITE | SND_SEQ_PORT_CAP_SUBS_WRITE;
    unsigned int port_type=SND_SEQ_PORT_TYPE_APPLICATION;
    int port_id=snd_seq_create_simple_port(seq,"writable port",capability,port_type);
    //get a queue
    //are those necessary/required with us being on the receiving end? 
    int queue = snd_seq_alloc_queue(seq);       
    snd_seq_start_queue(seq,queue,NULL);
    //fill in source and destination
    snd_seq_addr_t sender, dest;
    sender.client = 72;
    sender.port =  0;
    dest.client = snd_seq_client_id(seq); 
    dest.port = port_id;
    //add them to the subscription
    snd_seq_port_subscribe_t *subs;
    snd_seq_port_subscribe_alloca(&subs);
    snd_seq_port_subscribe_set_sender(subs, &sender);
    snd_seq_port_subscribe_set_dest(subs, &dest);
    //add the queue to the subscription
    snd_seq_port_subscribe_set_queue(subs, 1);
    snd_seq_port_subscribe_set_time_update(subs, 1);
    snd_seq_port_subscribe_set_time_real(subs, 0);
    
    //make the subscription
    snd_seq_subscribe_port(seq, subs);

    //open poll descriptor
    struct pollfd* pfd = (struct pollfd *)alloca(sizeof(struct pollfd));
    snd_seq_poll_descriptors(seq, pfd, 1, POLLIN);
 
    while (1) {
      int success=poll(pfd, 1, 100000);
      if (success > 0) {
        snd_seq_event_t *ev;
        do {          
   snd_seq_event_input(seq, &ev);    
   if(snd_seq_ev_is_real(ev)) cout<<"event at tick time "<<ev->time.tick<<endl;
   if(snd_seq_ev_is_tick(ev)) cout<<"event at real time"<<ev>time.time.tv_sec<<endl;   
   snd_seq_free_event(ev);
          //input pending with fetch sequencer =0;
        } while (snd_seq_event_input_pending(seq, 0) > 0);
      }  
    }
     free(&pfd);
     return 0;
  }

What am I missing? Does the queue setup work differently?
A second problem, which is related to playing MIDI is the following: I would like to empty
the client pool after with snd_seq_drain_output after I have filled it to a certain fraction.
What fraction is not really important, I just dont want to hardcode any number that might actually lie below the pool capacity an a bad day. 
So I gathered the ALSA function macros for obtaining pools info. When I call the function, I get 0 for all both size and space remaining of both the input and output pool. Can someone advise 
me on what needs to be done differently?
 
 int GetClientPoolSize(snd_seq_t* seq) {
    snd_seq_client_pool_t * pool;
    int success=snd_seq_client_pool_malloc(&pool);
    cout<<"did we allocate a pool.\n"<<success<<endl;
    success=snd_seq_get_client_pool(seq,pool);
    cout<<"did we find a pool.\n"<<success<<endl;
    size_t size=snd_seq_client_pool_get_output_room(pool);
    size_t in=snd_seq_client_pool_get_input_pool(pool);
    cout<<"input pool size:"<<in<<endl;
    size_t in_free=snd_seq_client_pool_get_input_free(pool);
    cout<<"input pool free:"<<in_free<<endl;
    size_t out_free=snd_seq_client_pool_get_output_free(pool);
    cout<<"output pool free:"<<out_free<<endl;
    snd_seq_client_pool_free(pool);
    return size;
} 

 
Merci beaucoup in advance.
Regards,
Michael

		
---------------------------------
Do you Yahoo!?
 Dress up your holiday email, Hollywood style. Learn more.
--0-1922052644-1103620134=:13429
Content-Type: text/html; charset=us-ascii

<DIV>Hello.</DIV>
<DIV>I wanted to add recording capability to my module to have an additional way of "importing"</DIV>
<DIV>musical scores. One of Dr. Mathias Nagorni's examples shows exactly how to retrieve events from an external device. I get stuck, though, when I want to retrieve timestamps from those events. Following is&nbsp;a minimal program that sets up a connection to an external keyboard </DIV>
<DIV>(72:0 in my case) and polls events. The problem lies in the fact&nbsp;that the time of of the incoming events is always zero. </DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;</DIV>
<DIV>#include &lt;alsa/asoundlib.h&gt;<BR>#include &lt;iostream&gt;<BR>using namespace std;</DIV>
<DIV>&nbsp;int&nbsp; main() {<BR>&nbsp;&nbsp;&nbsp; snd_seq_t* seq; <BR>&nbsp;&nbsp;&nbsp; unsigned int client_type=SND_SEQ_OPEN_INPUT;&nbsp; <BR>&nbsp;&nbsp;&nbsp; snd_seq_open(&amp;seq,"default", client_type, 0);</DIV>
<DIV>unsigned int capability=SND_SEQ_PORT_CAP_WRITE | SND_SEQ_PORT_CAP_SUBS_WRITE;<BR>&nbsp;&nbsp;&nbsp; unsigned int port_type=SND_SEQ_PORT_TYPE_APPLICATION;<BR>&nbsp;&nbsp;&nbsp; int port_id=snd_seq_create_simple_port(seq,"writable port",capability,port_type);</DIV>
<DIV>&nbsp;&nbsp;&nbsp; //get a queue<BR>&nbsp;&nbsp;&nbsp; //are those necessary/required with us being on the receiving end? <BR>&nbsp;&nbsp;&nbsp; int queue = snd_seq_alloc_queue(seq);&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>&nbsp;&nbsp;&nbsp; snd_seq_start_queue(seq,queue,NULL);</DIV>
<DIV>&nbsp;&nbsp;&nbsp; //fill in source and destination<BR>&nbsp;&nbsp;&nbsp; snd_seq_addr_t sender, dest;<BR>&nbsp;&nbsp;&nbsp; sender.client = 72;<BR>&nbsp;&nbsp;&nbsp; sender.port =&nbsp; 0;<BR>&nbsp;&nbsp;&nbsp; dest.client = snd_seq_client_id(seq); <BR>&nbsp;&nbsp;&nbsp; dest.port = port_id;<BR>&nbsp;&nbsp;&nbsp; //add them to the subscription<BR>&nbsp;&nbsp;&nbsp; snd_seq_port_subscribe_t *subs;<BR>&nbsp;&nbsp;&nbsp; snd_seq_port_subscribe_alloca(&amp;subs);<BR>&nbsp;&nbsp;&nbsp; snd_seq_port_subscribe_set_sender(subs, &amp;sender);<BR>&nbsp;&nbsp;&nbsp; snd_seq_port_subscribe_set_dest(subs, &amp;dest);<BR>&nbsp;&nbsp;&nbsp; //add the queue to the subscription<BR>&nbsp;&nbsp;&nbsp; snd_seq_port_subscribe_set_queue(subs, 1);<BR>&nbsp;&nbsp;&nbsp; snd_seq_port_subscribe_set_time_update(subs, 1);<BR>&nbsp;&nbsp;&nbsp; snd_seq_port_subscribe_set_time_real(subs, 0);<BR>&nbsp;&nbsp;&nbs
 p; <BR>&nbsp;&nbsp;&nbsp; //make the subscription<BR>&nbsp;&nbsp;&nbsp;
 snd_seq_subscribe_port(seq, subs);</DIV>
<DIV><BR>&nbsp;&nbsp;&nbsp; //open poll descriptor<BR>&nbsp;&nbsp;&nbsp; struct pollfd* pfd = (struct pollfd *)alloca(sizeof(struct pollfd));<BR>&nbsp;&nbsp;&nbsp; snd_seq_poll_descriptors(seq, pfd, 1, POLLIN);<BR>&nbsp;<BR>&nbsp;&nbsp;&nbsp; while (1) {<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int success=poll(pfd, 1, 100000);<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (success &gt; 0) {<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; snd_seq_event_t *ev;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; do {&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>&nbsp;&nbsp; snd_seq_event_input(seq, &amp;ev);&nbsp;&nbsp;&nbsp; <BR>&nbsp;&nbsp; if(snd_seq_ev_is_real(ev)) cout&lt;&lt;"event at tick time "&lt;&lt;ev-&gt;time.tick&lt;&lt;endl;<BR>&nbsp;&nbsp; if(snd_seq_ev_is_tick(ev)) cout&lt;&lt;"event at real time"&lt;&lt;ev&gt;time.time.tv_sec&lt;&lt;endl;&nbsp;&nbsp; <BR>&nbsp;&nbsp; snd_seq_free_eve
 nt(ev);<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //input pending with fet
 ch
 sequencer =0;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } while (snd_seq_event_input_pending(seq, 0) &gt; 0);<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }&nbsp; <BR>&nbsp;&nbsp;&nbsp; }<BR>&nbsp;&nbsp;&nbsp;&nbsp; free(&amp;pfd);<BR>&nbsp;&nbsp;&nbsp;&nbsp; return 0;<BR>&nbsp; }<BR></DIV>
<DIV>What am I missing? Does the queue setup work differently?</DIV>
<DIV>A second problem, which is related to playing MIDI is the following: I would like to empty</DIV>
<DIV>the client pool after with snd_seq_drain_output after I have filled it to a certain fraction.</DIV>
<DIV>What fraction is not really important, I just dont want to hardcode any number that might actually lie below the pool capacity an a bad day. </DIV>
<DIV>So I gathered the ALSA function macros for obtaining pools info. When I call the function, I get 0 for all both size and space remaining of both the input and output pool. Can someone advise </DIV>
<DIV>me on what needs to be done differently?</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;int GetClientPoolSize(snd_seq_t* seq) {<BR>&nbsp;&nbsp;&nbsp; snd_seq_client_pool_t * pool;<BR>&nbsp;&nbsp;&nbsp; int success=snd_seq_client_pool_malloc(&amp;pool);<BR>&nbsp;&nbsp;&nbsp; cout&lt;&lt;"did we allocate a pool.\n"&lt;&lt;success&lt;&lt;endl;<BR>&nbsp;&nbsp;&nbsp; success=snd_seq_get_client_pool(seq,pool);<BR>&nbsp;&nbsp;&nbsp; cout&lt;&lt;"did we find a pool.\n"&lt;&lt;success&lt;&lt;endl;<BR>&nbsp;&nbsp;&nbsp; size_t size=snd_seq_client_pool_get_output_room(pool);<BR>&nbsp;&nbsp;&nbsp; size_t in=snd_seq_client_pool_get_input_pool(pool);<BR>&nbsp;&nbsp;&nbsp; cout&lt;&lt;"input pool size:"&lt;&lt;in&lt;&lt;endl;<BR>&nbsp;&nbsp;&nbsp; size_t in_free=snd_seq_client_pool_get_input_free(pool);<BR>&nbsp;&nbsp;&nbsp; cout&lt;&lt;"input pool free:"&lt;&lt;in_free&lt;&lt;endl;<BR>&nbsp;&nbsp;&nbsp; size_t out_free=snd_seq_client_pool_get_output_free(pool);<BR>&nbsp;&nbsp;
 &nbsp; cout&lt;&lt;"output pool free:"&lt;&lt;out_free&lt;&lt;endl;<BR>&nbsp;&nbsp;&nbsp;
 snd_seq_client_pool_free(pool);<BR>&nbsp;&nbsp;&nbsp; return size;<BR>}
<DIV>&nbsp;</DIV></DIV>
<DIV>&nbsp;</DIV>
<DIV>Merci beaucoup in advance.</DIV>
<DIV>Regards,</DIV>
<DIV>Michael</DIV><p>
		<hr size=1>Do you Yahoo!?<br> 
Dress up your holiday email, Hollywood style. <a href="http://us.rd.yahoo.com/evt=29909/*http://celebrity.mail.yahoo.com">Learn more.</a>
--0-1922052644-1103620134=:13429--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/

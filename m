From: Benno Senoner <sbenno@gardena.net>
Subject: Re: Event Based time synchronization with ALSA
Date: Mon, 17 Jan 2005 17:45:03 +0100
Message-ID: <41EBEB8F.9030009@gardena.net>
References: <41EB9874.4060407@hypersonic.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <41EB9874.4060407@hypersonic.it>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paolo Losi <p.losi@hypersonic.it>
Cc: alsa-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

I suggest you to do the following:

have a thread that does audio I/O and write/read the
audio data to 2 ringbuffers using eg frame size of about 10msec.
10msec = 441 samples, thus I'd choose 512 samples (alsa period sizes 
must be power of 2).

for example for the RTP sending (capturing audio from the alsa device 
and send a RTP packet).

you could for example do:

short audiobu[512];

while(1) {

 capture_audio_from_alsa(audiobuf) // (blocking read,  512 samples)

 write_to_ringbuffer(audiobuf, 512); // write the 512 samples to the 
ringbuffer

 space = get_ringbuffer_read_space(); // now we get how many samples are 
accumulated in the ringbuffer

 if(space >= 882)  {   // ( 882 = 20msec of samples at 44100Hz).
    ringbufferdata = read_from_ringbuffer(882);
    send_rtp_packet(ringbufferdata);
  }


}

The above routine has the advantage that you can use any kind of 
periodsize (fragment size) in ALSA
and the send_rtp packet() always gets 20msec worth of data.
But you must ensure that the ALSA period size must be <20msec , 
otherwise too much jitter is introduced.
eg if I have a periodsize of 100msec , the ALSA blocking read() will 
block until 100msec worth of audio are available

and then the send_rtp_packet() would only fetch 20msec of audio from the 
ringbuffer and the thread would sleep
for 100msec again and the ringbuffer would eventually fill up leading to 
garbled RTP audio (you hear only
every 5th packet).
You could wrap  space = ...  ; if(space >= 882) in a while(space >= 882) 
loop but that would cause to send
out fast bursts of 20msec packets each 100msec probably overrunning or 
putting strain on the jitter buffer
on the receiving side of the other SIP phone.

So far for the sending side of your SIP phone.

The receiving side is more complex since RTP packets (which are based on 
UDP) could come out of order
so you need a jitter buffer (sliding window) which reorders the packets, 
discards late packets etc.
Or if you assume that out of order packets are very rare you could 
ignore the case and discard the packet.
and simply insert the RTP audio data to the end of a receiving 
ringbuffer (in an analogous way like the the code
above) and have the audio thread writing an audio frames to the ALSA 
device as soon as enough packets are here.
The problem of the internet is that it is not easy to estimate the 
latency in advance (eg when you do a oversea
SIP call) so you have to use an adaptive algorithm which measures jitter 
between packets
(eg instead of each 20msec, some packets could arrive after 100msec but 
then 5 packets in a burst etc), and thus
adapting the size of the ringbufffer dynamically based on the latency 
measurements.
This will give you the lowest possible latency with the best call quality.
Perhaps if you look at the code of some of the opensource soft phones 
you can get an idea what's the best method
to implement this.

ciao,
Benno









Paolo Losi wrote:

> Hi all,
>     I'd like to develop a sip phone using alsa...
>
> All the app is going to be event based (no_blocking io, poll).
>
> One of the issues is how to read 20ms sample periods
> to build an rtp packet
>
> What I'd like to understand is if I can rely on interrupts (poll
> read data available event) by HW in order to get accurate 50HZ
> poll frequency or I must rely on poll timeout instead...
>
> My goal is (as always :-) ) to reduce as much as I can latency...
>
> In the case poll events would be enough what would be the
> relevant sw_params api's?
>
>     Thank you very much
>
>     PL
>
>
> -------------------------------------------------------
> The SF.Net email is sponsored by: Beat the post-holiday blues
> Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
> It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
>



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt

From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: intel8x0.c
Date: Tue, 30 Mar 2004 20:16:33 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <4069C791.2010503@superbug.demon.co.uk>
References: <20040330145655.64254.qmail@web25102.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040330145655.64254.qmail@web25102.mail.ukl.yahoo.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Brian Furey <brianmfurey@yahoo.co.uk>
Cc: ALSA LIST <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Brian Furey wrote:
> Hi all,
>   I have an intel810 onboard soundcard.I am using the
> alsa driver with a VoIP session.
>   The intel8x0.c file has a minimum period byte size
> of 32 bytes with the minimum no. of periods being
> 1.The min and max rate is set to 48k. 
> 
> How can I find out what actual(runtime) size period
> the alsa driver is dealing with? 
> 
> Does it use the minimum size as the period size?
> 
>  Brian.
> 

Brian, I am working on a VoIP setup. I am updating the asterisk alsa 
console driver so that it actually works! The current driver is stuck 
round about alsa api 0.5.x
The period size that the sound card is actually using does not really 
matter, if just effects latency. The bigger the period size, the higher 
the latency.
Just set the period size to the smallest the sound card can do, and then 
just read and write to it.
I found that PLAYBACK and CAPTURE directions can have different period 
sizes, so it is better to open separate handles for playback and capture.
In the config setup, you set the buffer and period sizes, and before you 
set them, you can retrieve the current min/max period and buffer sizes.
For playback, it is best to have a certain minimum buffer being full 
most of the time, due to network jitter, and this buffer can act as the 
jitter buffer. The actual size of this is probably best found out from 
trial and error (I have not finished testing this bit yet).
For capture, just poll for input, and then read whatever is in the 
capture buffer and transmit it. You can experiment with different 
methods of early buffer reads, but again, I have not finished testing 
with that, so I can't give you any definite answers.

Another thing to test with could be sampling and playback at 48k.
Most sound cards work at 48k, and this would reduce the period_time. 
(period_size stays the same, but as one is using a higher rate, the 
period_time decreases, and thus latency.) The problems with that is that 
most VoIP is at 8k, so some resampling is required.

Cheers
James


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click

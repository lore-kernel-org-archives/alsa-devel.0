From: =?iso-8859-1?q?Brian=20Furey?= <brianmfurey@yahoo.co.uk>
Subject: Re: intel8x0.c
Date: Wed, 31 Mar 2004 10:46:16 +0100 (BST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040331094616.201.qmail@web25107.mail.ukl.yahoo.com>
References: <4069C791.2010503@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <4069C791.2010503@superbug.demon.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.demon.co.uk>, ALSA LIST <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Thanks James,
   i'm using the GSM-06.10 codec with my VoIP
application.The frame rate is 160 timestamp units or
20 millisecond frames.4 frames are added to a packet
and transmitted. Packets are transmitted at alternate
intervals of 64 and 96 milliseconds. This is due to
the soundcard driver and the period sizes being read
into the buffer.Can the period size the driver is
capturing from the soundcard and putting into the
sending buffer change during execution of a VoIP
session or is it fixed.Given that I have not changed
it, what is the default period size for the ALSA
driver?
I'm basically trying to find out the reason packets
are transmitted at alternate intervals of 64 and 96
milliseconds....and the runtime period size is the key
 
help appreciated,
brian.
--- James Courtier-Dutton <James@superbug.demon.co.uk>
wrote: > Brian Furey wrote:
> > Hi all,
> >   I have an intel810 onboard soundcard.I am using
> the
> > alsa driver with a VoIP session.
> >   The intel8x0.c file has a minimum period byte
> size
> > of 32 bytes with the minimum no. of periods being
> > 1.The min and max rate is set to 48k. 
> > 
> > How can I find out what actual(runtime) size
> period
> > the alsa driver is dealing with? 
> > 
> > Does it use the minimum size as the period size?
> > 
> >  Brian.
> > 
> 
> Brian, I am working on a VoIP setup. I am updating
> the asterisk alsa 
> console driver so that it actually works! The
> current driver is stuck 
> round about alsa api 0.5.x
> The period size that the sound card is actually
> using does not really 
> matter, if just effects latency. The bigger the
> period size, the higher 
> the latency.
> Just set the period size to the smallest the sound
> card can do, and then 
> just read and write to it.
> I found that PLAYBACK and CAPTURE directions can
> have different period 
> sizes, so it is better to open separate handles for
> playback and capture.
> In the config setup, you set the buffer and period
> sizes, and before you 
> set them, you can retrieve the current min/max
> period and buffer sizes.
> For playback, it is best to have a certain minimum
> buffer being full 
> most of the time, due to network jitter, and this
> buffer can act as the 
> jitter buffer. The actual size of this is probably
> best found out from 
> trial and error (I have not finished testing this
> bit yet).
> For capture, just poll for input, and then read
> whatever is in the 
> capture buffer and transmit it. You can experiment
> with different 
> methods of early buffer reads, but again, I have not
> finished testing 
> with that, so I can't give you any definite answers.
> 
> Another thing to test with could be sampling and
> playback at 48k.
> Most sound cards work at 48k, and this would reduce
> the period_time. 
> (period_size stays the same, but as one is using a
> higher rate, the 
> period_time decreases, and thus latency.) The
> problems with that is that 
> most VoIP is at 8k, so some resampling is required.
> 
> Cheers
> James 


	
	
		
___________________________________________________________
WIN FREE WORLDWIDE FLIGHTS - nominate a cafe in the Yahoo! Mail Internet Cafe Awards  www.yahoo.co.uk/internetcafes 


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click

From: =?iso-8859-1?q?Brian=20Furey?= <brianmfurey@yahoo.co.uk>
Subject: Re: alsa driver data rates
Date: Thu, 15 Apr 2004 12:27:09 +0100 (BST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040415112709.13194.qmail@web25103.mail.ukl.yahoo.com>
References: <4069C791.2010503@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1787234427-1082028429=:12969"
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

--0-1787234427-1082028429=:12969
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi James,
Im asking you becuae looking thru the archives you asked a similar question a long time ago.

 i'm using an open source VoIP application with the
alsa driver. My card is the onboard intel8x0.

   My problem is figuring out the patterns I am
getting with the alsa driver when transmitting
packets.
For instance when I use the GSM codec with a packets
size of 80 msecs and 132 bytes, packets are
transmitted at alternate intervals of 64/96 msecs.
When i use G.711 packets of 240 bytes are transmitted
every 32 msecs with an extra packet every 15 pkts.
With G.711 it is obvious that 256 bytes are added to driver sending buffer every 32 msecs.However this does not match for GSM because it needs only 132 bytes every 64/96 msecs.
Can the driver change the amount of data it gets from the soundcard to suit the codec?
Help appreciated,

Brian.



James Courtier-Dutton <James@superbug.demon.co.uk> wrote:
Brian Furey wrote:
> Hi all,
> I have an intel810 onboard soundcard.I am using the
> alsa driver with a VoIP session.
> The intel8x0.c file has a minimum period byte size
> of 32 bytes with the minimum no. of periods being
> 1.The min and max rate is set to 48k. 
> 
> How can I find out what actual(runtime) size period
> the alsa driver is dealing with? 
> 
> Does it use the minimum size as the period size?
> 
> Brian.
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
_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
		
---------------------------------
  Yahoo! Messenger - Communicate instantly..."Ping" your friends today! Download Messenger Now
--0-1787234427-1082028429=:12969
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<DIV>Hi James,</DIV>
<DIV>Im asking you becuae looking thru the archives you asked a similar question a long time ago.<BR><BR>&nbsp;i'm using an open source VoIP application with the<BR>alsa driver. My card is the onboard intel8x0.<BR></DIV>
<DIV>&nbsp;&nbsp; My problem is figuring out the patterns I am<BR>getting with the alsa driver when transmitting<BR>packets.<BR>For instance when I use the GSM codec with a packets<BR>size of 80 msecs and 132 bytes, packets are<BR>transmitted at alternate intervals of 64/96 msecs.<BR>When i use G.711 packets of 240 bytes are transmitted</DIV>
<DIV>every 32 msecs with an extra packet every 15 pkts.</DIV>
<DIV>With G.711 it is obvious that 256 bytes are added to driver sending buffer every 32 msecs.However this does not match for GSM because it needs only 132 bytes every 64/96 msecs.</DIV>
<DIV>Can the driver change the amount of data it gets from the soundcard to suit the codec?</DIV>
<DIV>Help appreciated,<BR><BR>Brian.<BR><BR><BR><BR><B><I>James Courtier-Dutton &lt;James@superbug.demon.co.uk&gt;</I></B> wrote:</DIV>
<BLOCKQUOTE class=replbq style="PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #1010ff 2px solid">Brian Furey wrote:<BR>&gt; Hi all,<BR>&gt; I have an intel810 onboard soundcard.I am using the<BR>&gt; alsa driver with a VoIP session.<BR>&gt; The intel8x0.c file has a minimum period byte size<BR>&gt; of 32 bytes with the minimum no. of periods being<BR>&gt; 1.The min and max rate is set to 48k. <BR>&gt; <BR>&gt; How can I find out what actual(runtime) size period<BR>&gt; the alsa driver is dealing with? <BR>&gt; <BR>&gt; Does it use the minimum size as the period size?<BR>&gt; <BR>&gt; Brian.<BR>&gt; <BR><BR>Brian, I am working on a VoIP setup. I am updating the asterisk alsa <BR>console driver so that it actually works! The current driver is stuck <BR>round about alsa api 0.5.x<BR>The period size that the sound card is actually using does not really <BR>matter, if just effects latency
 . The bigger the period size, the higher <BR>the latency.<BR>Just set the period size to t
 he
 smallest the sound card can do, and then <BR>just read and write to it.<BR>I found that PLAYBACK and CAPTURE directions can have different period <BR>sizes, so it is better to open separate handles for playback and capture.<BR>In the config setup, you set the buffer and period sizes, and before you <BR>set them, you can retrieve the current min/max period and buffer sizes.<BR>For playback, it is best to have a certain minimum buffer being full <BR>most of the time, due to network jitter, and this buffer can act as the <BR>jitter buffer. The actual size of this is probably best found out from <BR>trial and error (I have not finished testing this bit yet).<BR>For capture, just poll for input, and then read whatever is in the <BR>capture buffer and transmit it. You can experiment with different <BR>methods of early buffer reads, but again, I have not finished testing <BR>with that, so I ca
 n't give you any definite answers.<BR><BR>Another thing to test with could be sampling and
 playback at 48k.<BR>Most sound cards work at 48k, and this would reduce the period_time. <BR>(period_size stays the same, but as one is using a higher rate, the <BR>period_time decreases, and thus latency.) The problems with that is that <BR>most VoIP is at 8k, so some resampling is required.<BR><BR>Cheers<BR>James<BR><BR><BR>-------------------------------------------------------<BR>This SF.Net email is sponsored by: IBM Linux Tutorials<BR>Free Linux tutorial presented by Daniel Robbins, President and CEO of<BR>GenToo technologies. Learn everything from fundamentals to system<BR>administration.http://ads.osdn.com/?ad_id=1470&amp;alloc_id=3638&amp;op=click<BR>_______________________________________________<BR>Alsa-devel mailing list<BR>Alsa-devel@lists.sourceforge.net<BR>https://lists.sourceforge.net/lists/listinfo/alsa-devel</BLOCKQUOTE><p>
		<hr size=1><font face="Arial" size="2"> <a href="http://uk.rd.yahoo.com/mail/tagline_messenger/*http://uk.messenger.yahoo.com"><b> 
Yahoo! Messenger</b></a> - Communicate instantly..."Ping" your friends 
today! <a href="http://uk.rd.yahoo.com/mail/tagline_messenger/*http://uk.messenger.yahoo.com/download/index.html"><strong>Download Messenger Now</strong></a></font>
--0-1787234427-1082028429=:12969--


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click

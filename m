From: =?iso-8859-1?q?Brian=20Furey?= <brianmfurey@yahoo.co.uk>
Subject: Re: alsa driver
Date: Tue, 6 Apr 2004 17:20:03 +0100 (BST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040406162003.27610.qmail@web25109.mail.ukl.yahoo.com>
References: <Pine.LNX.4.58.0404061657590.29768@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1029191398-1081268403=:27180"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0404061657590.29768@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>, ALSA LIST <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

--0-1029191398-1081268403=:27180
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Jaroslav,
Busy system cant explain something as consequent as this.
When the packet size being transmitted is 30 msecs(240bytes) or 32 msecs(240bytes), the OpenH323 app sends packets every 32 msecs.
 
When the packet size is 80 msecs(132 bytes), the OpenH323 app sends packets at alternate intervals of 64 msecs and 96 msecs.Both are multiples of 32 msecs.
Surely it's to do with the period size being added to the driver sending buffer. The thing is I have got all the info about the period size,no of periods ..etc but it's not adding up yet.
 
Brian.

Jaroslav Kysela <perex@suse.cz> wrote:
On Tue, 6 Apr 2004, Brian Furey wrote:

> Hi all,
> i'm running the alsa-driver-1.0.0. Im using it with
> the OpenH323 application. Packets are transmitted or
> received in 32 millisecond intervals or multiples of
> 32 millisecond intervals.
> For example using the G711 codec, packets are
> transmitted every 32 milliseconds. For the GSM-06.10
> codec, packets are transmitted at alternate intervals
> of 64 milliseconds or 96 milliseconds.
> Why is this?

Busy system?

Jaroslav

-----
Jaroslav Kysela 

Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


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
--0-1029191398-1081268403=:27180
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<DIV>Jaroslav,</DIV>
<DIV>Busy system cant explain something as consequent as this.</DIV>
<DIV>When the packet size being transmitted is 30 msecs(240bytes) or 32 msecs(240bytes), the OpenH323 app sends packets every 32 msecs.</DIV>
<DIV>&nbsp;</DIV>
<DIV>When the packet size is 80 msecs(132 bytes), the OpenH323 app sends packets at alternate intervals of 64 msecs and 96 msecs.Both are multiples of 32 msecs.</DIV>
<DIV>Surely it's to do with the period size being added to the driver sending buffer. The thing is I have got all the info about the period size,no of periods ..etc but it's not adding up yet.</DIV>
<DIV>&nbsp;</DIV>
<DIV>Brian.<BR><BR><B><I>Jaroslav Kysela &lt;perex@suse.cz&gt;</I></B> wrote:</DIV>
<BLOCKQUOTE class=replbq style="PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #1010ff 2px solid">On Tue, 6 Apr 2004, Brian Furey wrote:<BR><BR>&gt; Hi all,<BR>&gt; i'm running the alsa-driver-1.0.0. Im using it with<BR>&gt; the OpenH323 application. Packets are transmitted or<BR>&gt; received in 32 millisecond intervals or multiples of<BR>&gt; 32 millisecond intervals.<BR>&gt; For example using the G711 codec, packets are<BR>&gt; transmitted every 32 milliseconds. For the GSM-06.10<BR>&gt; codec, packets are transmitted at alternate intervals<BR>&gt; of 64 milliseconds or 96 milliseconds.<BR>&gt; Why is this?<BR><BR>Busy system?<BR><BR>Jaroslav<BR><BR>-----<BR>Jaroslav Kysela <PEREX@SUSE.CZ><BR>Linux Kernel Sound Maintainer<BR>ALSA Project, SuSE Labs<BR><BR><BR>-------------------------------------------------------<BR>This SF.Net email is sponsored by: IBM Linux Tutorials<BR>Free Li
 nux tutorial presented by Daniel Robbins, President and CEO of<BR>GenToo technologies. Learn
 everything from fundamentals to system<BR>administration.http://ads.osdn.com/?ad_id=1470&amp;alloc_id=3638&amp;op=click<BR>_______________________________________________<BR>Alsa-devel mailing list<BR>Alsa-devel@lists.sourceforge.net<BR>https://lists.sourceforge.net/lists/listinfo/alsa-devel</BLOCKQUOTE><p>
		<hr size=1><font face="Arial" size="2"> <a href="http://uk.rd.yahoo.com/mail/tagline_messenger/*http://uk.messenger.yahoo.com"><b> 
Yahoo! Messenger</b></a> - Communicate instantly..."Ping" your friends 
today! <a href="http://uk.rd.yahoo.com/mail/tagline_messenger/*http://uk.messenger.yahoo.com/download/index.html"><strong>Download Messenger Now</strong></a></font>
--0-1029191398-1081268403=:27180--


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click

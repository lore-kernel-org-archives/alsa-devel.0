From: =?iso-8859-1?q?Brian=20Furey?= <brianmfurey@yahoo.co.uk>
Subject: RE: Current Hardware Parameter Settings
Date: Thu, 25 Mar 2004 16:20:09 +0000 (GMT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040325162009.54160.qmail@web25101.mail.ukl.yahoo.com>
References: <XFMail.20040325122452.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1751077038-1080231609=:53453"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <XFMail.20040325122452.pochini@shiny.it>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ALSA LIST <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

--0-1751077038-1080231609=:53453
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Thanks Giuliano,
 
How can I get a dump of the current hardware configuration space?I have the ALSA driver 1.0.0 installed on my Redhat 9 Machine.
 
Brian.
Giuliano Pochini <pochini@shiny.it> wrote:

On 24-Mar-2004 Brian Furey wrote:
> Hi all,
> im using the ALSA driver 1.0.0 on two linux machines that connect a
> voice-over-ip session. I need to know the minimum fragment size that
> the alsa driver can take from the soundcard and place in the
> sending/receiving buffer. Does it depend on the speed that the
> soundcard is operating at?

It may depend on any thing. Set buffer size and period
size with one of these and use the value they return:

snd_pcm_hw_params_set_buffer_size_near()
snd_pcm_hw_params_set_period_size_near()
snd_pcm_hw_params_set_buffer_time_near()
snd_pcm_hw_params_set_period_time_near()

Look here for more infos:
http://www.alsa-project.org/alsa-doc/alsa-lib/group___p_c_m___h_w___params.html


--
Giuliano.


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
--0-1751077038-1080231609=:53453
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<DIV>
<DIV>Thanks Giuliano,</DIV>
<DIV>&nbsp;</DIV>
<DIV>How can I get a dump of the current hardware configuration space?I have the ALSA driver 1.0.0 installed on my Redhat 9 Machine.</DIV>
<DIV>&nbsp;</DIV>
<DIV>Brian.<BR><B><I>Giuliano Pochini &lt;pochini@shiny.it&gt;</I></B> wrote:</DIV>
<BLOCKQUOTE class=replbq style="PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #1010ff 2px solid"><BR>On 24-Mar-2004 Brian Furey wrote:<BR>&gt; Hi all,<BR>&gt; im using the ALSA driver 1.0.0 on two linux machines that connect a<BR>&gt; voice-over-ip session. I need to know the minimum fragment size that<BR>&gt; the alsa driver can take from the soundcard and place in the<BR>&gt; sending/receiving buffer. Does it depend on the speed that the<BR>&gt; soundcard is operating at?<BR><BR>It may depend on any thing. Set buffer size and period<BR>size with one of these and use the value they return:<BR><BR>snd_pcm_hw_params_set_buffer_size_near()<BR>snd_pcm_hw_params_set_period_size_near()<BR>snd_pcm_hw_params_set_buffer_time_near()<BR>snd_pcm_hw_params_set_period_time_near()<BR><BR>Look here for more
 infos:<BR>http://www.alsa-project.org/alsa-doc/alsa-lib/group___p_c_m___h_w___params.html<BR><BR><BR>--<BR>Giuliano.<BR><BR><BR>-------------------------------------------------------<BR>This SF.Net email is sponsored by: IBM Linux Tutorials<BR>Free Linux tutorial presented by Daniel Robbins, President and CEO of<BR>GenToo technologies. Learn everything from fundamentals to system<BR>administration.http://ads.osdn.com/?ad_id=1470&amp;alloc_id=3638&amp;op=click<BR>_______________________________________________<BR>Alsa-devel mailing list<BR>Alsa-devel@lists.sourceforge.net<BR>https://lists.sourceforge.net/lists/listinfo/alsa-devel</BLOCKQUOTE></DIV><p>
		<hr size=1><font face="Arial" size="2"> <a href="http://uk.rd.yahoo.com/mail/tagline_messenger/*http://uk.messenger.yahoo.com"><b> 
Yahoo! Messenger</b></a> - Communicate instantly..."Ping" your friends 
today! <a href="http://uk.rd.yahoo.com/mail/tagline_messenger/*http://uk.messenger.yahoo.com/download/index.html"><strong>Download Messenger Now</strong></a></font>
--0-1751077038-1080231609=:53453--


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click

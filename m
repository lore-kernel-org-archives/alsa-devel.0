From: =?iso-8859-1?q?Brian=20Furey?= <brianmfurey@yahoo.co.uk>
Subject: Re: PCM Params
Date: Thu, 27 May 2004 13:07:20 +0100 (BST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040527120720.6778.qmail@web25107.mail.ukl.yahoo.com>
References: <200405251619.i4PGJ1xq003849@dhin.linuxaudiosystems.com>
Mime-Version: 1.0
Content-Type: multipart/alternative; boundary="0-2128404625-1085659640=:6569"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200405251619.i4PGJ1xq003849@dhin.linuxaudiosystems.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>, ALSA LIST <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

--0-2128404625-1085659640=:6569
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

ok paul i had another look at the driver playback/capture tutorials. I have one question.Do applications initialize and use a pcm_handle of the alsa driver when they begin interaction with it?Surely not....
 
I thought that the driver would work totally independently of my VoIP and this is why I asked the question is it possible to change driver parameters directly. 
 
Brian.


Paul Davis <paul@linuxaudiosystems.com> wrote:
>Im running OpenH323 a voice over ip application.What I

were you asking about this on alsa-devel a couple of weeks ago?

>have found out from using it is that the alsa driver
>always puts 32 msecs(256 bytes) of data into the
>sender buffer, or takes the same amount from the
>receiver buffer.
>32 msecs is driver default if it's not set by the
>application? I thought if i change the relevant
>default params in alsa-driver/alsa-kernel/ and
>recompile, it wud do the trick. 
>
>...Instead i should include this function call to set
>the driver period..snd_pcm_hw_params_set_period_size()
>within my OpenH323 app with relevant header files???

yes, although i am not sure you understand enough about how this all
works. and i am pretty sure i don't have time to explain. did you read
either of the tutorials on the ALSA site for programmers?
		
---------------------------------
  Yahoo! Messenger - Communicate instantly..."Ping" your friends today! Download Messenger Now
--0-2128404625-1085659640=:6569
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<DIV>ok paul i had another look at the driver playback/capture tutorials. I have one question.Do applications&nbsp;initialize and use a pcm_handle of the alsa driver when they begin interaction with it?Surely not....</DIV>
<DIV>&nbsp;</DIV>
<DIV>I thought that the driver would work totally independently of my VoIP and this is why I asked the question is it possible to change driver parameters directly.&nbsp;</DIV>
<DIV>&nbsp;</DIV>
<DIV>Brian.</DIV>
<DIV><BR><BR><B><I>Paul Davis &lt;paul@linuxaudiosystems.com&gt;</I></B> wrote:</DIV>
<BLOCKQUOTE class=replbq style="PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #1010ff 2px solid">&gt;Im running OpenH323 a voice over ip application.What I<BR><BR>were you asking about this on alsa-devel a couple of weeks ago?<BR><BR>&gt;have found out from using it is that the alsa driver<BR>&gt;always puts 32 msecs(256 bytes) of data into the<BR>&gt;sender buffer, or takes the same amount from the<BR>&gt;receiver buffer.<BR>&gt;32 msecs is driver default if it's not set by the<BR>&gt;application? I thought if i change the relevant<BR>&gt;default params in alsa-driver/alsa-kernel/ and<BR>&gt;recompile, it wud do the trick. <BR>&gt;<BR>&gt;...Instead i should include this function call to set<BR>&gt;the driver period..snd_pcm_hw_params_set_period_size()<BR>&gt;within my OpenH323 app with relevant header files???<BR><BR>yes, although i am not sure you understand enough about how this 
 all<BR>works. and i am pretty sure i don't have time to explain. did you read<BR>either of the
 tutorials on the ALSA site for programmers?</BLOCKQUOTE><p>
		<hr size=1><font face="Arial" size="2"> <a href="http://uk.rd.yahoo.com/mail/tagline_messenger/*http://uk.messenger.yahoo.com"><b> 
Yahoo! Messenger</b></a> - Communicate instantly..."Ping" your friends 
today! <a href="http://uk.rd.yahoo.com/mail/tagline_messenger/*http://uk.messenger.yahoo.com/download/index.html"><strong>Download Messenger Now</strong></a></font>
--0-2128404625-1085659640=:6569--


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click

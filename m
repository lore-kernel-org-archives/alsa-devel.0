From: Michael Geis <michaelgeis11@yahoo.com>
Subject: memory management
Date: Mon, 13 Dec 2004 20:52:17 -0800 (PST)
Message-ID: <20041214045217.56186.qmail@web51905.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1794161532-1102999937=:55471"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

--0-1794161532-1102999937=:55471
Content-Type: text/plain; charset=us-ascii

I am not really familiar with memory mangement and would like to ensure I am getting memory leaks in my ALSA app. There are snd_seq_...._free functions for most of the data types I am using. For a few of them, however, I could not find a function that frees the 
structure and wanted to ask whether they require to be freed and I just missed the appropriate 
function when looking through the header files.
The data types in question are:
snd_seq_real_time_t , snd_seq_tick_time_t, snd_seq_addr_t, snd_seq_port_subscribe_t
 
Could someone comment on whether the memory of variables of these data types needs to 
be freed?
Thanks a lot in advance,
 
Michael

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
--0-1794161532-1102999937=:55471
Content-Type: text/html; charset=us-ascii

<DIV>I am not really familiar with memory mangement and would like to ensure I am getting memory leaks in my ALSA app. There are snd_seq_...._free functions for most of the data types I&nbsp;am&nbsp;using. For a few of&nbsp;them, however, I could not find a function that frees the </DIV>
<DIV>structure and wanted to ask whether they require to be freed and I just missed the appropriate </DIV>
<DIV>function when looking through the header files.</DIV>
<DIV>The data types in question are:</DIV>
<DIV>snd_seq_real_time_t , snd_seq_tick_time_t, snd_seq_addr_t, snd_seq_port_subscribe_t</DIV>
<DIV>&nbsp;</DIV>
<DIV>Could someone comment on whether the memory of variables of these data types needs to </DIV>
<DIV>be freed?</DIV>
<DIV>Thanks a lot in advance,</DIV>
<DIV>&nbsp;</DIV>
<DIV>Michael</DIV><p>__________________________________________________<br>Do You Yahoo!?<br>Tired of spam?  Yahoo! Mail has the best spam protection around <br>http://mail.yahoo.com 
--0-1794161532-1102999937=:55471--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/

From: Michael Geis <michaelgeis11@yahoo.com>
Subject: Sending divided Sysex events to the ALSA sequencer
Date: Mon, 13 Dec 2004 22:34:50 -0800 (PST)
Message-ID: <20041214063450.16768.qmail@web51901.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1536364231-1103006090=:15346"
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

--0-1536364231-1103006090=:15346
Content-Type: text/plain; charset=us-ascii

I am now going over parts of the midi playing program I had left out initially, e.g. divided 
Sysex events. The ALSA docu says Sysex events must be sent
with a beginning 0xF0 and a terminating 0xF7. Does that imply that divided Sysex 
messages must be converted to a single Sysex message and then be sent to the ALSA sequencer at once (otherwise they would not possess a terminating 0xF7)? 
Or is there still a way to send them to the sequencer as is, i.e. with none but the last of the messages having a terminating 0x0F.
 
Thanks in advance,
Michael 
 

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
--0-1536364231-1103006090=:15346
Content-Type: text/html; charset=us-ascii

<DIV>I am now going over parts of the midi playing program I had left out initially, e.g. divided </DIV>
<DIV>Sysex events. The ALSA docu says&nbsp;Sysex events must be sent</DIV>
<DIV>with a beginning 0xF0 and a terminating 0xF7. Does that imply that divided Sysex </DIV>
<DIV>messages must be converted to a single Sysex message and then be sent to the ALSA sequencer at once (otherwise they would not possess a terminating 0xF7)? </DIV>
<DIV>Or is there still a way to send them to the sequencer as is, i.e. with none but the last of the messages having a terminating 0x0F.</DIV>
<DIV>&nbsp;</DIV>
<DIV>Thanks in advance,</DIV>
<DIV>Michael&nbsp;</DIV>
<DIV>&nbsp;</DIV><p>__________________________________________________<br>Do You Yahoo!?<br>Tired of spam?  Yahoo! Mail has the best spam protection around <br>http://mail.yahoo.com 
--0-1536364231-1103006090=:15346--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/

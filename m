From: Michael Geis <michaelgeis11@yahoo.com>
Subject: alsa sequencer: How to eliminate choking
Date: Mon, 6 Dec 2004 19:08:35 -0800 (PST)
Message-ID: <20041207030836.76199.qmail@web51904.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1813504093-1102388915=:75808"
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

--0-1813504093-1102388915=:75808
Content-Type: text/plain; charset=us-ascii

Hello, everyone!
Before describing my problem, I would like to comment on the great degree of transparancy 
of the ALSA library. Sure enough, it took a while to get used to its wealth, but the example 
programs + the former posts on this list give great indications as to how to make use of
this wealth.
 
I am using ALSA to stream pieces of music contained in a class called score to an ALSA client with a port of type MIDI_GENERIC. One way to construct a score is from a Midi file, so I can compare the sound of playing the Midi file with pmidi with the result of streaming a score constructed from that midifile to the alsa sequencer.
The streaming works for pieces that dont contain many parts, but when many notes are played simultaneously (e.g. Beethoven's 5 Symphony, Movement 1), the order of notes gets mixed up and the output devices choke (same problem for a keyboard and with timidity). However, the midifile I made the score from plays nicely with pmidi.
I am pretty convinced that the problem is not queue overflow, since I flush queues every two seconds.
 
Does someone have an idea where the choking could come from and what measures can be used to get rid of it?
 
There are two more items I have been wondering about that dont appear worth to put into a post of their own.
Is there a Macro that tells me whether an ALSA sequencer client is an internal or external device? Thus, a user could choose what kind of device to play to (without having to specify client and port). 
Second, is ALSA used purely on linux or also on OS X or BSD?
If not, are there indications that it may be in the future?
 
 
Thanks in advance for replies to these questions,
 
Michael Geis


		
---------------------------------
Do you Yahoo!?
 Read only the mail you want - Yahoo! Mail SpamGuard.
--0-1813504093-1102388915=:75808
Content-Type: text/html; charset=us-ascii

<DIV>
<DIV>Hello, everyone!</DIV>
<DIV>Before describing my problem, I would like to comment on the great degree of transparancy </DIV>
<DIV>of the ALSA library. Sure enough, it took a while to get used to its wealth, but the example </DIV>
<DIV>programs + the former posts on this list give great indications as to how to make use of</DIV>
<DIV>this wealth.</DIV>
<DIV>&nbsp;</DIV>
<DIV>I am using ALSA to stream pieces of music contained in a class called score to an ALSA client with a port of type MIDI_GENERIC.&nbsp;One way to construct a score is from a Midi file, so I can compare the sound of playing the Midi file with pmidi&nbsp;with the result of&nbsp;streaming a score constructed from that midifile to the alsa sequencer.</DIV>
<DIV>The streaming works&nbsp;for pieces that dont contain many parts, but when many notes are played simultaneously (e.g. Beethoven's 5 Symphony, Movement 1), the order of notes gets mixed up and the output devices choke (same problem for a keyboard and with timidity). However, the midifile I made the score from plays nicely with pmidi.</DIV>
<DIV>I am pretty convinced that the problem is not queue overflow, since I flush queues every two seconds.</DIV>
<DIV>&nbsp;</DIV>
<DIV>Does someone have an idea where the choking could come from and what measures can be used to get rid of it?</DIV>
<DIV>&nbsp;</DIV>
<DIV>There are two more items I have been wondering about that dont appear worth to put into a post of their own.</DIV>
<DIV>Is there a Macro that tells me whether an ALSA sequencer client is an internal or external device? Thus, a user could choose what kind of device to play to (without having to specify client and port). </DIV>
<DIV>Second, is ALSA used purely on linux or also&nbsp;on OS X or BSD?</DIV>
<DIV>If not, are there indications that it may be in the future?</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;</DIV>
<DIV>Thanks in advance for replies to these questions,</DIV>
<DIV>&nbsp;</DIV>
<DIV>Michael Geis</DIV></DIV><p>
		<hr size=1>Do you Yahoo!?<br> 
Read only the mail you want - <a href="http://us.rd.yahoo.com/mail_us/taglines/spamguard/*http://promotions.yahoo.com/new_mail/static/protection.html">Yahoo! Mail SpamGuard</a>.
--0-1813504093-1102388915=:75808--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/

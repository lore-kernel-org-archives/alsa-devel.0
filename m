From: Bengt "Mÿffffe5nsson" <bengt_mansson@yahoo.com>
Subject: snd_seq_sync_output_queue does not work
Date: Thu, 2 Dec 2004 03:58:01 -0800 (PST)
Message-ID: <20041202115801.6119.qmail@web42108.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

I'm trying to make an app where I need to exchange an
18k sysex. I use Rh9.
I think I've worked out the receiving part, but
sending will not work.
I chop the big sysex into 256 byte blocks and send in
a sequence. This seems to work fine when I run it
stepwise in the debugger, but crash when I run it at
full speed.
I think I've traced the problem down to the call to
snd_seq_sync_output_queue. I expect that call to hang
until the output is drained, and return a 0.
What happens is that the call seems to return
immediately with a 1.
Tried to use snd_seq_nonblock(0) but that didn't
change anything.
Does anyone have any hint?
/Bengt



		
__________________________________ 
Do you Yahoo!? 
Take Yahoo! Mail with you! Get it on your mobile phone. 
http://mobile.yahoo.com/maildemo 


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/

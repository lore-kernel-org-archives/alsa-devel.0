From: Bruce Paterson <bruce@tele-ip.com>
Subject: Help !  Distorted sound on re-run
Date: Fri, 25 Oct 2002 15:09:40 +1000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DB8D214.674FEFB6@tele-ip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa development <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

HELP !
I've tried everything I can think of and I'm at a loss.

Setup:
alsa 0.9.0rc2
soundcard Terratec EWS88 (envy24 driver)
direct hw:0,0 using snd_pcm_readi & writei with descriptor polling.
length approx 50s similtaneous read & write. read from all channels.
modified 'envy24setup' to preset hardware levels on startup
full restart of sound system each 'pass' (new handles etc.)

Problem:
The first pass works fine with beautiful audio.
The next pass the output is badly distorted (sounds like an incomplete
buffer or something), but
no errors reported, no under/overruns.... only evidence that something
is wrong is to listen to it.

What fixes it:
Waiting. Yup...if I wait > 1 minute before the 2nd pass then that is
also fine. Something 'happens'
in that time to make it all ok again.
This is why it's taken me ages to actually notice the problem at all !
(program has been running
for months).

What *doesn't* help:
Not doing a full sound restart between passes (ie. merely doing a drop
afterwards, then restart with
prepare & start, leaving pcm handles alive).
Playing a wav file with 'aplay' in between passes.
Exiting from my program and starting again between passes.
adding hw_free commands prior to close of the in & out handles.

Wild groping theories:
Due to time alone fixing it I'm wondering if it's a code problem at all
(at least in my code), but
I'm at a loss to know why waiting fixes the problem !
Does the EWS hardware "timeout" somehow ?
  
-- 
Cheers,
Bruce
-------------------------------------------------------------------
This email and any files transmitted with it are confidential and
intended solely for the use of the individual or entity to whom
they are addressed. If you have received this email in error please
notify the system manager.

    /\\\/\\\/\\\    /   /      Bruce Paterson          
   /  \\\ \\\ \\\  /   /    Senior Design Engineer
  /   /\\\/\\\/\\\/   /   87 Peters Ave, Mulgrave, Vic, 3170
 /   /  \\\ \\\ \\\  /  PO Box 4112, Mulgrave, Vic, 3170, Australia
/   /    \\\/\\\ \\\/   Ph: +61 3 8561 4232   Fax: +61 3 9560 9055
      Tele-IP Ltd.      Email: bruce@tele-ip.com    Icq: #32015991
                        WWW:   http://www.tele-ip.com       VK3TJN
-------------------------------------------------------------------


-------------------------------------------------------
This sf.net email is sponsored by: Influence the future 
of Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ads.sourceforge.net/cgi-bin/redirect.pl?sunm0004en

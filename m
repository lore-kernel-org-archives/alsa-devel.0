From: Tom Watson <sdc695@yahoo.com>
Subject: Mixer controls on VIA 8235
Date: Tue, 19 Aug 2003 19:15:27 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030820021527.81435.qmail@web21511.mail.yahoo.com>
Reply-To: tsw@johana.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

OK, I've got the goodies about archive of list, thanks.

Now new business:
I'm now working with a VIA 8235 chip set (or at least that's what
'alsamixer' says).  My problems:
I'm using 'aplay' to play a 4 channel '.wav' file (aplay -D surround40
xxx.wav) and I'm having trouble getting the rear channels to speak.

If I turn on the "headphone" control (who knew), I get the front
channels duplicated to the reat channels, but in all my fiddling (and
I've tried many) with 'alsamixer' I can't find the control that will
make the rear channels play.  I assumes that something like "3D Channel
- Switch" might switch them on, but it doesn't seem to work.

This is a "EPIA Mini ITX" motherboard, and it has 3 sound jacks.  The
are labeled: Mic, Line-in, Line-out.  When in 5.1 mode these become all
outputs and the Mic reverts to "Center/LFE", and "Line in" goes to
"Rear L&R".

In addition I've notes that on using 'alsamixer' the controls "Inout
Source Select" and "Input Source Select 1" don't switch.  Another thing
I note is when I fiddle the mixer controls (in a seperate window, kept
open) I get the following message SOMETIMES when attempting to use
'aplay':  "aplay: pcm_write:1025: Write error: Input/Output error".  I
then fiddle with the mixer again and it goes away.  Go figure.

But most importantly:  how do I get all 4 channels to work!!

p.s.  Where in the source do the controls appear??  Not that I'd change
them, but I'd like to see what they do!!  Using 'grep' on some of them
yields nothing, even over the entire driver source.

Thanks.

=====
-- 
Tom Watson
tsw@johana.com

__________________________________
Do you Yahoo!?
Yahoo! SiteBuilder - Free, easy-to-use web site design software
http://sitebuilder.yahoo.com


-------------------------------------------------------
This SF.net email is sponsored by Dice.com.
Did you know that Dice has over 25,000 tech jobs available today? From
careers in IT to Engineering to Tech Sales, Dice has tech jobs from the
best hiring companies. http://www.dice.com/index.epl?rel_code=104

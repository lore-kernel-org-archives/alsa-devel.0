From: Tom Watson <sdc695@yahoo.com>
Subject: This OUGHT to be easy, but I'm a bit lost...
Date: Tue, 3 Jun 2003 01:46:06 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030603084606.31759.qmail@web21506.mail.yahoo.com>
References: <Pine.HPX.4.33n.0306030852380.24147-100000@studcom.urz.uni-halle.de>
Reply-To: tsw@johana.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0306030852380.24147-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I'm just attempting to write a simple playback routine.  Yes, I know
that 'aplay' exists, but I need some more goodies, and 'aplay' is too
complex in other areas.

I've got a multi-channel interleaved sound file (1-6 channels for the
sake of argument) and I'd like it to reproduce.  In AC-97 sound
hardware (the motherboard has a VIA 82XX chip set) I need to setup the
rear outputs to come out the "line-in" jack, and the 5th and 6th
channels come out the Mic jack.  I'd like to have 2 channel sound
OPTIONALLY "double up" and at option come out the "rear" outputs.  I
wrote programs to do this under OSS (granted it WAS an CMI chip set,
but the same jacks existed, and the same controls had to be set).  I
would like to set these controls with the amixer command line program
(the final program will have NO GUI's at ALL).

In addition, I have a Turtle Beach Santa Cruz card (CS42xx chip set). 
It has nice things like front and rear outputs (even leveled on the
card!!).  I have my CD player wired into this, and need the mixer
controls to make this work as well.  The difficult part is finding out
exactly the command line to make it work.  It is a bit confusing.

Writing the program is the "easy" part.  Figuring out the commands and
the like is a bit difficult.  Any assistance would be quite helpful.

Clues??

Thanks!!

=====
-- 
Tom Watson
tsw@johana.com

__________________________________
Do you Yahoo!?
Yahoo! Calendar - Free online calendar with sync to Outlook(TM).
http://calendar.yahoo.com


-------------------------------------------------------
This SF.net email is sponsored by: eBay
Get office equipment for less on eBay!
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5

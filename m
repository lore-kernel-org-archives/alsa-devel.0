From: drclaw@dogsolitude.org
Subject: HDSP and the hw: interface
Date: Tue, 26 Nov 2002 16:42:32 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021126214232.GA18717@dogsolitude.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

Ok, thanks for the line out help, and I think I understand how the
matrix mixer works, and I can hear stuff through my monitors, but now I
can't figure out how to get alsa input or output functioning.  I can
plug in my mic/pre and hear that through the monitors, and I can use the
oss compatability layer to play oss compatible programs through the
monitors as well, but whenever I try to use an alsa program with hw:0,0
(hw:0,some_other_number gets a "this device doesn't exist" error with
everything) I constantly get something like -

aplay: set_params:781: Access type not available

Other programs give various other errors, when I try aplay with
plughw:0,0 instead, it outputs the format info and hangs (must ctrl-c).  

Note, again, everything works fine with my ali5451.  Do I have to use
some other for of addressing to specify the ports I want this all to go
to?  From previous mail it seems that the matrix mixer deal with audio
"streams" and physical ports.  I get how you set things in there, but I
don't get how you tell a program to send its data one on one of these
"streams" if that's the way it's supposed to work.  Of course then
there's recording (and do any sample rates above 48kHz work right now?).  

This testing has primarily been done with CVS from a week ago and CVS
from an hour ago (both work the same), I also have rc3 which works the
same minus being able to hear anything via the monitors.  

Sorry I sent this to the dev list but there were a couple similar
questions on the user list that were never answered, that and the hdsp
is sort of a "dev" card right now.  I also have a show in less than a
week I ws going to use this for...  Once I figure all of this out I'd be
happy to write a FAQ as pennance ;P  

Thanks,

784 - Michael C. Piantedosi - drclaw@dogsolitude.org


-------------------------------------------------------
This SF.net email is sponsored by: Get the new Palm Tungsten T 
handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en

From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: ALSA 0.9.3a sequencer/rawmidi oops
Date: Sun, 18 May 2003 21:46:22 +0930 (CST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200305181216.h4ICGMq25095@mercury.physics.adelaide.edu.au>
References: <s5hk7crduqr.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hk7crduqr.wl@alsa2.suse.de> from "Takashi Iwai" at May 16, 2003 12:57:32 
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takasi

Another bit of information to add to my previous email.  With the latest CVS
snapshot, there *is* still an oops associated with the sequencer, so that
hasn't changed all that much.  In short,
  pmidi -l
now does work and correctly describes available MIDI ports.  However, doing
  pmidi -p 64:0
still oopses and locks the machine solid, as before.

Therefore, it seems that the oops which was reported at the start of this
thread (which was under 0.9.3a) has *not* been subsequently fixed.  The oops
endpoint is still in __wake_up() as per the original report.

The last ALSA version I have which does work is 0.9.2 release.  I'm
wondering whether these problems are associated with the integration of 2.5
things which I believe occurred between 0.9.2 and 0.9.3a.

Regards
  jonathan
-- 
* Jonathan Woithe    jwoithe@physics.adelaide.edu.au                        *
*                    http://www.physics.adelaide.edu.au/~jwoithe            *
***-----------------------------------------------------------------------***
** "Time is an illusion; lunchtime doubly so"                              **
*  "...you wouldn't recognize a subtle plan if it painted itself purple and *
*   danced naked on a harpsichord singing 'subtle plans are here again'"    *


-------------------------------------------------------
This SF.net email is sponsored by: If flattening out C++ or Java
code to make your application fit in a relational database is painful, 
don't do it! Check out ObjectStore. Now part of Progress Software.
http://www.objectstore.net/sourceforge

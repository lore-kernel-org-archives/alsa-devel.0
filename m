From: Benny Sjostrand <gorm@cucumelo.org>
Subject: Re: cs46xx sound quality and CD volume
Date: Fri, 11 Oct 2002 22:01:03 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DA72DFF.20302@cucumelo.org>
References: <20021011032322.GC4014@draal.physics.wisc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Bob McElrath <bob+alsa-devel@mcelrath.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>
>
>However, one small buglet.  When recording from line1 (aux in the
>current driver), the sound sometimes sounds very tinny and scratchy.  I
>can fix this by muting/unmuting the CD and adjusting the CD volume.
>Yes, the CD slider in alsamixer.  Not the Aux one or the Capture one or
>the DAC one.  The CD one.  Weird, huh?  I've tried playing with all the
>other sliders and they do not affect the recording quality.
>  
>
This is a known problem (at least forme). When you unmute the CD volume
the soundcard amplifier is turned off, and at least for the Hercules 
Game Theater XP card
this makes no good.
This thing could be easily fixed.

Now, is there any other cs46xx based soundcard that for some reason relies
on this behaviour ??

/Benny



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

From: Jesse Chappell <jesse@essej.net>
Subject: Re: hdsp problem
Date: Thu, 15 Jan 2004 11:11:49 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <587e32ba984a0af957904d78b4624f66@essej.net>
References: <20040113132353.1f672adb.TimBlechmann@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040113132353.1f672adb.TimBlechmann@gmx.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Tim Blechmann <TimBlechmann@gmx.net>
Cc: alsa list <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Paul Davis experienced this recently with his cardbus/digiface,
with both 0.9.8 and 1.0.x.  He found that it only does this when
the period size is >= 512.  At 256 and below, it works fine for
him.   Give that a try.......

I need to test my personal system to verify this happens for me
too.  

jlc

Tim Blechmann wrote on Tue, 13-Jan-2004:

 > i've got a problem with my hammerfall dsp (multiface + cardbus) ...
 > 
 > it might be an alsa problem: i can load all modules and upload the
 > firmware with hdsploader ... and i can mix the inchannels to the
 > outchannels with hdspmixer ... 
 > but when i start a sound application (jack,oss layer, aplay) everything
 > i get is a distorted sound. i recorded this sound and it seems that
 > there is one block of audio data followed by one block of silence (have
 > a look at it at http://www.volny.cz/guitar_billy/hdsp.screenshot.png,
 > there might be some errors at the edges of the blocks because of the mp3
 > compression of the original soundfile, thanks to alex for putting it
 > online!)
 > then i start any sound application the sound that's routed from
 > the input is being distorted, too, (i suppose every second block is
 > cleared to zero samples)
 > 
 > i used several alsa version, several kernels (2.4, 2.6), changing the
 > pci latency doesn't change anything, either ...
 > 
 > if anyone has an idea, what might be the issue, i'd be interesting to
 > hear...
 


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn

From: holborn <holborn@telefonica.net>
Subject: FX8010 on emu10k1
Date: Mon, 26 Jan 2004 11:36:52 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200401261136.52554.holborn@telefonica.net>
Reply-To: holborn@telefonica.net
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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


Hi!

Right now I'm using ld10k1 a wonderful program by Peter Zubaj and i have 
chorus effect in my emu10k1 synthesizer, when a MIDI control reverb or chorus 
message is sent to the emu10k1 hi route the instrument sound to the FX(12) 
and FX(13), then i put 2 chorus in stereo and miracle ....chorus effect.... 
and not to bad :-) 

Now i need a reverb effect, i was see fv10k1 utility (freverb implementation 
for FX8010), but .... i can't run, i hacked a little bit, i loaded .... 
but ... i only hear delay effect, not reverb. Now I will try to implement a 
small reverb made by me.

But my question is .... i see in emu10k1 device3 the 8 first FX8010 buses, but 
only for playback, anyway to capture FX(12) and FX(13) buses?

Thanks


Josep




  



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn

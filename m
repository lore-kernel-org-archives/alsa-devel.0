From: Pavel Vondricka <wanthalf@centrum.cz>
Subject: Novation X-Station: mostly success, but...
Date: Thu, 17 Mar 2005 00:56:29 +0100
Message-ID: <200503170056.29280.wanthalf@centrum.cz>
Reply-To: wanthalf@centrum.cz
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
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

Hi,
I can confirm, that my X-Station works with Clemens Ladisch's patch. I got the 
last version of the files announced here by Clemens from his site and 
replaced those in my kernel gentoo-dev 2.6.10 and recompiled it.
The MIDI connection seems to work in both directions - at least the basics I 
have tried. 
(Why is the sound volume of my softsynth so low, when the velocity reported is 
the same as in the "loud" midi files?)

However, I have problems with the "standard compliant" audio part: I can play 
sounds through the device, but I cannot capture them. No wonder: the mixer 
seems to have no effect on the device. There are just a few controls anyway: 
bass, treble, mic volume, speaker volume, aso. - nothing seems to have any 
effect when playing a sound through the device, just hardware volume knobs on 
it :-).
When playing, the sound is not clean all the time, there are some clicks from 
time to time. Maybe a problem of the computer?

Regards,
Pavel

-- 
###########################################################################
# mailto:wanthalf@centrum.cz 
# ICQ:143159880 
# Jabber:wanthalf@jabber.cz
###########################################################################


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click

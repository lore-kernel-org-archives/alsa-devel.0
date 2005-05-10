From: fab <fab@gnux.info>
Subject: Medion + intel hda tests
Date: Wed, 11 May 2005 00:02:38 +0200
Message-ID: <20050510220238.GA28417@blackmilk.localzone.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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
since I reported bugs as well as I can and gave no answers, I started to
do some very basic tests and sourcecode reading.
I tried to modprobe snd-hda-intel with different "model" option and then
tested all the outputs, I only marked the working ones :

Availables inputs:
 [front] [surround] [center] , [headphone]
tested model :
 3stack        : front
 3stack-digout : front
 5stack        : front
 5stack-digout : front
 w810          : front surround

Ok, as you can see, the w810 is the only offering 2 outputs.
When I say "it works" I mean "we can ear something of extremely low
level and bad quality", no output with no model give satisfying sound.

I haven't tested the SPDIF output since I don't have the appropriate
hardware.

Under winXP, I can have front and headphone pluged at same time with
sound on both. I can swap surround and center outputs and chose between
2 , 4 or 6 channels.

I hope this helps.
As I already said, I'm ready to code and do whatever needed to make this
card working. I just have no knowledge under winXP and very little
driver one.

Best regards.
Fabien Devaux.


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click

From: Anders Torger <torger@ludd.luth.se>
Subject: Bug in rme9652 or snd_pcm_hw_params_set_rate_near()? (slave clock stuff)
Date: Mon, 24 Nov 2003 21:42:48 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200311242142.48114.torger@ludd.luth.se>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
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


If my hammerfall (rme9652) sound card is locked slave to 48 kHz, and I put 
44.1 kHz into snd_pcm_hw_params_set_rate_near for playback it accepts it, 
should it really be that way? I expected that it would set the rate to 48kHz, 
since the card does not change the sample rate to 44.1 kHz (looking in 
/proc), when I start playing the rate is indeed 48kHz.

My idea of how things should work here is that if the sound card is in slave 
mode, it should only report the current clock as the only available (I think 
I wrote the rme96 driver along these lines). If that is not how it is 
supposed to work, I need to know another way of finding out what the current 
slave clock is...

Also, if it should be possible to set any rate among what the card can handle 
with its own clock in this situation, the card should automatically change to 
master mode on the output. As it is now, the actual sample rate does not 
match what is allowed to set.

lib is 0.9.8, driver is what is found in 2.6.0-test10

I'm writing an application that is quite dependent on consistent behaviour 
when it comes to how slave clocks are handled. Are there any guidelines on 
how it should work? My guess is that currently the driver authors' have made 
the implementation along their own ideas of how things should be, and 
therefore can differ quite much.

/Anders Torger



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/

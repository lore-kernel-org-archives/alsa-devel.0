From: "airplays55@yahoo.com" <airplays55@yahoo.com>
Subject: How to autoconfigure MIDI in liveCD?
Date: Wed, 18 May 2005 11:30:48 -0700 (PDT)
Message-ID: <20050518183049.5841.qmail@web53604.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

Knoppix 3.8 liveCD (which includes ALSA 1.0.8) loads
the audio but not the midi portion of the soundcard. 
In order to get the midi modules loaded (snd-seq-midi
etc.), I have to manually run "alsaconf", which
requires human intervention for me to accept the
soundcard it found by probing, and also accepting the
choice for alsaconf to modify /etc/modprobe.d/sound
and /etc/modprobe.conf.

I need to find out specifically what knoppix can do
differently for midi to be autoconfigured without
requiring human intervention.

Is there a completely automated script that
accomplishes what "alsaconf" does?

If this is possible, I plan to encourage the Klaus
Knopper to include midi auto-configuration in future
knoppix versions.  Thanks.



		
Yahoo! Mail
Stay connected, organized, and protected. Take the tour:
http://tour.mail.yahoo.com/mailtour.html



-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click

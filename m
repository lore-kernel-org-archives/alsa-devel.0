From: Guenther Sohler <guenther.sohler@newlogic.com>
Subject: mixer problem with creative audixy - was most simple alsa seq application
Date: Sat, 16 Feb 2002 16:13:01 +0100 (MET)
Message-ID: <XFMail.020216161301.guenther.sohler@newlogic.com>
Reply-To: Guenther Sohler <guenther.sohler@newlogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
In-Reply-To: <s5hlmdud7u2.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Thank you very much for the advice.
I dont need thr queue any more
Now almost all midi works again in my application - but now for alsa(instead of
oss)
But there is another problem now. I use an audixy card in my pc connected to an
external amplifier. 
Even the amplifier is set to the maximal volume, midi synth is quite silent
whereas pcm is very loud.

Obviously the problem is in the mixer

alsmixer shows me a lot of volumes to adjust, but actually just the volume of
"music" show en effect. maximum volume on music makes me hear a silent tune.
but "master" and all other volumes do not show(sound) a change in the volume.

In my application i can now select where the output goes to

64:0 is the external midi and 65:0-3 is the awe synth
64:0 does not work all the time. but directly piping midi date to the
respective /dev/snd/midixxxx always works(i hear a tune on the external
keyboard).
whats the problem here ?


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

From: Guenther Sohler <guenther.sohler@newlogic.com>
Subject: stupid question about pcm devices
Date: Fri, 08 Feb 2002 07:24:44 +0100 (MET)
Message-ID: <XFMail.020208072444.guenther.sohler@newlogic.com>
Reply-To: Guenther Sohler <guenther.sohler@newlogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
In-Reply-To: <s5hadulyywo.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I have seen that alsa provides nice pcm devices in /dev/snd directory

*They are split in playback and capture devices :) nice idea.
In Oss I was able to pipe data from and to them and therfore was
recording/playing back at a certain sample rate.
With alsa this is not possible anymore. it says the descriptor was in a bad
state. Is it possible ???

*Is there something like aconnect for pcm devices ????

when I do a sfxload, it operates on /dev/sequencer, which makes the seq-oss
module automatically to load. Is there a way to load the patches in native alsa
???

rds guenther

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

From: Guenther Sohler <guenther.sohler@newlogic.com>
Subject: PCM frames already played
Date: Sun, 17 Feb 2002 11:28:23 +0100 (MET)
Message-ID: <XFMail.020217112823.guenther.sohler@newlogic.com>
Reply-To: Guenther Sohler <guenther.sohler@newlogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
In-Reply-To: <3C6ED644.6090403@users.sf.net>
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

Is there a way to determine the number of bytes/frames already played through
the DAC since last reset via snd_pcm_status in v0.9.x ?

Its possible in OSS via ioctl and in alsa v0.5.0 you can view at a element
"bytes" in sthe respective structure.

But how does it work in v0.9.x ?


rds guenther

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

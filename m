From: Mark Knecht <markknecht@attbi.com>
Subject: alsaplayer not working with alsa?
Date: 22 Dec 2002 13:19:05 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1040591946.24799.103.camel@Godzilla>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa-List <linux-audio-user@music.columbia.edu>, Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi,
   When running alsaplayer version 0.99.73 without jack, I'm seeing this
failure:

[mark@Godzilla mark]$ alsaplayer -v
alsaplayer 0.99.73
[mark@Godzilla mark]$ alsaplayer
alsaplayer: pcm.c:6293: snd_pcm_unlink_ptr: Assertion `0' failed.
AlsaPlayer interrupted by signal 6
[mark@Godzilla mark]$

   alsaplayer works very well when jack is running.

   Anyone else seeing this?

Thanks,
Mark




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

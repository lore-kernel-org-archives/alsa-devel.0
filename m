From: Shaju Abraham <shaju@multitech.co.in>
Subject: Calling snd_pcm_oss_write directly.
Date: Wed, 24 Jul 2002 15:47:38 +0530
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D3E7EC2.E28C98AF@multitech.co.in>
References: <200207201425.KAA12713@bromo.msbb.uc.edu> <s5hr8hwovno.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

Hi all,
          I am in a situation where I intend to call snd_pcm_oss_write
directly.

What exactly happens is - the open and all the initial ioctl calls are
done by the oss application. But the write call of the oss application
is not done but it is done by some other task.

        So what I do is, when snd_pcm_oss_open gets called, I store the
-- struct file *file -- in my own pointer, say, gfile.

Then I use this pointer, -gfile- in snd_pcm_oss_write() when I call the
function directly.  But apparently this much is not enough. The direct
write call crashes.  If you can please tell me what else needs to be
done for the call to get through, it will be of great help.

--Shaju Abraham



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

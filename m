From: igor@eellc.ru
Subject: Problem closing device handle
Date: Mon, 17 Jan 2005 15:11:33 +0000
Message-ID: <200501171511.33573.igor@eellc.ru>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
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

Hello
I'm developing software which captures audio and plays it from multiple 
sources in parallel.
I'm using plughw:1,0 device to capture and plug:'dmix:SLAVE="hw:1,0"', 
everything works fine (i mean play and capture), but when i try to close 
capture handle -
snd_pcm_close(dev_handle)
i get following output:
ALSA lib pcm_hw.c:370:(snd_pcm_hw_hw_free) SNDRV_PCM_IOCTL_HW_FREE failed: 
File descriptor in bad state
ALSA lib pcm_plug.c:69:(snd_pcm_plug_close) plug slaves mismatch

(second error about slaves mismatch appears not in all situation). 
After some debugging i found out following - 
- this error occures only if i use playback (yes, playback, and error while 
trying to close capture handle). If i don't open playback device - it doesn't 
happens
- after this handle remains open, and i cannot open it again - if i close 
snd_pcm_close again, it finally closes, but it doesn't seems a nice solution
- it happens only when i use dmix plugin, when i use just plug plugin - 
everything is OK

Has anyone comments to this, is it some misconfiguration or something else?
Thanks


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt

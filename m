From: Konstantin Stepaniuk <s.k.v@mail.ru>
Subject: reopen with "plug:dmix" failure
Date: Thu, 10 Jul 2003 12:39:57 +0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200307101239.57649.s.k.v@mail.ru>
Reply-To: s.k.v@mail.ru
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

My application should play some tracks simultaneously and work in a common 
system in which sound card is not supplying hardware mixing. Tracks may have 
different bitrate and channels count. So I'm opening alsa handle for the each 
track by calling function snd_pcm_open( &pcm, "plug:dmix", 
SND_PCM_STREAM_PLAYBACK, SND_PCM_NONBLOCK );

After closing last alsa handle (snd_pcm_close) and trying to open the new one, 
it's failed with error:

ALSA lib pcm_hw.c:1055snd_pcm_hw_open) open /dev/snd/pcmC0D0p failed: Device 
or resource busy
ALSA lib pcm_dmix.c:948snd_pcm_dmix_open) unable to open slave

How can I solve this problem?



-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps

From: "Joe Hsu" <nagual.hsu@gmail.com>
Subject: snd_pcm_hwsync / snd_pcm_avail_update problem
Date: Thu, 16 Mar 2006 21:19:25 +0800
Message-ID: <7fe205990603160519u160c02f8i@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
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

    When playing back or capturing digital audio samples from alsa
devices, I use snd_pcm_hwsync and snd_pcm_avail_update. But sometimes
snd_pcm_hwsync fails and then snd_pcm_avail_update would return a much
bigger value than snd_pcm_hwbufsize.

     snd_pcm_hwsync returns -32(-EPIPE) when it fails. Can someone
explains why? Thanks. :)

--
The sun is shinny but the ice is slippery.


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642

From: =?iso-8859-15?q?Z=E9bulon?= <zeb@zebulon.org.uk>
Subject: [Envy24HT] Some applications crash with simple.c:1462: snd_mixer_selem error
Date: Tue, 7 Oct 2003 22:22:25 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200310072222.25438.zeb@zebulon.org.uk>
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

I use a Terratec Aureon Space and support is very nice now (with 0.9.6 
drivers). However, I experience some crashes with a lot of applications, like 
totem or kaffeine. The error message is always the same :

simple.c:1462: snd_mixer_selem_get_playback_volume: Assertion `elem->type == 
SND_MIXER_ELEM_SIMPLE' failed.

For mplayer or xine, I need to send the output to OSS (I guess it uses 
snd-pcm-oss compatibility ?)

How to correct this problem ? Is it a limitation of the Alsa drivers 
(snd-envy1724) that will be corrected in future versions ?

Thanks

Eric



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

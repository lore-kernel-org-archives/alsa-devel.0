From: "Max Mozok" <elephant@os2.kiev.ua>
Subject: [PATCH]alsa\alsa-kernel\pci\ac97\ac97_codec.c
Date: Fri, 05 Sep 2003 13:25:35 +0300 (EET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200309051024.h85AOWBk074958@elvis.cps.com.ua>
References: <Pine.LNX.4.53.0309042012160.6731@pnote.perex-int.cz>
Reply-To: "Max Mozok" <elephant@os2.kiev.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.53.0309042012160.6731@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

On Thu, 4 Sep 2003 20:12:38 +0200 (CEST), Jaroslav Kysela wrote:

        /* FIXME: C-Media chips have no PCM volume!! */
        if (/*ac97->id == 0x434d4941 ||*/
            ac97->id == 0x434d4942 ||
            ac97->id == 0x434d4961)
Line 1368:
snd_ac97_write_cache(ac97, AC97_PCM, 0x9f1f); //(Mute)

should be:
snd_ac97_write_cache(ac97, AC97_PCM, 0x0); //(Unmute)

In accordance with CMI9739 6CH Audio Codec SPEC_Ver12.pdf

No PCM volume, but it should be unmute, is it?



Yours sincerely,
		Max V. Mozok
-----------------------------------------------------------------------------------------
E-mail: elephant[AT]os2.kiev.ua




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

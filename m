From: Antonio Willy Malara <behappy@maialone.com>
Subject: alsa + iBook + iMic, endianness troubles
Date: Wed, 10 Sep 2003 16:30:13 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030910143013.GA1981@Zeryn>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
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

i use a Griffin Tech iMic on a iBook (G3 700mhz, 128mb ram) running 
linux 2.4.20-ben9 and alsa 0.9.6, and i cannot use jack because it 
tells that my soundcard don't support one of the two audioformat jack 
can use..

i changed the snd_pcm_hw_params_set_format (handle, hw_params, 
SND_PCM_FORMAT_S16) to _S16_BE and it passed that function, the program 
was running but with a bunch of errors (obviously)

there's something i can do? i think that all usb-audio stuff is kinda 
broken for all machines with endiannes != from intel's one

wil
---

If you must ask what jazz is, you'll never know.
                 -- Louis Armstrong


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

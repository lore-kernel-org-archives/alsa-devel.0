From: "Sam Revitch" <sam.revitch@gmail.com>
Subject: Re: stateful reconnect with snd-usb-audio
Date: Sat, 17 Jun 2006 02:01:39 -0700
Message-ID: <8d4807d50606170201t4922fd68x9fed2694657ae594@mail.gmail.com>
References: <8d4807d50606121405n51edef2au3de163b01029aaf5@mail.gmail.com>
	<s5hy7w07wvx.wl%tiwai@suse.de> <s5hr71r97rz.wl%tiwai@suse.de>
	<Pine.LNX.4.61.0606141543260.10637@tm8103.perex-int.cz>
	<s5hodwv961d.wl%tiwai@suse.de>
	<Pine.LNX.4.61.0606141645450.10637@tm8103.perex-int.cz>
	<8d4807d50606141020w8e29a50t6b97528d7e82a0c5@mail.gmail.com>
	<8d4807d50606150304o5ae2ccd0xf7af2f4ccf38ec4c@mail.gmail.com>
	<s5hver1777i.wl%tiwai@suse.de>
	<8d4807d50606170123k51bf2db5ma673b071c8e18d4b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <8d4807d50606170123k51bf2db5ma673b071c8e18d4b@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net, Jaroslav Kysela <perex@suse.cz>
List-Id: alsa-devel@alsa-project.org

The last patch has other problems -- races in mixer_oss/pcm_oss, build
failures with disable-verbose-procfs, etc.. :-(  To avoid spamming
this list with another file attachment the latest one is posted here:

http://lsb.blogdns.net/files/snd-disconnect.patch

Sorry and thanks.
-Sam Revitch

From: Santiago Otero <santiago@atlas.uvigo.es>
Subject: Re: Request for tests: scatter-gather dma
	support	on	via686 and emu10k1
Date: 23 Jul 2002 19:18:53 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1027444734.657.8.camel@atenea>
References: <s5hheivr5xl.wl@alsa2.suse.de> <1027166734.759.8.camel@atenea>
	<s5hptxgovji.wl@alsa2.suse.de> <1027354918.1225.9.camel@atenea>
	<s5hd6tepzp4.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hd6tepzp4.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: ALSA-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

El mar, 23-07-2002 a las 11:21, Takashi Iwai escribi=F3:

>=20
> ok, could you show me the values listed in the proc file above during
> playback/record?
> i guess the buffer size is not aligned to the period size, and the
> number of period is relatively small.
>=20

playing sound:

$cat /proc/asound/card0/pcm0p/sub0/hw_params=20
access: RW_INTERLEAVED
format: S16_LE
subformat: STD
channels: 2
rate: 44100 (44100/1)
period_size: 16
buffer_size: 16384
tick_time: 10000

recording sound:

$cat /proc/asound/card0/pcm0c/sub0/hw_params
access: RW_INTERLEAVED
format: S16_LE
subformat: STD
channels: 2
rate: 44100 (44100/1)
period_size: 16
buffer_size: 16384
tick_time: 10000




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

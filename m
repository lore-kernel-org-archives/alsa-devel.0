From: Philipp Matthias Hahn <pmhahn@titan.lahn.de>
Subject: Re: au88x0 modem
Date: Tue, 20 Sep 2005 15:21:24 +0200
Message-ID: <20050920132124.GA6599@titan.lahn.de>
References: <4327DA14.3040205@netvigator.com> <20050914205608.GD14657@sashak.softier1.local> <20050915091158.GA7314@titan.lahn.de> <20050915092155.GA7328@titan.lahn.de> <20050915143533.GB23218@sashak.softier1.local> <20050915204345.GC27700@sashak.softier1.local> <20050916084653.GB524@titan.lahn.de> <20050916182524.GE17864@tecr> <20050919150025.GA3058@titan.lahn.de> <432EDA22.3060707@netvigator.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <432EDA22.3060707@netvigator.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Raymond <rayau@netvigator.com>, Sasha Khapyorsky <sashak@smlink.com>
Cc: openvortex-dev@nongnu.org, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello!

On Mon, Sep 19, 2005 at 11:32:50PM +0800, Raymond wrote:
> for audio codec
> 	   ac97.scaps = AC97_SCAP_NO_SPDIF;
> for modem codec
>           ac97.scaps = AC97_SCAP_SKIP_AUDIO;
...
> static int __devinit snd_vortex_mixer(vortex_t * vortex)
> {
>     err = snd_ac97_mixer(pbus, &ac97, &vortex->codec[0]);
                                                      ^s
...
>     switch ( hwread(vortex->mmio,0x2A804)) {
>     case 0x10431043:          // ASUS L8400B
didn't match, lines deleted.
...
>         err = snd_ac97_mixer(pbus, &ac97, &vortex->codec[ac97.num]);
                                                          ^s

Here's the next trace with the above modifications applied.
Only lines matching codec 1 are provided:

vortex_codec_read  1 7c :5349
vortex_codec_read  1 7e :4c26
vortex_codec_write 1 3c :0000
vortex_codec_read  1 00 :0000
vortex_codec_read  1 7c :5349
vortex_codec_read  1 7e :4c26
vortex_codec_read  1 3c :4001
vortex_codec_read  1 7c :5349
vortex_codec_read  1 7e :4c26
vortex_codec_read  1 3c :4001
vortex_codec_write 1 40 :1f40
vortex_codec_write 1 3e :0000
vortex_codec_write 1 3e :0000
vortex_codec_read  1 3e :f000
vortex_codec_read  1 3e :f00f
vortex_codec_write 1 5c :f210
vortex_codec_write 1 68 :0000
vortex_codec_write 1 4c :fffe
vortex_codec_write 1 4e :fffe
vortex_codec_write 1 50 :ffff
vortex_codec_write 1 52 :0000
vortex_codec_write 1 56 :0000
vortex_codec_read  1 2a :0000
vortex_codec_write 1 2a :0000
vortex: IRQ reg error
...
vortex_codec_read  1 54 :0000
vortex_codec_write 1 54 :0001

Writing to mc97#1-1+regs still doesn't seem to change anything.

BYtE
Philipp
-- 
  / /  (_)__  __ ____  __ Philipp Hahn
 / /__/ / _ \/ // /\ \/ /
/____/_/_//_/\_,_/ /_/\_\ pmhahn@titan.lahn.de


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php

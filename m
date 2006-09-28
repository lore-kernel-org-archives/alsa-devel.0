From: Elimar Riesebieter <riesebie@lxtec.de>
Subject: Re: 1.0.13rc3: relocation error: mocp:
	symbol	snd_pcm_hw_params_get_channels_min ..
Date: Thu, 28 Sep 2006 20:02:07 +0200
Message-ID: <20060928180207.GA2855@samweis.home.lxtec.de>
References: <20060926201319.GA3067@samweis.home.lxtec.de>
	<Pine.LNX.4.61.0609270841040.9340@tm8103.perex-int.cz>
	<20060927180756.GA5202@aragorn.home.lxtec.de>
	<s5h8xk5p10k.wl%tiwai@suse.de>
	<20060927194840.GA3542@samweis.home.lxtec.de>
	<s5h1wpwpa49.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5h1wpwpa49.wl%tiwai@suse.de>
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
Cc: pkg-alsa-devel <pkg-alsa-devel@lists.alioth.debian.org>, alsa-devel <alsa-devel@lists.sourceforge.net>, Jaroslav Kysela <perex@suse.cz>
List-Id: alsa-devel@alsa-project.org

On Thu, 28 Sep 2006 the mental interface of
Takashi Iwai told:

> At Wed, 27 Sep 2006 21:48:40 +0200,
> Elimar Riesebieter wrote:
> > 
> > On Wed, 27 Sep 2006 the mental interface of
> > Takashi Iwai told:
> > 
> > > At Wed, 27 Sep 2006 20:07:56 +0200,
> > > Elimar Riesebieter wrote:
> > > > 
> > > > On Wed, 27 Sep 2006 the mental interface of
> > > > Jaroslav Kysela told:
> > > > 
> > > > > On Tue, 26 Sep 2006, Elimar Riesebieter wrote:
> > > > > 
> > > > > > Hi all,
> > > > > > 
> > > > > > I am testing 1.0.13rc3 (lib/driver/utils) on PPC/2.6.18
> > > > > > 
> > > > > > Starting a soundapp like moc gives:
> > > > > > 
> > > > > > "relocation error: mocp: symbol snd_pcm_hw_params_get_channels_min,
> > > > > > version ALSA_0.9.0rc4 not defined in file libasound.so.2 with link
> > > > > > time reference"
> > > > > > 
> > > > > > Any hints?
> > > > > 
> > > > > What is output from commands 'nm /usr/lib/libasound.so.2 | grep 
> > > > > snd_pcm_hw_params_get_channels_min' 
> > > > 
> > > > nm: /usr/lib/libasound.so.2: no symbols
> > > > 
> > > > > and 'nm mocp | grep 
> > > > > snd_pcm_hw_params_get_channels_min'?
> > > > 
> > > > nm: /usr/bin/mocp: no symbols
> > > 
> > > The symbols are stripped.
> > > Use objdump, e.g. with -T option, instead.
> > 
> > root@samweis ~ # objdump -T  `which mocp` | grep
> > snd_pcm_hw_params_get_channels_min
> > 1005ca20      DF *UND*  0000002c  ALSA_0.9.0rc4 \
> > snd_pcm_hw_params_get_channels_min
> > root@samweis ~ # objdump -T /usr/lib/libasound.so.2 | grep
> > snd_pcm_hw_params_get_channels_min
> > 00057aa0 g    DF .text  0000002c  ALSA_0.9 \
> > __snd_pcm_hw_params_get_channels_min
> > 00057aa0  w   DF .text  0000002c  ALSA_0.9 \
> > snd_pcm_hw_params_get_channels_min
> 
> Hm, the versions are not seen here.
> 
> > Hmmm, why there are different versions? 1.0.13rc2 works fine.
> 
> If 1.0.13rc2 works, a skeptical change is the prefix check below.
> Could you revert this patch and try whether it works?

No changes.

> Also, what is defined as __SYMBOL_PREFIX in config.h?

grep __SYMBOL_PREFIX include/config.h

#define __SYMBOL_PREFIX ""

# readelf -W -s /usr/lib/libasound.so.2 | grep snd_pcm_hw_params_get_channels_min
141: 00057aa0    44 FUNC    GLOBAL DEFAULT   10 __snd_pcm_hw_params_get_channels_min@@ALSA_0.9
614: 00057aa0    44 FUNC    WEAK   DEFAULT   10 snd_pcm_hw_params_get_channels_min@@ALSA_0.9
# readelf -W -s /usr/bin/mocp | grep snd_pcm_hw_params_get_channels_min
201: 1005c8c0    44 FUNC    GLOBAL DEFAULT  UND snd_pcm_hw_params_get_channels_min@ALSA_0.9.0rc4 (11)
141: 00057aa0    44 FUNC    GLOBAL DEFAULT   10 __snd_pcm_hw_params_get_channels_min@@ALSA_0.9

Elimar


-- 
  It's a good thing we don't get all 
  the government we pay for.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV

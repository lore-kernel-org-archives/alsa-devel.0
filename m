From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: 1.0.13rc3: relocation error: mocp: symbol
 snd_pcm_hw_params_get_channels_min ..
Date: Wed, 27 Sep 2006 08:41:47 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0609270841040.9340@tm8103.perex-int.cz>
References: <20060926201319.GA3067@samweis.home.lxtec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20060926201319.GA3067@samweis.home.lxtec.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Elimar Riesebieter <riesebie@lxtec.de>
Cc: pkg-alsa-devel <pkg-alsa-devel@lists.alioth.debian.org>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Tue, 26 Sep 2006, Elimar Riesebieter wrote:

> Hi all,
> 
> I am testing 1.0.13rc3 (lib/driver/utils) on PPC/2.6.18
> 
> Starting a soundapp like moc gives:
> 
> "relocation error: mocp: symbol snd_pcm_hw_params_get_channels_min,
> version ALSA_0.9.0rc4 not defined in file libasound.so.2 with link
> time reference"
> 
> Any hints?

What is output from commands 'nm /usr/lib/libasound.so.2 | grep 
snd_pcm_hw_params_get_channels_min' and 'nm mocp | grep 
snd_pcm_hw_params_get_channels_min'?

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV

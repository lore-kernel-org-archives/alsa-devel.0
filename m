From: Nicolas Boichat <nicolas@boichat.ch>
Subject: Re: ALSA Intel HDA MacBook
Date: Sun, 23 Jul 2006 16:31:17 +0200
Message-ID: <44C38835.6010200@boichat.ch>
References: <200607081323.17265.rene@exactcode.de>	<200607082120.02137.rene@exactcode.de>	<s5hk66lda2l.wl%tiwai@suse.de>	<200607101344.13837.rene@exactcode.de>	<44B24168.10405@boichat.ch>
	<s5hk66k76sh.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hk66k76sh.wl%tiwai@suse.de>
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
Cc: Matt Porter <mporter@embeddedalley.com>, alsa-devel@lists.sourceforge.net, Rene Rebe <rene@exactcode.de>
List-Id: alsa-devel@alsa-project.org

Hi,

Takashi Iwai wrote:
>
> OK then it's somewhat another black magic :)
>
> Linus made a patch to make MacMini to work.  The patch is below (and
> it's already merged to ALSA HG tree, too).
> Could you check whether it works for other Intel Mac models?
> At least, we need to check that it doesn't break something...
>   
I finally found the time to test this patch on my Macbook Pro (I'm
running 2.6.18-rc2, which includes this patch).

I have the following results:
- "Side" controls internal speakers, if no headphone is plugged
- "Front" controls headphones
- Line-in is always set as output ("Line In as output" has no effect),
"Center" controls line-"out" left channel, "LFE" the right channel.
- "Surround" has no effect.

However, the internal mic doesn't work anymore (whatever value I put in
"Capture", "Input Source" and "Mux")...

Best regards,

Nicolas
>
> Subject: x86 MacMini: make built-in speaker sound actually work
>
> The MacMini board table seems to largely look like any bog-standard
> Intel 945 board.
>
> Signed-off-by: Linus Torvalds <torvalds@osdl.org>
>
> ---
> commit 7c3dec0679c66ce177726802adbe2f403942fc27
> tree 62d286f0b477a62d6996b6ba2cacdc3cdd4579a9
> parent c80dc60b03d633047c7f96be87fd59cdcdbb929f
> author Linus Torvalds <torvalds@macmini.osdl.org> Mon, 10 Jul 2006 22:21:43 -0700
> committer Linus Torvalds <torvalds@macmini.osdl.org> Mon, 10 Jul 2006 22:21:43 -0700
>
>  sound/pci/hda/patch_sigmatel.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
> index fb4bed0..ea99083 100644
> --- a/sound/pci/hda/patch_sigmatel.c
> +++ b/sound/pci/hda/patch_sigmatel.c
> @@ -351,6 +351,7 @@ static unsigned int *stac922x_brd_tbl[ST
>  	[STAC_REF] =	ref922x_pin_configs,
>  	[STAC_D945GTP3] = d945gtp3_pin_configs,
>  	[STAC_D945GTP5] = d945gtp5_pin_configs,
> +	[STAC_MACMINI] = d945gtp5_pin_configs,
>  	[STAC_D965_2112] = d965_2112_pin_configs,
>  };
>  
>   


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV

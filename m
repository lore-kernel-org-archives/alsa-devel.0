From: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [2.6 patch] sound/pci/cs4281.c fix typos in the SUPPORT_JOYSTICK=n case
Date: Tue, 8 Mar 2005 11:24:02 +0100
Message-ID: <20050308102402.GE18021@ucw.cz>
References: <20050304033215.1ffa8fec.akpm@osdl.org> <200503070941.59365.petkov@uni-muenster.de> <20050307215206.GH3170@stusta.de> <d120d50005030714126e345fe2@mail.gmail.com> <20050307230633.GJ3170@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Received: from mail.suse.cz (styx.suse.cz [82.119.242.94])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 1F8CB178
	for <alsa-devel@alsa-project.org>; Tue,  8 Mar 2005 11:20:40 +0100 (MET)
Content-Disposition: inline
In-Reply-To: <20050307230633.GJ3170@stusta.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Adrian Bunk <bunk@stusta.de>
Cc: dtor_core@ameritech.net, Borislav Petkov <petkov@uni-muenster.de>, perex@suse.cz, Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linux-input@atrey.karlin.mff.cuni.cz
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 08, 2005 at 12:06:33AM +0100, Adrian Bunk wrote:

> This patch fixes typos in the SUPPORT_JOYSTICK=n case.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Thanks; applied.

> --- linux-2.6.11-mm1-full/sound/pci/cs4281.c.old	2005-03-07 23:45:01.000000000 +0100
> +++ linux-2.6.11-mm1-full/sound/pci/cs4281.c	2005-03-07 23:45:27.000000000 +0100
> @@ -1331,8 +1331,8 @@
>  	}
>  }
>  #else
> -static inline int snd_cs4281_gameport(cs4281_t *chip) { return -ENOSYS; }
> -static inline void snd_cs4281_gameport_free(cs4281_t *chip) { }
> +static inline int snd_cs4281_create_gameport(cs4281_t *chip) { return -ENOSYS; }
> +static inline void snd_cs4281_free_gameport(cs4281_t *chip) { }
>  #endif /* CONFIG_GAMEPORT || (MODULE && CONFIG_GAMEPORT_MODULE) */

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click

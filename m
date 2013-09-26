From: Ian Clarke <ianclarke340@gmail.com>
Subject: Re: [PATCH - ALSA: snd-virtuoso 1/1] Xonar DSX support
Date: Thu, 26 Sep 2013 10:07:04 +0000 (UTC)
Message-ID: <loom.20130926T115807-948@post.gmane.org>
References: <504c9632.8697320a.1336.4b37@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from plane.gmane.org (plane.gmane.org [80.91.229.3])
 by alsa0.perex.cz (Postfix) with ESMTP id 7BA5E2655FF
 for <alsa-devel@alsa-project.org>; Thu, 26 Sep 2013 12:07:24 +0200 (CEST)
Received: from list by plane.gmane.org with local (Exim 4.69)
 (envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1VP8Tj-0000Hl-Lz
 for alsa-devel@alsa-project.org; Thu, 26 Sep 2013 12:07:23 +0200
Received: from host-78-144-105-4.as13285.net ([78.144.105.4])
 by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Thu, 26 Sep 2013 12:07:23 +0200
Received: from ianclarke340 by host-78-144-105-4.as13285.net with local
 (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Thu, 26 Sep 2013 12:07:23 +0200
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

 <sgiurgiu11 <at> gmail.com> writes:

> 
> From: Sergiu Giurgiu <sgiurgiu11 <at> gmail.com>
> 
> This patch adds support for ASUS - Xonar DSX sound cards. Tested on
openSUSE 12.2 with kernel:
> Linux 3.4.6-2.10-desktop #1 SMP PREEMPT Thu Jul 26 09:36:26 UTC 2012
(641c197) x86_64 x86_64 x86_64 GNU/Linux
> Works:
>  - play sounds
>  - adjust volume on master channel.
>  - mute .
> 
> Since Xonar DS uses the same chip, everything that works for DS should
work for DSX as well.
> 
> Thank you,
> Sergiu Giurgiu.
> 
> Signed-off-by: Sergiu Giurgiu <sgiurgiu11 <at> gmail.com>
> 
> diff --git a/mirror/sound/pci/oxygen/virtuoso.c
b/mirror/sound/pci/oxygen/virtuoso.c
> index 3d71423..8104eab 100644
> --- a/mirror/sound/pci/oxygen/virtuoso.c
> +++ b/mirror/sound/pci/oxygen/virtuoso.c
>  <at>  <at>  -52,6 +52,7  <at>  <at>  static
DEFINE_PCI_DEVICE_TABLE(xonar_ids) = {
>  	{ OXYGEN_PCI_SUBID(0x1043, 0x835d) },
>  	{ OXYGEN_PCI_SUBID(0x1043, 0x835e) },
>  	{ OXYGEN_PCI_SUBID(0x1043, 0x838e) },
> +	{ OXYGEN_PCI_SUBID(0x1043, 0x8522) },
>  	{ OXYGEN_PCI_SUBID_BROKEN_EEPROM },
>  	{ }
>  };
> diff --git a/mirror/sound/pci/oxygen/xonar_wm87x6.c
b/mirror/sound/pci/oxygen/xonar_wm87x6.c
> index 63cff90..b555b62 100644
> --- a/mirror/sound/pci/oxygen/xonar_wm87x6.c
> +++ b/mirror/sound/pci/oxygen/xonar_wm87x6.c
>  <at>  <at>  -1255,7 +1255,6  <at>  <at>  static void
dump_wm87x6_registers(struct oxygen *chip,
>  }
> 
>  static const struct oxygen_model model_xonar_ds = {
> -	.shortname = "Xonar DS",
>  	.longname = "Asus Virtuoso 66",
>  	.chip = "AV200",
>  	.init = xonar_ds_init,
>  <at>  <at>  -1327,6 +1326,11  <at>  <at>  int __devinit
get_xonar_wm87x6_model(struct oxygen *chip,
>  	switch (id->subdevice) {
>  	case 0x838e:
>  		chip->model = model_xonar_ds;
> +		chip->model.shortname = "Xonar DS";
> +		break;
> +	case 0x8522:
> +		chip->model = model_xonar_ds;
> +		chip->model.shortname = "Xonar DSX";
>  		break;
>  	case 0x835e:
>  		chip->model = model_xonar_hdav_slim;

--------------------------------------------------------------------------

It appears that I need to apply this patch but I cannot understand how to do
this.
I have read that in order for the drivers to recognise the DSX card then
this patch is necessary.
Please explain where to apply it and how to compile the drivers afterwards.

Linux Mint 14, KDE, ASUS M5A78L-M motherboard with ALC887 chip. ALSA and
PulseAudio, all work together but sound quality is disappointing so I wish
to use the Xonar DSX instead.

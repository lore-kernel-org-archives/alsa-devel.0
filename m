From: Stephan Zaubzer <s.zaubzer@gmx.at>
Subject: Re: Envy24control s/pdif input bugfix
Date: Sun, 23 Sep 2007 16:30:15 +0200
Message-ID: <46F67877.5050708@gmx.at>
References: <46F67612.90103@gmx.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id EECA3103817
	for <alsa-devel@alsa-project.org>;
	Sun, 23 Sep 2007 16:30:16 +0200 (CEST)
In-Reply-To: <46F67612.90103@gmx.at>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Sorry, used diff the wrong way!
Here the correct patch:

diff -ubr alsa-tools-1.0.14/envy24control/hardware.c alsa-tools-1.0.14patch/envy24control/hardware.c
--- alsa-tools-1.0.14/envy24control/hardware.c  2007-06-04 13:27:25.000000000 +0200
+++ alsa-tools-1.0.14patch/envy24control/hardware.c     2007-09-23 15:58:53.000000000 +0200
@@ -775,7 +775,7 @@
         snd_ctl_elem_value_set_interface(volume_rate, SND_CTL_ELEM_IFACE_MIXER);
         snd_ctl_elem_value_set_name(volume_rate, "Multi Track Volume Rate");

-       if (! card_is_dmx6fire) {
+       if (card_is_dmx6fire) {
                 snd_ctl_elem_value_set_interface(spdif_input, SND_CTL_ELEM_IFACE_MIXER);
                 snd_ctl_elem_value_set_name(spdif_input, "Optical Digital Input Switch");
         } else {

Regards Stephan

Stephan Zaubzer wrote:
> Hi!
> This patch against the stable version of envy24control fixes a bug where 
> the S/Pdif input switch doesn't work on Terratec DMX 6fire cards. This 
> bug first appeared in  version 1.0.11rc3.
> 
> diff -ubr alsa-tools-1.0.14patch/envy24control/hardware.c 
> alsa-tools-1.0.14/envy24control/hardware.c
> --- alsa-tools-1.0.14patch/envy24control/hardware.c     2007-09-23 
> 15:58:53.000000000 +0200
> +++ alsa-tools-1.0.14/envy24control/hardware.c  2007-06-04 
> 13:27:25.000000000 +0200
> @@ -775,7 +775,7 @@
>          snd_ctl_elem_value_set_interface(volume_rate, 
> SND_CTL_ELEM_IFACE_MIXER);
>          snd_ctl_elem_value_set_name(volume_rate, "Multi Track Volume 
> Rate");
> 
> -       if (card_is_dmx6fire) {
> +       if (! card_is_dmx6fire) {
>                  snd_ctl_elem_value_set_interface(spdif_input, 
> SND_CTL_ELEM_IFACE_MIXER);
>                  snd_ctl_elem_value_set_name(spdif_input, "Optical 
> Digital Input Switch");
>          } else {
> 
> 
> Regards
> Stephan
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 

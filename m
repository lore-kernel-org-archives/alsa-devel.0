From: "Stefan Macher" <Stefan.Macher@web.de>
Subject: Re: ALC658 SPDIF input patch
Date: Mon, 10 Jan 2005 16:08:46 +0100
Message-ID: <1784107302@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: TakashiIwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> 
> At Sun, 9 Jan 2005 22:49:44 +0100,
> Stefan Macher wrote:
> > 
> > Hi,
> > 
> > I have made a patch to get SPDIF input working with the Realtek ALC658. 
> > Realtek has changed the meaning of the Pin47 function selection bit (MX7A bit 
> > 1 ) between ALC655 and ALC658.
> > 
> > ALC655: 0 -> external amplifier power down; 1 -> SPDIF IN
> > ALC658: 0 -> SPDIF IN; 1 -> external amplifier power down
> > 
> > 
> > Can please anybody include this into CVS.
> 
> The patch looks fine.
> 
> Could you provide a signed-off-by line and a brief summary of your
> patch to put as a changelog?  The best would be like:
> 
> 	Summary: Fix blah
> 
> 	The patch fixes the problem of the driver xxx...
> 
> 	Signed-off-by: Foo Bar <foo@bar.com>
> 
> 
> We need (prefer) to have this for each patch from contributors,
> especially for the changes to alsa-kernel tree, which will appear
> eventually in the Linux kernel tree.
> 
> 
> thanks,
> 
> Takashi
> 

Summary: Adapt SPDIF Input selection for Realtek ALC658

This fixes the SPDIF Input selection for ALC658 as Realtek has changed the meaning betweenALC655 and ALC658. 

Signed-off-by: Stefan Macher <Stefan.Macher@web.de>

-------------------------------------------------------------------------------------------------------------
 
 --- alsa-driver-1.0.8rc2/alsa-kernel/pci/ac97/ac97_patch.c      2005-01-04 
 12:01:01.000000000 +0100
 +++ alsa-driver-1.0.8rc2-alc658patch/alsa-kernel/pci/ac97/ac97_patch.c  
 2005-01-09 22:20:53.933529512 +0100
 @@ -1605,7 +1605,10 @@
 
         /* adjust default values */
         val = snd_ac97_read(ac97, 0x7a); /* misc control */
 -       val |= (1 << 1); /* spdif input pin */
 +       if(ac97->id == 0x414c4780) /* ALC658 */
 +               val &= ~(1 << 1); /* Pin 47 is spdif input pin */
 +       else /* ALC655 */
 +               val |= (1 << 1); /* Pin 47 is spdif input pin */
         val &= ~(1 << 12); /* vref enable */
         snd_ac97_write_cache(ac97, 0x7a, val);
         /* set default: spdif-in enabled,
 
__________________________________________________________
Mit WEB.DE FreePhone mit hoechster Qualitaet ab 0 Ct./Min.
weltweit telefonieren! http://freephone.web.de/?mc=021201



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt

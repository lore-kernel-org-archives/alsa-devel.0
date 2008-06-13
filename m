From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: ALSA 1.0.17rc1 release
Date: Fri, 13 Jun 2008 12:08:34 +0100
Message-ID: <200806131208.34798.gineera@aspect135.co.uk>
References: <Pine.LNX.4.61.0806061059040.1798@tm8103-a.perex-int.cz>
	<200806131116.51894.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.talktalk.net (smtp-out-2.talktalk.net [62.24.128.232])
	by alsa0.perex.cz (Postfix) with ESMTP id A80F42447D
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Jun 2008 12:58:44 +0200 (CEST)
In-Reply-To: <200806131116.51894.gineera@aspect135.co.uk>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA devel <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

On Friday 13 June 2008 11:16, I wrote:
> Build problem with released 1.0.17rc1 driver package on kernel 2.4.21-99
> (Suse9.0):
>
> Compiling all modules:
>
> ld  -r -o snd-ens1370.o ens1370.o ak4531_codec.o
> ak4531_codec.o(.modinfo+0x40): multiple definition of `__module_author'
> ens1370.o(.modinfo+0x40): first defined here
> ld: Warning: size of symbol `__module_author' changed from 79 in ens1370.o
> to 40 in ak4531_codec.o
> ak4531_codec.o(.modinfo+0x80): multiple definition of
> `__module_description' ens1370.o(.modinfo+0xa0): first defined here
> ld: Warning: size of symbol `__module_description' changed from 36 in
> ens1370.o to 48 in ak4531_codec.o
> make[1]: *** [snd-ens1370.o] Error 1
> make[1]: Leaving directory `/usr/share/alsa1.0.17rc1/alsa-driver-1.0.17rc1/
> pci'
> make: *** [compile] Error 1
>
> Compiling my usual au8820,ice1712,ymfpci:
>
> make[2]: Entering directory
> `/usr/share/alsa1.0.17rc1/alsa-driver-1.0.17rc1/ pci/ac97'
> make[2]: *** No rule to make target `ak4531_codec.c', needed by
> `ac97_codec.o'.  Stop.
> make[2]: Leaving directory `/usr/share/alsa1.0.17rc1/alsa-driver-1.0.17rc1/
> pci/ac97'
> make[1]: *** [_modsubdir_ac97] Error 2
> make[1]: Leaving directory `/usr/share/alsa1.0.17rc1/alsa-driver-1.0.17rc1/
> pci'
> make: *** [compile] Error 1

The second can be fixed with the following patch, but I don't know if it's 
correct (ie there was a typo) or just works in this case but breaks 
elsewhere.

--- pci/ac97/Makefile-orig	2008-06-06 09:54:06.000000000 +0100
+++ pci/ac97/Makefile	2008-06-13 11:47:02.000000000 +0100
@@ -6,7 +6,7 @@
 include $(SND_TOPDIR)/Makefile.conf

 clean-files := ac97_codec.c
-export-objs  := ac97_codec.o ac97_pcm.o ak4531_codec.o
+export-objs  := ac97_codec.o ac97_pcm.o

 include $(SND_TOPDIR)/alsa-kernel/pci/ac97/Makefile

Alan

From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [regression] 2.6.25-rc4 snd-es18xx broken on Alpha
Date: Wed, 12 Mar 2008 22:12:26 +0100
Message-ID: <47D8473A.3060806@keyaccess.nl>
References: <20080312203150.80E01DBA2@gherkin.frus.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060507080809010502060906"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.groni1.gr.home.nl (smtpq2.groni1.gr.home.nl
	[213.51.130.201])
	by alsa0.perex.cz (Postfix) with ESMTP id 5141F1038E9
	for <alsa-devel@alsa-project.org>; Wed, 12 Mar 2008 22:11:50 +0100 (CET)
In-Reply-To: <20080312203150.80E01DBA2@gherkin.frus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Bob Tracy <rct@frus.com>
Cc: ALSA devel <alsa-devel@alsa-project.org>, Michael Cree <mcree@orcon.net.nz>, Krzysztof Helt <krzysztof.h1@wp.pl>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, linux-alpha@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------060507080809010502060906
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

On 12-03-08 21:31, Bob Tracy wrote:

> Here is the requested list of CONFIG_ALPHA_* items for the
> 2.6.25-rc4+iommu_patch kernel with support for snd-es18xx and snd-sb8:
> 
> CONFIG_ALPHA=y
> CONFIG_ALPHA_MIATA=y
> CONFIG_ALPHA_EV5=y
> CONFIG_ALPHA_CIA=y
> CONFIG_ALPHA_EV56=y
> CONFIG_ALPHA_PYXIS=y
> CONFIG_ALPHA_SRM=y
> CONFIG_ALPHA_LEGACY_START_ADDRESS=y
> 
>>From arch/alpha/kernel/Makefile, obj-${CONFIG_ALPHA_MIATA} adds es1888.o
> as a built-in object, so yes, it's built-in.

Okay, and applying the attached just makes your sound completely dead in the 
water?

> I never noticed the init support for the ES1888 chip before...  The code
> appears to set up DMA channel 1, but does not mention anything about the
> second 16-bit DMA channel.

Indeed. It seems to init it as an sb8...

Rene.


--------------060507080809010502060906
Content-Type: text/plain;
 name="alpha_miata_no_es1888.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alpha_miata_no_es1888.diff"

diff --git a/arch/alpha/kernel/Makefile b/arch/alpha/kernel/Makefile
index dccf052..f53a3a2 100644
--- a/arch/alpha/kernel/Makefile
+++ b/arch/alpha/kernel/Makefile
@@ -77,7 +77,7 @@ obj-$(CONFIG_ALPHA_EIGER)	+= sys_eiger.o irq_i8259.o
 obj-$(CONFIG_ALPHA_JENSEN)	+= sys_jensen.o pci-noop.o irq_i8259.o
 obj-$(CONFIG_ALPHA_MARVEL)	+= sys_marvel.o 
 obj-$(CONFIG_ALPHA_MIATA)	+= sys_miata.o irq_pyxis.o irq_i8259.o \
-				   es1888.o smc37c669.o
+				   smc37c669.o
 obj-$(CONFIG_ALPHA_MIKASA)	+= sys_mikasa.o irq_i8259.o irq_srm.o
 obj-$(CONFIG_ALPHA_NAUTILUS)	+= sys_nautilus.o irq_i8259.o irq_srm.o
 obj-$(CONFIG_ALPHA_NORITAKE)	+= sys_noritake.o irq_i8259.o
diff --git a/arch/alpha/kernel/sys_miata.c b/arch/alpha/kernel/sys_miata.c
index 910b43c..5601d7e 100644
--- a/arch/alpha/kernel/sys_miata.c
+++ b/arch/alpha/kernel/sys_miata.c
@@ -236,7 +236,6 @@ miata_init_pci(void)
 {
 	cia_init_pci();
 	SMC669_Init(0); /* it might be a GL (fails harmlessly if not) */
-	es1888_init();
 }
 
 static void

--------------060507080809010502060906
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------060507080809010502060906--

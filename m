From: Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>
Subject: Re: ALSA-SOC support for OpenRD Client/Ultimate
Date: Fri, 12 Nov 2010 18:13:51 +0100
Message-ID: <877hgi31o0.fsf@lechat.rtp-net.org>
References: <4CDB9122.20706@gmail.com> <20101112165105.GE28804@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lechat.rtp-net.org (lechat.rtp-net.org [88.191.19.38])
	by alsa0.perex.cz (Postfix) with ESMTP id 9A9411038F9
	for <alsa-devel@alsa-project.org>; Fri, 12 Nov 2010 18:08:43 +0100 (CET)
In-Reply-To: <20101112165105.GE28804@sirena.org.uk> (Mark Brown's message of
	"Fri, 12 Nov 2010 16:51:05 +0000")
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "Robas, Teodor" <teodor.robas@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--=-=-=

Mark Brown <broonie@opensource.wolfsonmicro.com> writes:

Hi,

> On Thu, Nov 11, 2010 at 08:45:54AM +0200, Robas, Teodor wrote:
>
>> I am writing to this list in the hope that somebody can clear me out
>> if this platform is supported and I am doing something wrong, or if
>> it is still work in progress.

You have an OpenRD Client or Ultimate ? I'll consider you have an
Ultimate.

You need to patch some files (assuming the Ultimate as a cs42l51 at i2c
address 4a like the Client) like I did in the patch sent with this mail.

>
>> The drivers that I think should work with my hardware (OpenRD ultimate)
>> are located in sound/soc/kirkwood/*.
>
> Please remember to always CC maintainers on posts to Linux lists.  I've
> added a CC to Arnaud and not cut any text for his benefit.
>
>> Sound on this device worked (partially) with the default software
>> it came but not with the latest about 10 kernels I have tried.
>> 
>> I added bellow the output of alsa-info.sh script. If needed I can look
>> for more or try to fix it (with some help).
>> 
>> 
>> Best Regards,
>> Teodor
>> 

[...]

>> Module
>> snd_soc_kirkwood
>> snd_soc_core
>> snd_pcm
>> snd_timer
>> snd
>> snd_page_alloc
>> bridge
>> stp
>> llc
>> nfsd
>> lockd
>> nfs_acl
>> auth_rpcgss
>> sunrpc
>> exportfs
>> loop
>> xgifb
>> fb
>> cfbcopyarea
>> mv_cesa
>> cfbimgblt
>> aes_generic
>> cfbfillrect
>> sd_mod
>> crc_t10dif
>> usb_storage
>> sata_mv
>> libata
>> ehci_hcd
>> scsi_mod
>> usbcore
>> mv643xx_eth
>> libphy
>> nls_base

I don't see snd-soc-openrd.ko and snd-soc-kirkwood-i2s.ko loaded and you
need them. Also, please give kernel boot logs if the sound is still not
working with my patch and all needed modules loaded. Checking if the
codec is still a cs42l51 at 0x4a would be nice too.

Arnaud



--=-=-=
Content-Type: text/x-diff
Content-Disposition: inline; filename=ultimate.patch

Kirkwood/ASoC: Add support for OpenRD Ultimate


OpenRD Ultimate & Client are similar machines so enable OpenRD client
support on Ultimate too


Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>

Index: sound-2.6/arch/arm/mach-kirkwood/openrd-setup.c
===================================================================
--- sound-2.6.orig/arch/arm/mach-kirkwood/openrd-setup.c	2010-11-12 17:58:41.000000000 +0100
+++ sound-2.6/arch/arm/mach-kirkwood/openrd-setup.c	2010-11-12 17:59:06.000000000 +0100
@@ -94,7 +94,7 @@
 
 	kirkwood_i2c_init();
 
-	if (machine_is_openrd_client()) {
+	if (machine_is_openrd_client() || machine_is_openrd_ultimate()) {
 		i2c_register_board_info(0, i2c_board_info,
 			ARRAY_SIZE(i2c_board_info));
 		kirkwood_audio_init();
Index: sound-2.6/sound/soc/kirkwood/kirkwood-openrd.c
===================================================================
--- sound-2.6.orig/sound/soc/kirkwood/kirkwood-openrd.c	2010-11-12 17:59:17.000000000 +0100
+++ sound-2.6/sound/soc/kirkwood/kirkwood-openrd.c	2010-11-12 17:59:31.000000000 +0100
@@ -86,7 +86,7 @@
 {
 	int ret;
 
-	if (!machine_is_openrd_client())
+	if (!machine_is_openrd_client() && !machine_is_openrd_ultimate())
 		return 0;
 
 	openrd_client_snd_device = platform_device_alloc("soc-audio", -1);
Index: sound-2.6/sound/soc/kirkwood/Kconfig
===================================================================
--- sound-2.6.orig/sound/soc/kirkwood/Kconfig	2010-11-12 17:59:51.000000000 +0100
+++ sound-2.6/sound/soc/kirkwood/Kconfig	2010-11-12 18:00:27.000000000 +0100
@@ -11,7 +11,7 @@
 
 config SND_KIRKWOOD_SOC_OPENRD
 	tristate "SoC Audio support for Kirkwood Openrd Client"
-	depends on SND_KIRKWOOD_SOC && MACH_OPENRD_CLIENT
+	depends on SND_KIRKWOOD_SOC && (MACH_OPENRD_CLIENT || MACH_OPENRD_ULTIMATE)
 	select SND_KIRKWOOD_SOC_I2S
 	select SND_SOC_CS42L51
 	help

--=-=-=
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=-=-=--

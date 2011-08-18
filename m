From: Ulo Mets <umets@osa.pri.ee>
Subject: Conexant 5051 lenovo-x200 fixes
Date: Thu, 18 Aug 2011 03:45:33 +0300
Message-ID: <4E4C60AD.2090806@osa.pri.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from polaris.osa.pri.ee (polaris.osa.pri.ee [194.204.58.247])
	by alsa0.perex.cz (Postfix) with ESMTP id 7CA2A243A0
	for <alsa-devel@alsa-project.org>;
	Thu, 18 Aug 2011 02:46:13 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by polaris.osa.pri.ee (Postfix) with ESMTP id 08B1D6E693
	for <alsa-devel@alsa-project.org>;
	Thu, 18 Aug 2011 03:46:12 +0300 (EEST)
Received: from polaris.osa.pri.ee ([127.0.0.1])
	by localhost (osa.pri.ee [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id o9L38pWpxZnx for <alsa-devel@alsa-project.org>;
	Thu, 18 Aug 2011 03:45:40 +0300 (EEST)
Received: from [192.168.1.23] (88-196-140-95-dsl.rpl.estpak.ee [88.196.140.95])
	(using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
	(Client did not present a certificate)
	by polaris.osa.pri.ee (Postfix) with ESMTPSA id 1E86D6E661
	for <alsa-devel@alsa-project.org>;
	Thu, 18 Aug 2011 03:45:40 +0300 (EEST)
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

Hi,
I am not a kernel developer, but occasionally dig into it if something gets in my way.
On Lenovo X200 Tablet none of the mixers showed Mic Boost adjustments, but HDA-Analyzer found them
and adjusted properly. So I inserted the corresponding controls, and it worked.
Then, during testing I found that the labels of External and Docking Mic are swapped,
so I exchanged these too. Since I could not test it on other hardware, I put it all on lenovo-x200 branch.
The patch applies to 3.1-rc2, I hope it is sufficiently recent.
The Mic Switches don't have any effect on my unit (X200T without modem)

With best regards,

Ulo Mets

Signed-off-by: Ulo Mets<umets at osa.pri.ee>

---b/sound/pci/hda/patch_conexant.c	2011-08-01 12:45:32.302640276 +0300
+++ a/sound/pci/hda/patch_conexant.c	2011-08-01 12:50:22.003141176 +0300
@@ -1785,6 +1785,19 @@
  	{}
  };

+static const struct snd_kcontrol_new cxt5051_lenovo_x200_mixers[] = {
+	HDA_CODEC_VOLUME("Int Mic Volume", 0x14, 0x00, HDA_INPUT),
+	HDA_CODEC_MUTE("Int Mic Switch", 0x14, 0x00, HDA_INPUT),
+	HDA_CODEC_VOLUME("Dock Mic Volume", 0x14, 0x01, HDA_INPUT),
+	HDA_CODEC_MUTE("Dock Mic Switch", 0x14, 0x01, HDA_INPUT),
+	HDA_CODEC_VOLUME("Ext Mic Volume", 0x15, 0x00, HDA_INPUT),
+	HDA_CODEC_MUTE("Ext Mic Switch", 0x15, 0x00, HDA_INPUT),
+	HDA_CODEC_VOLUME("Int Mic Boost", 0x1d, 0x00, HDA_INPUT),
+	HDA_CODEC_VOLUME("Dock Mic Boost", 0x17, 0x00, HDA_INPUT),
+	HDA_CODEC_VOLUME("Ext Mic Boost", 0x18, 0x00, HDA_INPUT),
+	{}
+};
+
  static const struct snd_kcontrol_new cxt5051_hp_mixers[] = {
  	HDA_CODEC_VOLUME("Internal Mic Volume", 0x14, 0x00, HDA_INPUT),
  	HDA_CODEC_MUTE("Internal Mic Switch", 0x14, 0x00, HDA_INPUT),
@@ -2055,6 +2079,7 @@
  		break;
  	case CXT5051_LENOVO_X200:
  		spec->init_verbs[0] = cxt5051_lenovo_x200_init_verbs;
+		spec->mixers[0] = cxt5051_lenovo_x200_mixers;
  		/* Thinkpad X301 does not have S/PDIF wired and no ability
  		   to use a docking station. */
  		if (codec->subsystem_id == 0x17aa211f)

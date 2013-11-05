From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [Alsa-user] hdmi sound rerouted?
Date: Tue, 05 Nov 2013 09:27:10 +0100
Message-ID: <5278ABDE.3030006@ladisch.de>
References: <20131104185343.215740@gmx.com> <s5hvc07fhgn.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id 58C42265072
 for <alsa-devel@alsa-project.org>; Tue,  5 Nov 2013 09:27:13 +0100 (CET)
In-Reply-To: <s5hvc07fhgn.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, alsa-user@lists.sourceforge.net, Dagg Stompler <daggs@gmx.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> You wanted to play back via this HDMI and it didn't work?

The ATI card did not show up as "ATI", but the other ATI card without
HDMI did: <http://thread.gmane.org/gmane.linux.alsa.user/37732>.

Anyway, let's close this thread:

--8<---------------------------------------------------------------->8--
ALSA: hda: add device IDs for AMD Evergreen/Northern Islands HDMI

The device IDs of the AMD Cypress/Juniper/Redwood/Cedar/Cayman/Antilles/
Barts/Turks/Caicos HDMI HDA controllers were missing for some reason.
Add them so that the name shows up properly as "ATI HDMI" instead of
"Generic", and so that the driver does not try to detect nonexistent
codecs.

According to Takashi's tests and the lack of complaints, these devices
work fine without disabling snooping.

Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -4079,6 +4079,22 @@
 	  .driver_data = AZX_DRIVER_ATIHDMI | AZX_DCAPS_PRESET_ATI_HDMI },
 	{ PCI_DEVICE(0x1002, 0xaa48),
 	  .driver_data = AZX_DRIVER_ATIHDMI | AZX_DCAPS_PRESET_ATI_HDMI },
+	{ PCI_DEVICE(0x1002, 0xaa50),
+	  .driver_data = AZX_DRIVER_ATIHDMI | AZX_DCAPS_PRESET_ATI_HDMI },
+	{ PCI_DEVICE(0x1002, 0xaa58),
+	  .driver_data = AZX_DRIVER_ATIHDMI | AZX_DCAPS_PRESET_ATI_HDMI },
+	{ PCI_DEVICE(0x1002, 0xaa60),
+	  .driver_data = AZX_DRIVER_ATIHDMI | AZX_DCAPS_PRESET_ATI_HDMI },
+	{ PCI_DEVICE(0x1002, 0xaa68),
+	  .driver_data = AZX_DRIVER_ATIHDMI | AZX_DCAPS_PRESET_ATI_HDMI },
+	{ PCI_DEVICE(0x1002, 0xaa80),
+	  .driver_data = AZX_DRIVER_ATIHDMI | AZX_DCAPS_PRESET_ATI_HDMI },
+	{ PCI_DEVICE(0x1002, 0xaa88),
+	  .driver_data = AZX_DRIVER_ATIHDMI | AZX_DCAPS_PRESET_ATI_HDMI },
+	{ PCI_DEVICE(0x1002, 0xaa90),
+	  .driver_data = AZX_DRIVER_ATIHDMI | AZX_DCAPS_PRESET_ATI_HDMI },
+	{ PCI_DEVICE(0x1002, 0xaa98),
+	  .driver_data = AZX_DRIVER_ATIHDMI | AZX_DCAPS_PRESET_ATI_HDMI },
 	{ PCI_DEVICE(0x1002, 0x9902),
 	  .driver_data = AZX_DRIVER_ATIHDMI_NS | AZX_DCAPS_PRESET_ATI_HDMI },
 	{ PCI_DEVICE(0x1002, 0xaaa0),

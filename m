From: Gregorio Guidi <gregorio.guidi@gmail.com>
Subject: [PATCH] fix headphone settings and master volume
	(Conexant CX20551 0x103c30b2)
Date: Sun, 8 Mar 2009 21:19:41 +0100
Message-ID: <200903082119.41670.gregorio.guidi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay2.tre.it (mail.tre.it [62.13.171.46])
	by alsa0.perex.cz (Postfix) with ESMTP id ACB9424355
	for <alsa-devel@alsa-project.org>; Sun,  8 Mar 2009 21:20:57 +0100 (CET)
Received: from miummr0mt01.um.ced.h3g.it ([10.216.58.129])
	by relay2.tre.it  with ESMTP id n28KKtQF018659
	for <alsa-devel@alsa-project.org>; Sun, 8 Mar 2009 21:20:55 +0100
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi, I have an Intel HDA card, Conexant CX20551 (Waikiki) model,
Subsystem Id: 0x103c30b2 (HP DV2000 series).

With these settings, there are 4 volume controls: "PCM-2" and "Speaker" to 
control speakers, "PCM" and "Headphone" to control headphones.
At the moment "PCM-2", "Speaker", "PCM" work fine, but "Headphone" has no effect 
(also reported inside bug #3091).

With the following patch, the "Headphone" volume/switch work 
as intended, with no effect on other functionalities.

--- patch_conexant.c    2009-03-08 21:10:14.000000000 +0100
+++ patch_conexant.c.new        2009-03-08 21:09:51.000000000 +0100
@@ -1357,7 +1357,7 @@
        {0x17, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN|AC_PINCTL_VREF_50 },
        /* HP, Speaker  */
        {0x13, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_HP },
-       {0x13, AC_VERB_SET_CONNECT_SEL,0x1},
+       {0x13, AC_VERB_SET_CONNECT_SEL,0x0},
        {0x1d, AC_VERB_SET_CONNECT_SEL,0x0},
        /* Record selector: Mic */
        {0x12, AC_VERB_SET_CONNECT_SEL,0x03},


Also, there is no "Master" control to set the volume for both speakers and 
headphones. The patch below adds a master volume (and a master 
switch) that work ok for me. By the way, with the patch the light on the mute 
button changes between blue and red, which is a nice plus.

--- patch_conexant.c    2009-03-08 21:11:14.000000000 +0100
+++ patch_conexant.c.new        2009-03-08 21:11:01.000000000 +0100
@@ -1293,6 +1293,15 @@
        HDA_CODEC_MUTE("Speaker Playback Switch", 0x1d, 0x00, HDA_OUTPUT),
        HDA_CODEC_VOLUME("Headphone Playback Volume", 0x13, 0x00, HDA_OUTPUT),
        HDA_CODEC_MUTE("Headphone Playback Switch", 0x13, 0x00, HDA_OUTPUT),
+       HDA_BIND_VOL("Master Playback Volume", &cxt5047_bind_master_vol),
+       {
+               .iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+               .name = "Master Playback Switch",
+               .info = cxt_eapd_info,
+               .get = cxt_eapd_get,
+               .put = cxt5047_hp_master_sw_put,
+               .private_value = 0x13,
+       },

        {}
 };


I am no expert of Conexant hardware and I don't know if those changes are 
correct for all the devices that share the same code (the 103c:30xx), but 
I'm confident that they are the right ones for the 103c:30b2 device.

Can someone take a look? Thanks.

Gregorio Guidi

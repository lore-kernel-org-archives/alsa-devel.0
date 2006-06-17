From: "Nick Lloyd" <ultrageek.lloyd@gmail.com>
Subject: [PATCH - ca0106] add mixer controls to ca0106
Date: Fri, 16 Jun 2006 19:31:42 -0700
Message-ID: <4c46196d0606161931l645ca9d6r7c2a228dddc597e3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This patch adds a master volume/mute and routing controls for ca0106
cards without the ac97.  This gives the advantage of being able to
control the volume of all speakers from an application like MPlayer,
and to be able to play stereo audio on a surround sound setup.

Signed-off by: Nickolas Lloyd <ultrageek.lloyd@gmail.com>

I'm new to this whole thing so I'd be very receptive to feedback/criticism :)
----


diff -uprN alsa-driver-1.0.11-vanilla/alsa-kernel/pci/ca0106/ca0106.h
alsa-driver-1.0.11/alsa-kernel/pci/ca0106/ca0106.h
--- alsa-driver-1.0.11-vanilla/alsa-kernel/pci/ca0106/ca0106.h
2006-04-09 07:46:52.000000000 -0400
+++ alsa-driver-1.0.11/alsa-kernel/pci/ca0106/ca0106.h    2006-06-16
18:03:01.000000000 -0400
@@ -586,6 +586,7 @@ struct snd_ca0106 {
     struct snd_ca0106_details *details;
     struct pci_dev *pci;

+    long master_volume[2];
     unsigned long port;
     struct resource *res_port;
     int irq;
diff -uprN alsa-driver-1.0.11-vanilla/alsa-kernel/pci/ca0106/ca0106_main.c
alsa-driver-1.0.11/alsa-kernel/pci/ca0106/ca0106_main.c
--- alsa-driver-1.0.11-vanilla/alsa-kernel/pci/ca0106/ca0106_main.c
2006-04-09 15:46:09.000000000 -0400
+++ alsa-driver-1.0.11/alsa-kernel/pci/ca0106/ca0106_main.c
2006-06-16 18:03:01.000000000 -0400
@@ -1435,6 +1435,8 @@ static int __devinit snd_ca0106_create(s
         snd_ca0106_free(chip);
         return err;
     }
+
+    memset(&chip->master_volume, 0, sizeof(chip->master_volume));
     *rchip = chip;
     return 0;
 }
diff -uprN alsa-driver-1.0.11-vanilla/alsa-kernel/pci/ca0106/ca0106_mixer.c
alsa-driver-1.0.11/alsa-kernel/pci/ca0106/ca0106_mixer.c
--- alsa-driver-1.0.11-vanilla/alsa-kernel/pci/ca0106/ca0106_mixer.c
 2006-04-09 15:46:09.000000000 -0400
+++ alsa-driver-1.0.11/alsa-kernel/pci/ca0106/ca0106_mixer.c
2006-06-16 18:03:01.000000000 -0400
@@ -409,6 +409,174 @@ static int snd_ca0106_volume_put(struct
     return 1;
 }

+static int snd_ca0106_mute_analog_master_info(struct snd_kcontrol * kcontrol,
+                    struct snd_ctl_elem_info * uinfo)
+{
+    uinfo->count = 1;
+    uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
+    uinfo->value.integer.min = 0;
+    uinfo->value.integer.max = 1;
+    return 0;
+}
+
+static int snd_ca0106_mute_analog_master_get(struct snd_kcontrol * kcontrol,
+                    struct snd_ctl_elem_value * ucontrol)
+{
+    struct snd_ca0106 *emu = snd_kcontrol_chip(kcontrol);
+    unsigned long flags;
+    unsigned int muted;
+
+    spin_lock_irqsave(&emu->emu_lock, flags);
+    muted = inl(emu->port + GPIO) & 0x00004200;
+    spin_unlock_irqrestore(&emu->emu_lock, flags);
+    if(muted == 0x4200) ucontrol->value.integer.value[0] = 1;
+    else ucontrol->value.integer.value[0] = 0;
+    return 0;
+}
+
+static int snd_ca0106_mute_analog_master_put(struct snd_kcontrol * kcontrol,
+                    struct snd_ctl_elem_value * ucontrol)
+{
+    struct snd_ca0106 *emu = snd_kcontrol_chip(kcontrol);
+    unsigned long flags;
+    unsigned int muted;
+
+    spin_lock_irqsave(&emu->emu_lock, flags);
+    muted = inl(emu->port + GPIO) & 0x00004200;
+    if(muted == 0x000 && ucontrol->value.integer.value[0] == 1)
+        outl((inl(emu->port + GPIO) | 0x00004200), emu->port + GPIO);
+    else if(muted == 0x4200 && ucontrol->value.integer.value[0] == 0)
+        outl((inl(emu->port + GPIO) & 0xffffbdff), emu->port + GPIO);
+    spin_unlock_irqrestore(&emu->emu_lock, flags);
+    return 0;
+}
+
+static int snd_ca0106_volume_get_analog_master(struct snd_kcontrol * kcontrol,
+                    struct snd_ctl_elem_value * ucontrol)
+{
+    struct snd_ca0106 *emu = snd_kcontrol_chip(kcontrol);
+    ucontrol->value.integer.value[0] = emu->master_volume[0];
+    ucontrol->value.integer.value[1] = emu->master_volume[1];
+    return 0;
+}
+
+static int snd_ca0106_volume_put_analog_master(struct snd_kcontrol * kcontrol,
+                    struct snd_ctl_elem_value * ucontrol)
+{
+    struct snd_ca0106 *emu = snd_kcontrol_chip(kcontrol);
+    unsigned int value;
+    long volume[2];
+    int channel_id;
+    unsigned int reg;
+    struct snd_ctl_elem_value ucontrol_channel_id;
+
+    memset(&ucontrol_channel_id, 0, sizeof(ucontrol_channel_id));
+    reg = (emu->spdif_enable) ? PLAYBACK_VOLUME1 : PLAYBACK_VOLUME2;
+    for (channel_id = 0; channel_id < 4; channel_id++) {
+        kcontrol->private_value = ((channel_id) << 8) | (reg);
+        snd_ca0106_volume_get(kcontrol, &ucontrol_channel_id);
+        volume[0] = (ucontrol->value.integer.value[0] -
+            emu->master_volume[0]) +
+            ucontrol_channel_id.value.integer.value[0];
+        volume[1] = (ucontrol->value.integer.value[1] -
+        emu->master_volume[1]) +
+        ucontrol_channel_id.value.integer.value[1];
+        if(volume[0] < 0) volume[0] = 0;
+        if(volume[1] < 0) volume[1] = 0;
+        value = ((0xff - volume[0]) << 24) | ((0xff - volume[1]) << 16);
+        value = value | ((0xff - volume[0]) << 8) | ((0xff - volume[1]));
+        snd_ca0106_ptr_write(emu, reg, channel_id, value);
+    }
+    emu->master_volume[0] = ucontrol->value.integer.value[0];
+    emu->master_volume[1] = ucontrol->value.integer.value[1];
+    return 1;
+}
+
+static int snd_ca0106_routing_analog_info(struct snd_kcontrol * kcontrol,
+                    struct snd_ctl_elem_info * uinfo)
+{
+    static char *texts[4] = { "Front Output", "Center/LFE Output",
+                    "Side Output", "Rear Output" };
+
+    uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
+    uinfo->count = 1;
+    uinfo->value.enumerated.items = 4;
+    if(uinfo->value.enumerated.item > 3)
+        uinfo->value.enumerated.item = 3;
+    strcpy(uinfo->value.enumerated.name,
+        texts[uinfo->value.enumerated.item]);
+    return 0;
+}
+
+static int snd_ca0106_routing_analog_get(struct snd_kcontrol * kcontrol,
+                    struct snd_ctl_elem_value * ucontrol)
+{
+    struct snd_ca0106 *emu = snd_kcontrol_chip(kcontrol);
+
+    unsigned int route = snd_ca0106_ptr_read(emu, CAPTURE_ROUTING1, 0);
+    unsigned int route_mask;
+    unsigned int shift;
+    if(kcontrol->private_value == CONTROL_FRONT_CHANNEL) {
+        route_mask = 0xff;
+        shift = 0;
+    }
+    else if(kcontrol->private_value == CONTROL_CENTER_LFE_CHANNEL) {
+        route_mask = 0xff00;
+        shift = 8;
+    }
+    else if(kcontrol->private_value == CONTROL_UNKNOWN_CHANNEL) {
+        route_mask = 0xff0000;
+        shift = 16;
+    }
+    else if(kcontrol->private_value == CONTROL_REAR_CHANNEL) {
+        route_mask = 0xff000000;
+        shift = 24;
+    }
+    else return 0;
+    route = (route & route_mask) >> shift;
+    if(route == 0x10) ucontrol->value.enumerated.item[0] = 0;
+    else if(route == 0x54) ucontrol->value.enumerated.item[0] = 1;
+    else if(route == 0x76) ucontrol->value.enumerated.item[0] = 2;
+    else if(route == 0x32) ucontrol->value.enumerated.item[0] = 3;
+    return 0;
+}
+
+static int snd_ca0106_routing_analog_put(struct snd_kcontrol * kcontrol,
+                    struct snd_ctl_elem_value * ucontrol)
+{
+    struct snd_ca0106 *emu = snd_kcontrol_chip(kcontrol);
+
+    unsigned int route = snd_ca0106_ptr_read(emu, CAPTURE_ROUTING1, 0);
+    unsigned int route_mask;
+    unsigned int shift;
+    if(kcontrol->private_value == CONTROL_FRONT_CHANNEL) {
+        route_mask = 0xffffff00;
+        shift = 0;
+    }
+    else if(kcontrol->private_value == CONTROL_CENTER_LFE_CHANNEL) {
+        route_mask = 0xffff00ff;
+        shift = 8;
+    }
+    else if(kcontrol->private_value == CONTROL_UNKNOWN_CHANNEL) {
+        route_mask = 0xff00ffff;
+        shift = 8;
+    }
+    else if(kcontrol->private_value == CONTROL_REAR_CHANNEL) {
+        route_mask = 0x00ffffff;
+        shift = 24;
+    }
+    else return 0;
+    if(ucontrol->value.enumerated.item[0] == 0) route = (route &
route_mask) | (0x10 << shift);
+    else if(ucontrol->value.enumerated.item[0] == 1) route = (route &
route_mask) | (0x54 << shift);
+    else if(ucontrol->value.enumerated.item[0] == 2) route = (route &
route_mask) | (0x76 << shift);
+    else if(ucontrol->value.enumerated.item[0] == 3) route = (route &
route_mask) | (0x32 << shift);
+    else route = (route & route_mask) | (0x10 << shift);
+    snd_ca0106_ptr_write(emu, CAPTURE_ROUTING1, 0, route);
+    return 0;
+}
+
+
+
 static int snd_ca0106_i2c_volume_info(struct snd_kcontrol *kcontrol,
                   struct snd_ctl_elem_info *uinfo)
 {
@@ -475,6 +643,15 @@ static int snd_ca0106_i2c_volume_put(str
     .private_value = ((chid) << 8) | (reg)            \
 }

+#define CA_ROUTING(xname,chid) \
+{                                \
+    .iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname,    \
+    .info =  snd_ca0106_routing_analog_info,        \
+    .get =   snd_ca0106_routing_analog_get,            \
+    .put =   snd_ca0106_routing_analog_put,            \
+    .private_value = chid                    \
+}
+
 #define I2C_VOLUME(xname,chid) \
 {                                \
     .iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname,    \
@@ -484,6 +661,26 @@ static int snd_ca0106_i2c_volume_put(str
     .private_value = chid                    \
 }

+static struct snd_kcontrol_new snd_ca0106_routing_ctls[] __devinitdata = {
+    {
+        .iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+        .name = "Master Playback Volume",
+        .info = snd_ca0106_volume_info,
+        .get = snd_ca0106_volume_get_analog_master,
+        .put = snd_ca0106_volume_put_analog_master
+    },
+    {
+        .iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+        .name = "Master Playback Switch",
+        .info = snd_ca0106_mute_analog_master_info,
+        .get = snd_ca0106_mute_analog_master_get,
+        .put = snd_ca0106_mute_analog_master_put
+    },
+    CA_ROUTING("Front Jack Playback Route", CONTROL_FRONT_CHANNEL),
+    CA_ROUTING("Center/LFE Jack Playback Route", CONTROL_CENTER_LFE_CHANNEL),
+    CA_ROUTING("Side Jack Playback Route", CONTROL_UNKNOWN_CHANNEL),
+    CA_ROUTING("Rear Jack Playback Route", CONTROL_REAR_CHANNEL)
+};

 static struct snd_kcontrol_new snd_ca0106_volume_ctls[] __devinitdata = {
     CA_VOLUME("Analog Front Playback Volume",
@@ -629,6 +826,13 @@ int __devinit snd_ca0106_mixer(struct sn
         rename_ctl(card, c[0], c[1]);
 #endif

+    if(emu->details->ac97 != 1) {
+        for(i = 0; i < ARRAY_SIZE(snd_ca0106_routing_ctls); i++) {
+            err = snd_ctl_add(card,
snd_ctl_new1(&snd_ca0106_routing_ctls[i], emu));
+            if (err < 0)
+                return err;
+        }
+    }
     for (i = 0; i < ARRAY_SIZE(snd_ca0106_volume_ctls); i++) {
         err = snd_ctl_add(card, snd_ctl_new1(&snd_ca0106_volume_ctls[i], emu));
         if (err < 0)

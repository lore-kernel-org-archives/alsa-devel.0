From: Daniel Jacobowitz <drow@false.org>
Subject: Ganged volume
Date: Sat, 14 Oct 2006 16:37:37 -0400
Message-ID: <20061014203737.GA22315@nevyn.them.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="FL5UXtIhxfXey3p5"
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


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Here's an implementation of a ganged volume control.  I suspect it
could be improved with advice from a maintainer; I'm happy to revise
it.  It works in every way I've been able to test it.  I suspect plenty
of other devices could benefit from this; probably even some not AC97
based, so maybe it ought to move elsewhere, but at least it's a start.

What do you think of it?

-- 
Daniel Jacobowitz
CodeSourcery

--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="combined-gang.patch"

Implement a ganged volume control for VT1617A.

This patch renamed the existing Master volume controls to Front, and
implements a single control which adjusts all of Front, Surround, Center,
and LFE, allowing uniform volume control.  It is only wired up for the
VT1617A, but should be useful elsewhere.

It also fixes a bug I noticed in the handling of user-defined boolean
controls; they should use the same storage as integer controls.

Signed-off-by: Daniel Jacobowitz <drow@false.org>

diff --git a/sound/core/control.c b/sound/core/control.c
index 6973a96..48ef0a0 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -1018,10 +1018,6 @@ static int snd_ctl_elem_add(struct snd_c
 	}
 	switch (info->type) {
 	case SNDRV_CTL_ELEM_TYPE_BOOLEAN:
-		private_size = sizeof(char);
-		if (info->count > 128)
-			return -EINVAL;
-		break;
 	case SNDRV_CTL_ELEM_TYPE_INTEGER:
 		private_size = sizeof(long);
 		if (info->count > 128)
diff --git a/sound/pci/ac97/ac97_codec.c b/sound/pci/ac97/ac97_codec.c
index a79e918..d2d33a7 100644
--- a/sound/pci/ac97/ac97_codec.c
+++ b/sound/pci/ac97/ac97_codec.c
@@ -2590,6 +2590,271 @@ int snd_ac97_swap_ctl(struct snd_ac97 *a
 	return -ENOENT;
 }
 
+static int snd_ac97_gang_info(struct snd_kcontrol *kcontrol,
+			      struct snd_ctl_elem_info *uinfo)
+{
+	struct ac97_gang *gang;
+	struct ac97_gang_member *gang_member;
+	int ret;
+
+	/* Just return info for the first member...  */
+	gang = (struct ac97_gang *)kcontrol->private_value;
+	BUG_ON (list_empty(&gang->members));
+	list_for_each_entry(gang_member, &gang->members, list)
+		break;
+	ret = gang_member->orig->info(gang_member->orig, uinfo);
+
+	/* ...except always mono.  */
+	uinfo->count = 1;
+	return ret;
+}
+
+static int snd_ac97_gang_get(struct snd_kcontrol *kcontrol,
+			     struct snd_ctl_elem_value *ucontrol)
+{
+	struct ac97_gang *gang;
+
+	gang = (struct ac97_gang *)kcontrol->private_value;
+	ucontrol->value.integer.value[0] = gang->value;
+	return 0;
+}
+
+static int snd_ac97_gang_put(struct snd_kcontrol *kcontrol,
+			     struct snd_ctl_elem_value *ucontrol)
+{
+	struct ac97_gang *gang;
+	struct ac97_gang_member *gang_member;
+	int err, ret;
+
+	gang = (struct ac97_gang *)kcontrol->private_value;
+	ret = (gang->value != ucontrol->value.integer.value[0]);
+	gang->value = ucontrol->value.integer.value[0];
+
+	/* Update all the affected controls.  */
+	list_for_each_entry(gang_member, &gang->members, list) {
+		if ((err = gang_member->member->get (gang_member->member, ucontrol)) < 0)
+			return err;
+		if ((err = gang_member->member->put (gang_member->member, ucontrol)) < 0)
+			return err;
+	}
+	return ret;
+}
+
+static struct snd_kcontrol *snd_ac97_gang_new(char *name, struct snd_ac97 *ac97)
+{
+	struct snd_kcontrol_new template;
+	struct ac97_gang *gang;
+	struct snd_kcontrol *ret;
+
+	gang = kzalloc(sizeof(struct ac97_gang), GFP_KERNEL);
+	if (gang == NULL)
+		return NULL;
+	INIT_LIST_HEAD(&gang->members);
+	gang->min = gang->max = -1;
+
+	memset(&template, 0, sizeof(template));
+	template.iface = SNDRV_CTL_ELEM_IFACE_MIXER;
+	template.name = name;
+	template.index = ac97->num;
+	template.private_value = (unsigned long) gang;
+	template.info = snd_ac97_gang_info;
+	template.get = snd_ac97_gang_get;
+	template.put = snd_ac97_gang_put;
+
+	ret = snd_ctl_new1(&template, ac97);
+	if (ret == NULL)
+		kfree(gang);
+	return ret;
+}
+
+static int snd_ac97_gang_member_info(struct snd_kcontrol *kcontrol,
+				     struct snd_ctl_elem_info *uinfo)
+{
+	struct ac97_gang_member *gang_member;
+
+	gang_member = (struct ac97_gang_member *)kcontrol->private_value;
+	return gang_member->orig->info(gang_member->orig, uinfo);
+}
+
+static int snd_ac97_gang_member_get(struct snd_kcontrol *kcontrol,
+				    struct snd_ctl_elem_value *ucontrol)
+{
+	struct ac97_gang_member *gang_member;
+	int i;
+
+	gang_member = (struct ac97_gang_member *)kcontrol->private_value;
+	for (i = 0; i < gang_member->count; i++)
+		ucontrol->value.integer.value[i] = gang_member->values[i];
+	return 0;
+}
+
+static int snd_ac97_gang_member_put(struct snd_kcontrol *kcontrol,
+				    struct snd_ctl_elem_value *ucontrol)
+{
+	struct ac97_gang_member *gang_member;
+	int i, ret = 0, err;
+
+	gang_member = (struct ac97_gang_member *)kcontrol->private_value;
+	for (i = 0; i < gang_member->count; i++) {
+		long new_value = ucontrol->value.integer.value[i];
+
+		/* Save the new value.  */
+		ret |= (gang_member->values[i] != new_value);
+		gang_member->values[i] = new_value;
+
+		/* Adjust by the master value (always towards quieter
+		   or muted).  */
+		new_value += gang_member->leader->value;
+		new_value -= gang_member->leader->max;
+
+		/* Clip.  */
+		if (new_value < gang_member->min)
+			new_value = gang_member->min;
+		if (new_value > gang_member->max)
+			new_value = gang_member->max;
+
+		ucontrol->value.integer.value[i] = new_value;
+	}
+	err = gang_member->orig->put(gang_member->orig, ucontrol);
+	return (err < 0) ? err : ret;
+}
+
+static int snd_ac97_gang_add(struct snd_kcontrol *master, struct snd_kcontrol *member)
+{
+	struct snd_ac97 *ac97 = snd_kcontrol_chip(master);
+	struct ac97_gang *leader = (struct ac97_gang *)master->private_value;
+	struct ac97_gang_member *gang_member;
+	struct snd_kcontrol *orig_member;
+	struct snd_ctl_elem_value *val;
+	struct snd_ctl_elem_info *info;
+	unsigned int size;
+	int i, err, count;
+	long min, max;
+
+	info = kzalloc(sizeof(*info), GFP_KERNEL);
+	if (info == NULL)
+		goto out;
+	if (member->info(member, info) < 0) {
+		kfree (info);
+		goto out;
+	}
+	BUG_ON(info->type != SNDRV_CTL_ELEM_TYPE_BOOLEAN &&
+	       info->type != SNDRV_CTL_ELEM_TYPE_INTEGER);
+	min = info->value.integer.min;
+	max = info->value.integer.max;
+	count = info->count;
+	kfree(info);
+
+	val = kzalloc(sizeof(*val), GFP_KERNEL);
+	if (val == NULL)
+		goto out;
+	val->id = member->id;
+	err = snd_ctl_elem_read(ac97->bus->card, val);
+	if (err < 0)
+		goto out_value;
+
+	size = sizeof(*gang_member) + sizeof(long) * count;
+	gang_member = kzalloc(size, GFP_KERNEL);
+	if (gang_member == NULL)
+		goto out_value;
+
+	orig_member = snd_ctl_new(member, 0);
+	if (orig_member == NULL)
+		goto out_gang;
+
+	list_add_tail(&gang_member->list, &leader->members);
+	if (leader->min == -1) {
+		leader->min = min;
+		leader->max = max;
+	}
+
+	gang_member->leader = leader;
+	gang_member->member = member;
+	gang_member->orig = orig_member;
+	gang_member->min = min;
+	gang_member->max = max;
+	gang_member->count = count;
+
+	for (i = 0; i < count; i++) {
+		gang_member->values[i] = val->value.integer.value[i];
+	}
+	kfree (val);
+
+	member->private_value = (unsigned long)gang_member;
+	member->info = snd_ac97_gang_member_info;
+	member->get = snd_ac97_gang_member_get;
+	member->put = snd_ac97_gang_member_put;
+	return 0;
+
+ out_gang:
+	kfree(gang_member);
+ out_value:
+	kfree(val);
+ out:
+	return -ENOMEM;
+}
+
+int snd_ac97_gang_volume(struct snd_ac97 *ac97)
+{
+	static const char *names[] = {
+		"Front",
+		"Surround",
+		"Center",
+		"LFE"
+	};
+	struct snd_kcontrol *master;
+	int any, err, i;
+
+	/* Is there already a misnamed master switch?  Rename it.  */
+	snd_ac97_rename_vol_ctl(ac97, "Master Playback", "Front Playback");
+
+	/* Create some new ganged controls.  */
+	master = snd_ac97_gang_new("Master Playback Volume", ac97);
+	if (master == NULL)
+		return -ENOMEM;
+	for (i = 0; i < ARRAY_SIZE(names); i++) {
+		struct snd_kcontrol *member;
+		member = ctl_find(ac97, names[i], "Playback Volume");
+		if (member == NULL)
+			continue;
+
+		err = snd_ac97_gang_add(master, member);
+		if (err)
+			return err;
+		any = 1;
+	}
+	if (any) {
+		err = snd_ctl_add(ac97->bus->card, master);
+		if (err)
+			return err;
+	} else
+		snd_ctl_free_one(master);
+
+	any = 0;
+	master = snd_ac97_gang_new("Master Playback Switch", ac97);
+	if (master == NULL)
+		return -ENOMEM;
+	for (i = 0; i < ARRAY_SIZE(names); i++) {
+		struct snd_kcontrol *member;
+		member = ctl_find(ac97, names[i], "Playback Switch");
+		if (member == NULL)
+			continue;
+
+		err = snd_ac97_gang_add(master, member);
+		if (err)
+			return err;
+		any = 1;
+	}
+	if (any) {
+		err = snd_ctl_add(ac97->bus->card, master);
+		if (err)
+			return err;
+	} else
+		snd_ctl_free_one(master);
+
+	return 0;
+}
+
 #if 1
 /* bind hp and master controls instead of using only hp control */
 static int bind_hp_volsw_put(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
diff --git a/sound/pci/ac97/ac97_local.h b/sound/pci/ac97/ac97_local.h
index a6244c7..c1b529d 100644
--- a/sound/pci/ac97/ac97_local.h
+++ b/sound/pci/ac97/ac97_local.h
@@ -56,6 +56,21 @@ #define AC97_ENUM(xname, xenum) \
   .get = snd_ac97_get_enum_double, .put = snd_ac97_put_enum_double, \
   .private_value = (unsigned long)&xenum }
 
+/* ganged control */
+struct ac97_gang {
+	struct list_head members;
+	long min, max;
+	long value;
+};
+
+struct ac97_gang_member {
+	struct list_head list;
+	struct ac97_gang *leader;
+	struct snd_kcontrol *member, *orig;
+	long min, max, count;
+	long values[0];
+};
+
 /* ac97_codec.c */
 extern const struct snd_kcontrol_new snd_ac97_controls_3d[];
 extern const struct snd_kcontrol_new snd_ac97_controls_spdif[];
@@ -78,6 +93,8 @@ int snd_ac97_put_enum_double(struct snd_
 int snd_ac97_update_bits_nolock(struct snd_ac97 *ac97, unsigned short reg,
 				unsigned short mask, unsigned short value);
 
+int snd_ac97_gang_volume(struct snd_ac97 *ac97);
+
 /* ac97_proc.c */
 #ifdef CONFIG_PROC_FS
 void snd_ac97_bus_proc_init(struct snd_ac97_bus * ac97);
diff --git a/sound/pci/ac97/ac97_patch.c b/sound/pci/ac97/ac97_patch.c
index 15be6ba..1c48a1e 100644
--- a/sound/pci/ac97/ac97_patch.c
+++ b/sound/pci/ac97/ac97_patch.c
@@ -2794,6 +2794,8 @@ static int patch_vt1616_specific(struct 
 			return err;
 	if ((err = patch_build_controls(ac97, &snd_ac97_controls_vt1616[1], ARRAY_SIZE(snd_ac97_controls_vt1616) - 1)) < 0)
 		return err;
+	if ((err = snd_ac97_gang_volume(ac97) < 0))
+		return err;
 	return 0;
 }
 
@@ -2818,6 +2820,7 @@ int patch_vt1617a(struct snd_ac97 * ac97
 	snd_ac97_write_cache(ac97, 0x5c, 0x20);
 	ac97->ext_id |= AC97_EI_SPDIF;	/* force the detection of spdif */
 	ac97->rates[AC97_RATES_SPDIF] = SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000;
+	ac97->build_ops = &patch_vt1616_ops;
 	return 0;
 }
 

--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--FL5UXtIhxfXey3p5--

From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: [RFC] alsa-kernel, make control.c suspend aware
Date: Tue, 7 Mar 2006 23:09:57 +0100
Message-ID: <20060307230957.63c5bd35.pochini@shiny.it>
References: <20060302001859.58bd93af.pochini@shiny.it>
	<s5hmzg9865c.wl%tiwai@suse.de>
	<20060302230720.669b348f.pochini@shiny.it>
	<s5hd5h3o213.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hd5h3o213.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Fri, 03 Mar 2006 18:45:28 +0100
Takashi Iwai <tiwai@suse.de> wrote:

> > ->put() and ->get() are called directly only from
> > core/control.c:snd_ctl_elem_read() and core/control.c:snd_ctl_elem_write().
> > If we put snd_power_wait() in snd_ctl_elem_read/write() all their current
> > and future callers are protected, but /hda/hda_codec.c deadlocks in the
> > resume function (it's the only one). Otherwise, we can put snd_power_wait()
> > in snd_ctl_elem_read/write_user() and in _snd_ioctl32_ctl_elem_value().
> > Which choice ?  Do we duplicate power_wait or do we change hda_intel ?
>
> I think it's better to set snd_power_lock() only for user-accessor.
>
> Yes, get and put callbacks are only for read/write callbacks, but
> there is still info callback.  So, we need to put power lock to
> snd_ctl_elem_user_info(), too.

Ok, this patch changes all three snd_ctl_elem_user_*(). It seems to work
fine here. It also patches alsa-kernel/core/control_compat.c, but that part
has been compile-tested only. The last part fixes ioctl32/ioctl32_new.c and
it is completely untested (how can I test it on ppc32 ?).



diff -dup alsa-kernel__orig/core/control.c alsa-kernel/core/control.c
--- alsa-kernel__orig/core/control.c	2006-03-07 20:53:51.000000000 +0100
+++ alsa-kernel/core/control.c	2006-03-06 23:43:36.000000000 +0100
@@ -658,7 +658,11 @@ static int snd_ctl_elem_info_user(struct
 
 	if (copy_from_user(&info, _info, sizeof(info)))
 		return -EFAULT;
-	result = snd_ctl_elem_info(ctl, &info);
+	snd_power_lock(ctl->card);
+	result = snd_power_wait(ctl->card, SNDRV_CTL_POWER_D0, NULL);
+	if (result >= 0)
+		result = snd_ctl_elem_info(ctl, &info);
+	snd_power_unlock(ctl->card);
 	if (result >= 0)
 		if (copy_to_user(_info, &info, sizeof(info)))
 			return -EFAULT;
@@ -708,7 +712,11 @@ static int snd_ctl_elem_read_user(struct
 		kfree(control);
 		return -EFAULT;
 	}
-	result = snd_ctl_elem_read(card, control);
+	snd_power_lock(card);
+	result = snd_power_wait(card, SNDRV_CTL_POWER_D0, NULL);
+	if (result >= 0)
+		result = snd_ctl_elem_read(card, control);
+	snd_power_unlock(card);
 	if (result >= 0)
 		if (copy_to_user(_control, control, sizeof(*control)))
 			result = -EFAULT;
@@ -758,6 +766,7 @@ static int snd_ctl_elem_write_user(struc
 				   struct snd_ctl_elem_value __user *_control)
 {
 	struct snd_ctl_elem_value *control;
+	struct snd_card *card;
 	int result;
 
 	control = kmalloc(sizeof(*control), GFP_KERNEL);
@@ -767,7 +776,12 @@ static int snd_ctl_elem_write_user(struc
 		kfree(control);
 		return -EFAULT;
 	}
-	result = snd_ctl_elem_write(file->card, file, control);
+	card = file->card;
+	snd_power_lock(card);
+	result = snd_power_wait(card, SNDRV_CTL_POWER_D0, NULL);
+	if (result >= 0)
+		result = snd_ctl_elem_write(card, file, control);
+	snd_power_unlock(card);
 	if (result >= 0)
 		if (copy_to_user(_control, control, sizeof(*control)))
 			result = -EFAULT;
diff -dup alsa-kernel__orig/core/control_compat.c alsa-kernel/core/control_compat.c
--- alsa-kernel__orig/core/control_compat.c	2006-02-23 22:41:33.000000000 +0100
+++ alsa-kernel/core/control_compat.c	2006-03-07 00:16:43.000000000 +0100
@@ -107,7 +107,13 @@ static int snd_ctl_elem_info_compat(stru
 	 */
 	if (get_user(data->value.enumerated.item, &data32->value.enumerated.item))
 		goto error;
-	err = snd_ctl_elem_info(ctl, data);
+
+	snd_power_lock(ctl->card);
+	err = snd_power_wait(ctl->card, SNDRV_CTL_POWER_D0, NULL);
+	if (err >= 0)
+		err = snd_ctl_elem_info(ctl, data);
+	snd_power_unlock(ctl->card);
+
 	if (err < 0)
 		goto error;
 	/* restore info to 32bit */
@@ -286,9 +292,14 @@ static int snd_ctl_elem_read_user_compat
 
 	if ((err = copy_ctl_value_from_user(card, data, data32, &type, &count)) < 0)
 		goto error;
-	if ((err = snd_ctl_elem_read(card, data)) < 0)
-		goto error;
-	err = copy_ctl_value_to_user(data32, data, type, count);
+
+	snd_power_lock(card);
+	err = snd_power_wait(card, SNDRV_CTL_POWER_D0, NULL);
+	if (err >= 0)
+		err = snd_ctl_elem_read(card, data);
+	snd_power_unlock(card);
+	if (err >= 0)
+		err = copy_ctl_value_to_user(data32, data, type, count);
  error:
 	kfree(data);
 	return err;
@@ -298,17 +309,23 @@ static int snd_ctl_elem_write_user_compa
 					  struct snd_ctl_elem_value32 __user *data32)
 {
 	struct snd_ctl_elem_value *data;
+	struct snd_card *card = file->card;
 	int err, type, count;
 
 	data = kzalloc(sizeof(*data), GFP_KERNEL);
 	if (data == NULL)
 		return -ENOMEM;
 
-	if ((err = copy_ctl_value_from_user(file->card, data, data32, &type, &count)) < 0)
-		goto error;
-	if ((err = snd_ctl_elem_write(file->card, file, data)) < 0)
+	if ((err = copy_ctl_value_from_user(card, data, data32, &type, &count)) < 0)
 		goto error;
-	err = copy_ctl_value_to_user(data32, data, type, count);
+
+	snd_power_lock(card);
+	err = snd_power_wait(card, SNDRV_CTL_POWER_D0, NULL);
+	if (err >= 0)
+		err = snd_ctl_elem_write(card, file, data);
+	snd_power_unlock(card);
+	if (err >= 0)
+		err = copy_ctl_value_to_user(data32, data, type, count);
  error:
 	kfree(data);
 	return err;
diff -dup alsa-driver__orig/acore/ioctl32/ioctl32_new.c alsa-driver/acore/ioctl32/ioctl32_new.c
--- alsa-driver__orig/acore/ioctl32/ioctl32_new.c	2005-11-26 13:14:44.000000000 +0100
+++ alsa-driver/acore/ioctl32/ioctl32_new.c	2006-03-06 23:23:21.000000000 +0100
@@ -243,7 +243,11 @@ static int get_ctl_type(struct snd_card 
 		return -ENXIO;
 	}
 	info.id = *id;
-	err = kctl->info(kctl, &info);
+	snd_power_lock(card);
+	err = snd_power_wait(card, SNDRV_CTL_POWER_D0, NULL);
+	if (err >= 0)
+		err = kctl->info(kctl, &info);
+	snd_power_unlock(card);
 	up_read(&card->controls_rwsem);
 	if (err >= 0)
 		err = info.type;
@@ -255,6 +259,7 @@ static inline int _snd_ioctl32_ctl_elem_
 	struct snd_ctl_elem_value *data;
 	struct snd_ctl_elem_value32 __user *data32;
 	struct snd_ctl_file *ctl;
+	struct snd_card *card;
 	int err, i, indirect;
 	int type;
 
@@ -285,7 +290,8 @@ static inline int _snd_ioctl32_ctl_elem_
 		err = -EINVAL;
 		goto __end;
 	}
-	type = get_ctl_type(ctl->card, &data->id);
+	card = ctl->card;
+	type = get_ctl_type(card, &data->id);
 	if (type < 0) {
 		err = type;
 		goto __end;
@@ -320,10 +326,15 @@ static inline int _snd_ioctl32_ctl_elem_
 		goto __end;
 	}
 
-	if (native_ctl == SNDRV_CTL_IOCTL_ELEM_READ)
-		err = snd_ctl_elem_read(ctl->card, data);
-	else
-		err = snd_ctl_elem_write(ctl->card, ctl, data);
+	snd_power_lock(card);
+	err = snd_power_wait(card, SNDRV_CTL_POWER_D0, NULL);
+	if (err >= 0) {
+		if (native_ctl == SNDRV_CTL_IOCTL_ELEM_READ)
+			err = snd_ctl_elem_read(card, data);
+		else
+			err = snd_ctl_elem_write(card, ctl, data);
+	}
+	snd_power_unlock(card);
 	if (err < 0)
 		goto __end;
 	/* restore info to 32bit */
@@ -347,7 +358,6 @@ static inline int _snd_ioctl32_ctl_elem_
 			goto __end;
 		}
 		break;
-		break;
 	}
 	err = 0;
       __end:


--
Giuliano.


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642

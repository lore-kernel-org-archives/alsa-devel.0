From: Juergen Kreileder <jk@blackdown.de>
Subject: Re: [patch] Fix snd-usb-audio in 32-bit compat environemt
Date: Sun, 19 Feb 2006 20:02:03 +0100
Message-ID: <87hd6vw4t0.fsf@blackdown.de>
References: <878xs85wn6.fsf@blackdown.de>
	<20060219175646.GB7797@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932205AbWBSTCN@vger.kernel.org>
In-Reply-To: <20060219175646.GB7797@mipter.zuzino.mipt.ru> (Alexey Dobriyan's
	message of "Sun, 19 Feb 2006 20:56:46 +0300")
Sender: linux-kernel-owner@vger.kernel.org
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: alsa-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Alexey Dobriyan <adobriyan@gmail.com> writes:

> On Sat, Feb 18, 2006 at 07:50:37PM +0100, Juergen Kreileder wrote:
>> I'm getting oopses with snd-usb-audio in 32-bit compat
>> environments: control_compat.c:get_ctl_type() doesn't initialize
>> 'info', so
>> 'itemlist[uinfo->value.enumerated.item]' in
>> usbmixer.c:mixer_ctl_selector_info() might access random memory
>> (The 'if ((int)uinfo->value.enumerated.item >= cval->max)' doesn't fix
>> all problems because of the unsigned -> signed conversion.)
>
> IMO, what you did is an overkill.

The advantage of the longer fix is reduced stack usage.

> Does this patch fixes your problem?

Yes but you can have that even simpler:

--- linux-mm-vanilla/sound/core/control_compat.c	2006-02-18 17:00:17.000000000 +0100
+++ linux-mm/sound/core/control_compat.c	2006-02-19 19:41:51.000000000 +0100
@@ -167,7 +167,7 @@ static int get_ctl_type(struct snd_card 
 			int *countp)
 {
 	struct snd_kcontrol *kctl;
-	struct snd_ctl_elem_info info;
+	struct snd_ctl_elem_info info = {0};
 	int err;
 
 	down_read(&card->controls_rwsem);
=


        Juergen

-- 
Juergen Kreileder, Blackdown Java-Linux Team
http://blog.blackdown.de/

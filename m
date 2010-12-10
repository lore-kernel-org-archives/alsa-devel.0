From: Simos Xenitellis <simos.lists@googlemail.com>
Subject: "Unknown symbol" with alsa snapshot (tiwai)
Date: Fri, 10 Dec 2010 19:01:17 +0200
Message-ID: <AANLkTi=iV42FJTD6bC6cy3P=p6YgTNTnPLyrQ3NKFL-2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f177.google.com (mail-gx0-f177.google.com
	[209.85.161.177])
	by alsa0.perex.cz (Postfix) with ESMTP id 9142B2458D
	for <alsa-devel@alsa-project.org>; Fri, 10 Dec 2010 18:06:25 +0100 (CET)
Received: by gxk27 with SMTP id 27so2296164gxk.8
	for <alsa-devel@alsa-project.org>; Fri, 10 Dec 2010 09:06:24 -0800 (PST)
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

I am trying out the latest snapshot of Alsa with Ubuntu 10.10.
It compiles without errors. However, when the modules are to be loaded,
there are Unknown symbol errors:

[ 332.243113] snd: Unknown symbol unregister_sound_special (err 0)
[ 332.243379] snd: Unknown symbol register_sound_special_device (err 0)
[ 332.245467] snd_timer: Unknown symbol snd_info_register (err 0)
[ 332.245631] snd_timer: Unknown symbol snd_info_create_module_entry (err 0)
[ 332.245839] snd_timer: Unknown symbol snd_info_free_entry (err 0)
[ 332.246210] snd_timer: Unknown symbol __snd_printk (err 0)
[ 332.246373] snd_timer: Unknown symbol snd_iprintf (err 0)
[ 332.246607] snd_timer: Unknown symbol snd_ecards_limit (err 0)
[ 332.246834] snd_timer: Unknown symbol snd_oss_info_register (err 0)
[ 332.246997] snd_timer: Unknown symbol snd_unregister_device (err 0)
[ 332.247224] snd_timer: Unknown symbol snd_device_new (err 0)
[ 332.247625] snd_timer: Unknown symbol snd_register_device_for_dev (err 0)

Is this a module loading order issue? Has there been a change in the
latest kernel
that causes the problem?

Simos

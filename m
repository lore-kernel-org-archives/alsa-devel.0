From: "Adrian McMenamin" <lkmladrian@gmail.com>
Subject: Firmware problem
Date: Tue, 18 Dec 2007 20:51:17 +0000
Message-ID: <8b67d60712181251u3356bb72l9db08abf846cae9b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.182])
	by alsa0.perex.cz (Postfix) with ESMTP id 0BD9B10385C
	for <alsa-devel@alsa-project.org>; Tue, 18 Dec 2007 21:51:19 +0100 (CET)
Received: by py-out-1112.google.com with SMTP id u77so4247713pyb.16
	for <alsa-devel@alsa-project.org>; Tue, 18 Dec 2007 12:51:18 -0800 (PST)
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

My user - yes there is one - of the aica sound driver on the Dreamcast
is having a problem with formware loading.

This is what he has sent me - anyone know what is wrong?

When loading snd-aica it gives:
[   55.119676] ALSA sound/sh/aica.c:641: ALSA Driver for Yamaha AICA Super Inter

then after like 15 or 20 seconds it will give:
FATAL: Error inserting snd_aica
(/lib/modules/2.6.24-rc4/kernel/sound/sh/snd-aica.ko): Unknown symbol
in module, or unknown parameter (see dmesg)

and dmesg gives this:
[   54.632531] fill_kobj_path: path = '/module/snd_page_alloc'
[   54.643434] kobject notes: registering. parent: snd_page_alloc, set: <NULL>
[   54.645602] kobject_uevent_env
[   54.646181] kobject filter function caused the event to drop!
[   54.669703] kobject soundcore: registering. parent: <NULL>, set: module
[   54.671737] kobject holders: registering. parent: soundcore, set: <NULL>
[   54.673616] kobject_uevent_env
[   54.675375] kobject filter function caused the event to drop!
[   54.677096] kobject_uevent_env
[   54.678780] fill_kobj_path: path = '/module/soundcore'
[   54.690116] kobject notes: registering. parent: soundcore, set: <NULL>
[   54.690904] kobject_uevent_env
[   54.693891] kobject filter function caused the event to drop!
[   54.695845] device class 'sound': registering
[   54.697748] kobject sound: registering. parent: <NULL>, set: class
[   54.699657] kobject_uevent_env
[   54.701350] fill_kobj_path: path = '/class/sound'
[   54.787597] kobject snd: registering. parent: <NULL>, set: module
[   54.789664] kobject holders: registering. parent: snd, set: <NULL>
[   54.791557] kobject_uevent_env
[   54.793340] kobject filter function caused the event to drop!
[   54.795228] kobject_uevent_env
[   54.797010] fill_kobj_path: path = '/module/snd'
[   54.808092] kobject notes: registering. parent: snd, set: <NULL>
[   54.808886] kobject_uevent_env
[   54.811852] kobject filter function caused the event to drop!
[   54.849584] kobject snd_timer: registering. parent: <NULL>, set: module
[   54.850378] kobject holders: registering. parent: snd_timer, set: <NULL>
[   54.853372] kobject_uevent_env
[   54.855118] kobject filter function caused the event to drop!
[   54.856902] kobject_uevent_env
[   54.858680] fill_kobj_path: path = '/module/snd_timer'
[   54.869736] kobject notes: registering. parent: snd_timer, set: <NULL>
[   54.871802] kobject_uevent_env
[   54.872452] kobject filter function caused the event to drop!
[   54.875569] DEV: registering device: ID = 'timer'
[   54.877400] kobject sound: registering. parent: virtual, set: <NULL>
[   54.881274] kobject_uevent_env
[   54.883351] unset subsystem caused the event to drop!
[   54.886599] kobject timer: registering. parent: sound, set: devices
[   54.888593] kobject_uevent_env
[   54.890420] fill_kobj_path: path = '/devices/virtual/sound/timer'
[   55.000017] kobject snd_pcm: registering. parent: <NULL>, set: module
[   55.002208] kobject holders: registering. parent: snd_pcm, set: <NULL>
[   55.004074] kobject_uevent_env
[   55.004636] kobject filter function caused the event to drop!
[   55.007502] kobject_uevent_env
[   55.009274] fill_kobj_path: path = '/module/snd_pcm'
[   55.020295] kobject notes: registering. parent: snd_pcm, set: <NULL>
[   55.021108] kobject_uevent_env
[   55.024045] kobject filter function caused the event to drop!
[   55.053022] kobject snd_aica: registering. parent: <NULL>, set: module
[   55.055131] kobject holders: registering. parent: snd_aica, set: <NULL>
[   55.057074] kobject_uevent_env
[   55.057643] kobject filter function caused the event to drop!
[   55.060587] kobject_uevent_env
[   55.061260] fill_kobj_path: path = '/module/snd_aica'
[   55.073491] kobject notes: registering. parent: snd_aica, set: <NULL>
[   55.074288] kobject_uevent_env
[   55.077295] kobject filter function caused the event to drop!
[   55.079239] bus platform: add driver AICA
[   55.079929] kobject AICA: registering. parent: <NULL>, set: drivers
[   55.082948] kobject_uevent_env
[   55.084712] fill_kobj_path: path = '/bus/platform/drivers/AICA'
[   55.089946] Registering platform device 'AICA'. Parent at platform
[   55.091828] DEV: registering device: ID = 'AICA'
[   55.093558] kobject AICA: registering. parent: platform, set: devices
[   55.093744] bus platform: add device AICA
[   55.093849] kobject_uevent_env
[   55.093918] fill_kobj_path: path = '/devices/platform/AICA'
[   55.094045] platform: Matched Device AICA with Driver AICA
[   55.094096] platform: Probing driver AICA with device AICA
[   55.094492] DEV: registering device: ID = 'card0'
[   55.094564] kobject sound: registering. parent: AICA, set: <NULL>
[   55.094646] kobject_uevent_env
[   55.094682] unset subsystem caused the event to drop!
[   55.094739] kobject card0: registering. parent: sound, set: devices
[   55.094888] kobject_uevent_env
[   55.094959] fill_kobj_path: path = '/devices/platform/AICA/sound/card0'
[   55.095133] DEV: registering device: ID = 'pcmC0D0p'
[   55.095195] kobject pcmC0D0p: registering. parent: card0, set: devices
[   55.095454] kobject_uevent_env
[   55.095528] fill_kobj_path: path =
'/devices/platform/AICA/sound/card0/pcmC0D0p'
[   55.095745] DEV: registering device: ID = 'controlC0'
[   55.095811] kobject controlC0: registering. parent: card0, set: devices
[   55.095980] kobject_uevent_env
[   55.096051] fill_kobj_path: path =
'/devices/platform/AICA/sound/card0/controlC0'
[   55.119676] ALSA sound/sh/aica.c:641: ALSA Driver for Yamaha AICA
Super Intelligent Sound Processor
[   55.128339] bound device 'AICA' to driver 'AICA'
[   55.128394] platform: Bound Device AICA to Driver AICA
[   57.018452] DEV: registering device: ID = 'firmware-AICA'
[   57.019121] kobject firmware: registering. parent: AICA, set: <NULL>
[   57.022447] kobject_uevent_env
[   57.023025] unset subsystem caused the event to drop!
[   57.023099] kobject firmware-AICA: registering. parent: firmware,
set: devices
[   57.027620] kobject_uevent_env
[   57.029196] kobject filter function caused the event to drop!
[   57.029842] kobject_uevent_env
[   57.032535] fill_kobj_path: path =
'/devices/platform/AICA/firmware/firmware-AICA'
[  115.955604] DEV: Unregistering device. ID = 'firmware-AICA'
[  115.955788] kobject_uevent_env
[  115.955898] fill_kobj_path: path =
'/devices/platform/AICA/firmware/firmware-AICA'
[  115.956090] kobject firmware-AICA: cleaning up
[  115.956144] kobject firmware: cleaning up
[  115.960813] kobject holders: unregistering
[  115.960863] kobject_uevent_env
[  115.960900] kobject filter function caused the event to drop!
[  115.960972] kobject holders: cleaning up
[  115.961018] kobject snd_aica: unregistering
[  115.961059] kobject_uevent_env
[  115.961128] fill_kobj_path: path = '/module/snd_aica'

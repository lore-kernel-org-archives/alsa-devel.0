From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Subject: Re: Hotplug firmware problems
Date: Tue, 04 Oct 2005 22:59:30 +0100
Message-ID: <1128463170.5085.8.camel@localhost.localdomain>
References: <1128452684.5085.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linuxsh-dev-admin@lists.sourceforge.net>
In-Reply-To: <1128452684.5085.4.camel@localhost.localdomain>
Sender: linuxsh-dev-admin@lists.sourceforge.net
Errors-To: linuxsh-dev-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linuxsh-dev>,
	<mailto:linuxsh-dev-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:linuxsh-dev@lists.sourceforge.net>
List-Help: <mailto:linuxsh-dev-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linuxsh-dev>,
	<mailto:linuxsh-dev-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linuxsh-dev>
To: linuxsh-dev@lists.sourceforge.net
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 2005-10-04 at 20:04 +0100, Adrian McMenamin wrote:
> I am attempting to load the firmware my device (AICA sound on Dreamcast)
> needs via hotplug...


Messed about with the hotplug scripts and now get this ... but I don't
know why firmware.agent doesn't load the firmware... and I assume there
is no sound.agent available...



Oct  4 16:55:48 uclibc user.debug kernel: kobject snd_card_aica:
registering. parent: <NULL>, set: module
Oct  4 16:55:48 uclibc user.debug kernel: kobject_hotplug
Oct  4 16:55:48 uclibc user.debug kernel: fill_kobj_path: path =
'/module/snd_card_aica'
Oct  4 16:55:48 uclibc user.debug kernel: kobject_hotplug: /sbin/hotplug
module seq=625 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add
DEVPATH=/module/snd_card_aica SUBSYSTEM=module
Oct  4 16:55:48 uclibc user.notice [749]: arguments (module) env
(SUBSYSTEM=module OLDPWD=/ DEVPATH=/module/snd_card_aica
PATH=/bin:/sbin:/usr/sbin:/usr/bin ACTION=add PWD=/etc/hotplug HOME=/
SHLVL=2 DEBUG=yes SEQNUM=625 _=/usr/bin/env)
Oct  4 16:55:48 uclibc user.warn kernel: Probing for AICA device
Oct  4 16:55:48 uclibc user.debug kernel: Registering platform device
'snd_card_aica'. Parent at platform
Oct  4 16:55:48 uclibc user.debug kernel: DEV: registering device: ID =
'snd_card_aica'
Oct  4 16:55:48 uclibc user.notice [749]: no
runnable /etc/hotplug/module.agent is installed
Oct  4 16:55:48 uclibc user.debug kernel: kobject snd_card_aica:
registering. parent: platform, set: devices
Oct  4 16:55:49 uclibc user.debug kernel: kobject_hotplug
Oct  4 16:55:49 uclibc user.notice [760]: arguments (platform) env
(SUBSYSTEM=platform OLDPWD=/ DEVPATH=/devices/platform/snd_card_aica
PATH=/bin:/sbin:/usr/sbin:/usr/bin ACTION=add PWD=/etc/hotplug HOME=/
SHLVL=2 DEBUG=yes PHYSDEVBUS=platform SEQNUM=626 _=/usr/bin/env)
Oct  4 16:55:49 uclibc user.debug kernel: fill_kobj_path: path =
'/devices/platform/snd_card_aica'
Oct  4 16:55:49 uclibc user.debug kernel: kobject_hotplug: /sbin/hotplug
platform seq=626 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add
DEVPATH=/devices/platform/snd_card_aica SUBSYSTEM=platform
Oct  4 16:55:49 uclibc user.debug kernel: bus platform: add device
snd_card_aica
Oct  4 16:55:49 uclibc user.debug kernel: bus platform: add driver AICA
Oct  4 16:55:49 uclibc user.debug kernel: kobject AICA: registering.
parent: <NULL>, set: drivers
Oct  4 16:55:49 uclibc user.debug kernel: kobject_hotplug
Oct  4 16:55:49 uclibc user.debug kernel: fill_kobj_path: path =
'/bus/platform/drivers/AICA'
Oct  4 16:55:49 uclibc user.debug kernel: kobject_hotplug: /sbin/hotplug
drivers seq=627 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add
DEVPATH=/bus/platform/drivers/AICA SUBSYSTEM=drivers
Oct  4 16:55:49 uclibc user.notice [760]: no
runnable /etc/hotplug/platform.agent is installed
Oct  4 16:55:49 uclibc user.notice [762]: arguments (drivers) env
(SUBSYSTEM=drivers OLDPWD=/ DEVPATH=/bus/platform/drivers/AICA
PATH=/bin:/sbin:/usr/sbin:/usr/bin ACTION=add PWD=/etc/hotplug HOME=/
SHLVL=2 DEBUG=yes SEQNUM=627 _=/usr/bin/env)
Oct  4 16:55:49 uclibc user.notice [762]: no
runnable /etc/hotplug/drivers.agent is installed
Oct  4 16:55:49 uclibc user.debug kernel: bound device 'snd_card_aica'
to driver 'AICA'
Oct  4 16:55:49 uclibc user.debug kernel: CLASS: registering class
device: ID = 'pcmC0D0p'
Oct  4 16:55:49 uclibc user.debug kernel: kobject pcmC0D0p: registering.
parent: sound, set: class_obj
Oct  4 16:55:49 uclibc user.debug kernel: kobject_hotplug
Oct  4 16:55:49 uclibc user.debug kernel: fill_kobj_path: path =
'/class/sound/pcmC0D0p'
Oct  4 16:55:49 uclibc user.debug kernel: class_hotplug - name =
pcmC0D0p
Oct  4 16:55:49 uclibc user.debug kernel: fill_kobj_path: path =
'/devices/platform/snd_card_aica'
Oct  4 16:55:49 uclibc user.debug kernel: kobject_hotplug: /sbin/hotplug
sound seq=628 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add
DEVPATH=/class/sound/pcmC0D0p SUBSYSTEM=sound
Oct  4 16:55:49 uclibc user.debug kernel: CLASS: registering class
device: ID = 'controlC0'
Oct  4 16:55:49 uclibc user.debug kernel: kobject controlC0:
registering. parent: sound, set: class_obj
Oct  4 16:55:49 uclibc user.debug kernel: kobject_hotplug
Oct  4 16:55:49 uclibc user.debug kernel: fill_kobj_path: path =
'/class/sound/controlC0'
Oct  4 16:55:49 uclibc user.debug kernel: class_hotplug - name =
controlC0
Oct  4 16:55:49 uclibc user.debug kernel: fill_kobj_path: path =
'/devices/platform/snd_card_aica'
Oct  4 16:55:49 uclibc user.debug kernel: kobject_hotplug: /sbin/hotplug
sound seq=629 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add
DEVPATH=/class/sound/controlC0 SUBSYSTEM=sound
Oct  4 16:55:49 uclibc user.debug kernel: CLASS: registering class
device: ID = 'snd_card_aica'
Oct  4 16:55:49 uclibc user.debug kernel: kobject snd_card_aica:
registering. parent: firmware, set: class_obj
Oct  4 16:55:49 uclibc user.debug kernel: kobject_hotplug
Oct  4 16:55:49 uclibc user.debug kernel: fill_kobj_path: path =
'/class/firmware/snd_card_aica'
Oct  4 16:55:49 uclibc user.debug kernel: class_hotplug - name =
snd_card_aica
Oct  4 16:55:49 uclibc user.debug kernel: fill_kobj_path: path =
'/devices/platform/snd_card_aica'
Oct  4 16:55:49 uclibc user.debug kernel: class_hotplug - hotplug()
returned -19
Oct  4 16:55:49 uclibc user.debug kernel: kobject_hotplug - hotplug()
returned -19
Oct  4 16:55:49 uclibc user.debug kernel: kobject_hotplug
Oct  4 16:55:49 uclibc user.debug kernel: fill_kobj_path: path =
'/class/firmware/snd_card_aica'
Oct  4 16:55:49 uclibc user.debug kernel: class_hotplug - name =
snd_card_aica
Oct  4 16:55:49 uclibc user.debug kernel: fill_kobj_path: path =
'/devices/platform/snd_card_aica'
Oct  4 16:55:49 uclibc user.debug kernel: kobject_hotplug: /sbin/hotplug
firmware seq=630 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add
DEVPATH=/class/firmware/snd_card_aica SUBSYSTEM=firmware
Oct  4 16:55:50 uclibc user.notice [785]: arguments (firmware) env
(PHYSDEVPATH=/devices/platform/snd_card_aica SUBSYSTEM=firmware OLDPWD=/
DEVPATH=/class/firmware/snd_card_aica FIRMWARE=aica_firmware.bin
PATH=/bin:/sbin:/usr/sbin:/usr/bin ACTION=add TIMEOUT=10
PWD=/etc/hotplug HOME=/ SHLVL=2 PHYSDEVDRIVER=AICA DEBUG=yes
PHYSDEVBUS=platform SEQNUM=630 _=/usr/bin/env)
Oct  4 16:55:50 uclibc user.notice [785]:
invoke /etc/hotplug/firmware.agent ()
Oct  4 16:55:50 uclibc user.notice [783]: arguments (sound) env
(PHYSDEVPATH=/devices/platform/snd_card_aica SUBSYSTEM=sound OLDPWD=/
DEVPATH=/class/sound/controlC0 MINOR=0
PATH=/bin:/sbin:/usr/sbin:/usr/bin ACTION=add PWD=/etc/hotplug MAJOR=116
HOME=/ SHLVL=2 PHYSDEVDRIVER=AICA DEBUG=yes PHYSDEVBUS=platform
SEQNUM=629 _=/usr/bin/env)
Oct  4 16:55:50 uclibc user.notice [783]: no
runnable /etc/hotplug/sound.agent is installed
Oct  4 16:55:50 uclibc user.notice [775]: arguments (sound) env
(PHYSDEVPATH=/devices/platform/snd_card_aica SUBSYSTEM=sound OLDPWD=/
DEVPATH=/class/sound/pcmC0D0p MINOR=16
PATH=/bin:/sbin:/usr/sbin:/usr/bin ACTION=add PWD=/etc/hotplug MAJOR=116
HOME=/ SHLVL=2 PHYSDEVDRIVER=AICA DEBUG=yes PHYSDEVBUS=platform
SEQNUM=628 _=/usr/bin/env)
Oct  4 16:55:50 uclibc user.notice [775]: no
runnable /etc/hotplug/sound.agent is installed
Oct  4 16:55:59 uclibc user.debug kernel: CLASS: Unregistering class
device. ID = 'snd_card_aica'
Oct  4 16:55:59 uclibc user.debug kernel: kobject_hotplug
Oct  4 16:55:59 uclibc user.debug kernel: fill_kobj_path: path =
'/class/firmware/snd_card_aica'
Oct  4 16:55:59 uclibc user.debug kernel: class_hotplug - name =
snd_card_aica
Oct  4 16:55:59 uclibc user.debug kernel: fill_kobj_path: path =
'/devices/platform/snd_card_aica'
Oct  4 16:55:59 uclibc user.debug kernel: kobject_hotplug: /sbin/hotplug
firmware seq=631 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=remove
DEVPATH=/class/firmware/snd_card_aica SUBSYSTEM=firmware
Oct  4 16:55:59 uclibc user.debug kernel: kobject snd_card_aica:
cleaning up
Oct  4 16:55:59 uclibc user.debug kernel: device class 'snd_card_aica':
release.
Oct  4 16:55:59 uclibc user.debug kernel: CLASS: Unregistering class
device. ID = 'controlC0'
Oct  4 16:55:59 uclibc user.debug kernel: kobject_hotplug
Oct  4 16:55:59 uclibc user.debug kernel: fill_kobj_path: path =
'/class/sound/controlC0'
Oct  4 16:55:59 uclibc user.debug kernel: class_hotplug - name =
controlC0
Oct  4 16:55:59 uclibc user.debug kernel: fill_kobj_path: path =
'/devices/platform/snd_card_aica'
Oct  4 16:55:59 uclibc user.debug kernel: kobject_hotplug: /sbin/hotplug
sound seq=632 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=remove
DEVPATH=/class/sound/controlC0 SUBSYSTEM=sound
Oct  4 16:55:59 uclibc user.debug kernel: kobject controlC0: cleaning up
Oct  4 16:55:59 uclibc user.debug kernel: device class 'controlC0':
release.
Oct  4 16:55:59 uclibc user.debug kernel: CLASS: Unregistering class
device. ID = 'pcmC0D0p'
Oct  4 16:55:59 uclibc user.debug kernel: kobject_hotplug
Oct  4 16:55:59 uclibc user.notice [810]: arguments (sound) env
(PHYSDEVPATH=/devices/platform/snd_card_aica SUBSYSTEM=sound OLDPWD=/
DEVPATH=/class/sound/controlC0 MINOR=0
PATH=/bin:/sbin:/usr/sbin:/usr/bin ACTION=remove PWD=/etc/hotplug
MAJOR=116 HOME=/ SHLVL=2 PHYSDEVDRIVER=AICA DEBUG=yes
PHYSDEVBUS=platform SEQNUM=632 _=/usr/bin/env)
Oct  4 16:56:00 uclibc user.debug kernel: fill_kobj_path: path =
'/class/sound/pcmC0D0p'
Oct  4 16:55:59 uclibc user.debug kernel: class_hotplug - name =
pcmC0D0p
Oct  4 16:55:59 uclibc user.debug kernel: fill_kobj_path: path =
'/devices/platform/snd_card_aica'
Oct  4 16:55:59 uclibc user.debug kernel: kobject_hotplug: /sbin/hotplug
sound seq=633 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=remove
DEVPATH=/class/sound/pcmC0D0p SUBSYSTEM=sound
Oct  4 16:56:00 uclibc user.debug kernel: kobject pcmC0D0p: cleaning up
Oct  4 16:56:00 uclibc user.debug kernel: device class 'pcmC0D0p':
release.
Oct  4 16:56:00 uclibc user.debug kernel: bus platform: remove driver
AICA
Oct  4 16:56:00 uclibc user.debug kernel: kobject AICA: unregistering
Oct  4 16:56:00 uclibc user.debug kernel: kobject_hotplug
Oct  4 16:56:00 uclibc user.debug kernel: fill_kobj_path: path =
'/bus/platform/drivers/AICA'
Oct  4 16:56:00 uclibc user.debug kernel: kobject_hotplug: /sbin/hotplug
drivers seq=634 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=remove
DEVPATH=/bus/platform/drivers/AICA SUBSYSTEM=drivers
Oct  4 16:56:00 uclibc user.debug kernel: kobject AICA: cleaning up
Oct  4 16:56:00 uclibc user.debug kernel: DEV: Unregistering device. ID
= 'snd_card_aica'
Oct  4 16:56:00 uclibc user.debug kernel: bus platform: remove device
snd_card_aica
Oct  4 16:56:00 uclibc user.debug kernel: kobject_hotplug
Oct  4 16:56:00 uclibc user.debug kernel: fill_kobj_path: path =
'/devices/platform/snd_card_aica'
Oct  4 16:56:00 uclibc user.debug kernel: kobject_hotplug: /sbin/hotplug
platform seq=635 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=remove
DEVPATH=/devices/platform/snd_card_aica SUBSYSTEM=platform
Oct  4 16:56:00 uclibc user.debug kernel: kobject snd_card_aica:
cleaning up
Oct  4 16:56:00 uclibc user.notice [824]: arguments (drivers) env
(SUBSYSTEM=drivers OLDPWD=/ DEVPATH=/bus/platform/drivers/AICA
PATH=/bin:/sbin:/usr/sbin:/usr/bin ACTION=remove PWD=/etc/hotplug HOME=/
SHLVL=2 DEBUG=yes SEQNUM=634 _=/usr/bin/env)
Oct  4 16:56:00 uclibc user.notice [818]: arguments (sound) env
(PHYSDEVPATH=/devices/platform/snd_card_aica SUBSYSTEM=sound OLDPWD=/
DEVPATH=/class/sound/pcmC0D0p MINOR=16
PATH=/bin:/sbin:/usr/sbin:/usr/bin ACTION=remove PWD=/etc/hotplug
MAJOR=116 HOME=/ SHLVL=2 PHYSDEVDRIVER=AICA DEBUG=yes
PHYSDEVBUS=platform SEQNUM=633 _=/usr/bin/env)
Oct  4 16:56:00 uclibc user.notice [824]: no
runnable /etc/hotplug/drivers.agent is installed
Oct  4 16:56:00 uclibc user.notice [818]: no
runnable /etc/hotplug/sound.agent is installed
Oct  4 16:56:00 uclibc user.notice [830]: arguments (platform) env
(SUBSYSTEM=platform OLDPWD=/ DEVPATH=/devices/platform/snd_card_aica
PATH=/bin:/sbin:/usr/sbin:/usr/bin ACTION=remove PWD=/etc/hotplug HOME=/
SHLVL=2 DEBUG=yes PHYSDEVBUS=platform SEQNUM=635 _=/usr/bin/env)
Oct  4 16:56:00 uclibc user.debug kernel: kobject snd_card_aica:
unregistering
Oct  4 16:56:00 uclibc user.debug kernel: kobject_hotplug
Oct  4 16:56:00 uclibc user.debug kernel: fill_kobj_path: path =
'/module/snd_card_aica'
Oct  4 16:56:00 uclibc user.debug kernel: kobject_hotplug: /sbin/hotplug
module seq=636 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=remove
DEVPATH=/module/snd_card_aica SUBSYSTEM=module
Oct  4 16:56:00 uclibc user.debug kernel: kobject snd_card_aica:
cleaning up
Oct  4 16:56:00 uclibc user.notice [830]: no
runnable /etc/hotplug/platform.agent is installed
Oct  4 16:56:01 uclibc user.notice [806]: arguments (firmware) env
(PHYSDEVPATH=/devices/platform/snd_card_aica SUBSYSTEM=firmware OLDPWD=/
DEVPATH=/class/firmware/snd_card_aica FIRMWARE=aica_firmware.bin
PATH=/bin:/sbin:/usr/sbin:/usr/bin ACTION=remove TIMEOUT=10
PWD=/etc/hotplug HOME=/ SHLVL=2 PHYSDEVDRIVER=AICA DEBUG=yes
PHYSDEVBUS=platform SEQNUM=631 _=/usr/bin/env)
Oct  4 16:56:01 uclibc user.notice [810]: no
runnable /etc/hotplug/sound.agent is installed
Oct  4 16:56:01 uclibc user.notice [806]:
invoke /etc/hotplug/firmware.agent ()
Oct  4 16:56:01 uclibc user.notice [842]: arguments (module) env
(SUBSYSTEM=module OLDPWD=/ DEVPATH=/module/snd_card_aica
PATH=/bin:/sbin:/usr/sbin:/usr/bin ACTION=remove PWD=/etc/hotplug HOME=/
SHLVL=2 DEBUG=yes SEQNUM=636 _=/usr/bin/env)
Oct  4 16:56:01 uclibc user.notice [842]: no
runnable /etc/hotplug/module.agent is installed



> Adrian
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by:
> Power Architecture Resource Center: Free content, downloads, discussions,
> and more. http://solutions.newsforge.com/ibmarch.tmpl
> _______________________________________________
> linuxsh-dev mailing list
> linuxsh-dev@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linuxsh-dev



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl

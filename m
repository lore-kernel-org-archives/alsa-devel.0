From: Peter Ganzhorn <shutdown@brend.org>
Subject: alsa-driver in the kernel [Addition]
Date: Fri, 25 Nov 2005 20:28:42 +0100
Message-ID: <438765EA.7060001@brend.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
   boundary="------------040802040409010301050804"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------040802040409010301050804
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

A few minutes ago I had the idea of searching for a solution on Google, 
and I found something interesting:
http://gimpel.gi.funpic.de/Howtos/ALSA-CVS_to_kernel/

It seems using this script takes me closer to my goal, but I still get 
errors:

  CC      sound/sound_core.o
  CC      sound/sound_firmware.o
  LD      sound/soundcore.o
  LD      sound/arm/built-in.o
  CC      sound/core/hwdep.o
  CC      sound/core/memalloc.o
  CC      sound/core/sgbuf.o
  CC      sound/core/pcm.o
  CC      sound/core/pcm_native.o
  CC      sound/core/pcm_lib.o
  CC      sound/core/pcm_timer.o
  CC      sound/core/pcm_misc.o
  CC      sound/core/pcm_memory.o
  CC      sound/core/rawmidi.o
  CC      sound/core/rtctimer.o
  CC      sound/core/timer.o
  CC      sound/core/sound.o
sound/core/sound.c:35:35: linux/platform_device.h: No such file or directory
sound/core/sound.c:55: error: parse error before numeric constant
sound/core/sound.c:55: warning: type defaults to `int' in declaration of 
`MODULE_ALIAS_CHARDEV_MAJOR'
sound/core/sound.c:55: warning: function declaration isn't a prototype
sound/core/sound.c:55: warning: data definition has no type or storage class
sound/core/sound.c: In function `snd_register_device':
sound/core/sound.c:234: warning: implicit declaration of function 
`class_device_create'
sound/core/sound.c: In function `snd_unregister_device':
sound/core/sound.c:266: warning: implicit declaration of function 
`class_device_destroy'
make[2]: *** [sound/core/sound.o] Error 1
make[1]: *** [sound/core] Error 2
make: *** [sound] Error 2

I think the problem is that some include-files have moved, how can I 
solve this fast and correctly?
Thanks in advance,

Peter

--------------040802040409010301050804
Content-Type: message/rfc822;
 name="alsa-driver in the kernel"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alsa-driver in the kernel"

Message-ID: <438761DD.3090009@brend.org>
Date: Fri, 25 Nov 2005 20:11:25 +0100
From: Peter Ganzhorn <shutdown@brend.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: alsa-devel@lists.sourceforge.net
Subject: alsa-driver in the kernel
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi there,

there are several hints on how to update the in-kernel alsa driver with 
the alsa driver one can download from alsa-project.org, but I had no 
luck at all updating kernel 2.6.14.3 with alsa 1.0.10 - it seems that 
there is something missing in the kernel, but there is nothing more 
mentioned to do in the howtos.

Actually my make process ends like this after updating the in-kernel driver:

  CC      sound/sound_core.o
  CC      sound/sound_firmware.o
  LD      sound/soundcore.o
  LD      sound/arm/built-in.o
  CC      sound/core/hwdep.o
sound/core/hwdep.c: In function `snd_hwdep_open':
sound/core/hwdep.c:84: error: `snd_major' undeclared (first use in this 
function)
sound/core/hwdep.c:84: error: (Each undeclared identifier is reported 
only once
sound/core/hwdep.c:84: error: for each function it appears in.)
make[2]: *** [sound/core/hwdep.o] Error 1
make[1]: *** [sound/core] Error 2
make: *** [sound] Error 2


So my question is if there is a good and up2date howto for updating the 
alsa driver in the kernel with those from alsa-project.org which are 
usually a bit more current.
I do not want to build alsa as modules, because I want a compact kernel 
without many modules.

It would be great if you could tell me what is necessary to do in order 
to get this working! :)

Peter


--------------040802040409010301050804--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click

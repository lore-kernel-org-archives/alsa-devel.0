From: Pedro Lopez-Cabanillas <plcl@telefonica.net>
Subject: Re: Alsa-devel digest, Vol 1 #896 - 15 msgs
Date: Tue, 17 Dec 2002 22:29:35 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200212172229.36021.plcl@telefonica.net>
References: <E18OFZy-0000Ic-00@sc8-sf-list2.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <E18OFZy-0000Ic-00@sc8-sf-list2.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Hi,

On Tuesday 17 December 2002 12:07, Takashi Iwai wrote:
> the behavior depends on the order of booting.
> if the hotplug service is booted before the alsasound init script,
> hotplug will start the snd-usbaudio module, which will be assigned as
> the first empty device, i.e. device #0, unless you specify the index
> option.  and afterwards, the alsasound script is started, and it
> results in the confliction of devices.
>
> setting an index option is one of the solutions.
> in this case, the first usb-audio/midi device will be forced to be
> assigned to #1.  so, it's safe to start it beforehand.
>
> but, when we take a deeper look at this, we find another problem.
> the alsasound init script checks whether the ALSA was already started
> by checking the existence of /proc/asound directory.  and, if hotplug
> started the usb-audio/midi before alsasound, this directory would be
> also created because the alsa core was started without help of
> alsasound init script, too.  this leads to the skip of loading of any
> other soundcards, because alsasound will quit immediately.
>
> after all, a simple solution for this is to make sure that alsasound
> starts before hotplug.  then, even the index option for snd-usbaudio
> wouldn't be necessary (in theory).

I'm running a Mandrake 8.something here, where usb is started before alsa, and 
this order is good IMHO. The usb init script loads the HCD driver (uhci, 
ohci...) and related modules, then mounts usbfs (/proc/bus/usb filesystem). 
This enables hotplug, needed if you want to use a Midiman2x2 or any other 
device requiring firmware loading. 

But, as you said, hotplug can load snd-usb-audio driver by itself, (if some 
usb midi or audio device is plugged at boot time) and then the alsasound 
script fails to load other drivers, as it finds /proc/asound already mounted.

My easy and ugly workaround is to add one more line to the bottom of 
/etc/hotplug/blacklist file with a "snd-usb-audio" string. This prevents 
hotplug from loading that module, which is done by the alsasound script some 
time later.

Regards,
Pedro

-- 
ALSA Library Bindings for Pascal
http://alsapas.alturl.com



-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/

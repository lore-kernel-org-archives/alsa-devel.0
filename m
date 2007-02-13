From: Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: Q: How to detect which USx2y is connected?
Date: Tue, 13 Feb 2007 21:01:35 +0000
Message-ID: <45D2272F.5060105@rncbc.org>
References: <20070205065636.GA1652@elte.hu>
	<s5hire6c5jo.wl%tiwai@suse.de>	<45D1FE83.7000301@rncbc.org>
	<200702132003.44102.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <200702132003.44102.annabellesgarden@yahoo.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Karsten Wiese <annabellesgarden@yahoo.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Karsten Wiese wrote:
>> How about using snd_pcm_hw_params_get_channels_max() ?
>> At least on capture the US224 should give 2 and the US428 should give 4
>> as the maximum number of channels.
>>
>> It would be handful for me if the attached test program could be ran
>> against a US428, just for the records ;)
>>
>> On my US224 it gives:
>>
>> $ snd_hwdep_info hw:3
>> ---hwdep---
>> snd_hwdep_info_get_id   (hw:3) = 'USX2Y Loader'
>> snd_hwdep_info_get_name (hw:3) = '/proc/bus/usb/001/004'
>> ---pcm (capture)---
>> snd_pcm_hw_params_get_channels_min(hw:3) = 2
>> snd_pcm_hw_params_get_channels_max(hw:3) = 2
>> ---pcm (playback)---
>> snd_pcm_hw_params_get_channels_min(hw:3) = 2
>> snd_pcm_hw_params_get_channels_max(hw:3) = 2
>>
>> Karsten?
> 
>  ./a.out hw:1
> ---hwdep---
> snd_hwdep_info_get_id   (hw:1) = 'USX2Y Loader'
> snd_hwdep_info_get_name (hw:1) = '/proc/bus/usb/004/007'
> ---pcm (capture)---
> snd_pcm_hw_params_get_channels_min(hw:1) = 2
> snd_pcm_hw_params_get_channels_max(hw:1) = 2
> ---pcm (playback)---
> snd_pcm_hw_params_get_channels_min(hw:1) = 2
> snd_pcm_hw_params_get_channels_max(hw:1) = 2
> 
> The 428's 4 capture channels are only visible to the raw-usb jack thing.
> and this is only there for module param nrpacks=1.....
> 
> What do you see in your /sys/bus/usb/devices/... ?
> (Not that I knew how to deduce the sysfs file from the hwdep->name)
> 

We're in trouble... there must be another way. What about the shm
accessed from us428control? Is there supposed to be some watermark or
something? Maybe even the number of fader-channels, who knoes? I'm
afraid only you Karsten can grok that ;)


Anyway, here what I could grab, anyway:

# ls -l /sys/bus/usb/drivers/snd-usb-usx2y/
total 0
lrwxrwxrwx 1 root root    0 Feb 13 20:45 1-1:1.0 ->
../../../../devices/pci0000:00/0000:00:1d.0/usb1/1-1/1-1:1.0
--w------- 1 root root 4096 Feb 13 20:45 bind
lrwxrwxrwx 1 root root    0 Feb 13 20:45 module ->
../../../../module/snd_usb_usx2y
--w------- 1 root root 4096 Feb 13 20:45 new_id
--w------- 1 root root 4096 Feb 13 20:45 unbind

# ls -l /sys/bus/usb/devices/1-1/
total 0
drwxr-xr-x 3 root root    0 Feb 13 20:50 1-1:1.0
-rw-r--r-- 1 root root 4096 Feb 13 20:39 bConfigurationValue
-r--r--r-- 1 root root 4096 Feb 13 20:39 bDeviceClass
-r--r--r-- 1 root root 4096 Feb 13 20:39 bDeviceProtocol
-r--r--r-- 1 root root 4096 Feb 13 20:39 bDeviceSubClass
-r--r--r-- 1 root root 4096 Feb 13 20:39 bMaxPacketSize0
-r--r--r-- 1 root root 4096 Feb 13 20:39 bMaxPower
-r--r--r-- 1 root root 4096 Feb 13 20:39 bNumConfigurations
-r--r--r-- 1 root root 4096 Feb 13 20:39 bNumInterfaces
-r--r--r-- 1 root root 4096 Feb 13 20:39 bcdDevice
-r--r--r-- 1 root root 4096 Feb 13 20:39 bmAttributes
lrwxrwxrwx 1 root root    0 Feb 13 20:39 bus -> ../../../../../bus/usb
-r--r--r-- 1 root root 4096 Feb 13 20:39 configuration
-r--r--r-- 1 root root 4096 Feb 13 20:39 devnum
lrwxrwxrwx 1 root root    0 Feb 13 20:39 driver ->
../../../../../bus/usb/drivers/usb
lrwxrwxrwx 1 root root    0 Feb 13 20:39 ep_00 ->
../../../../../class/usb_endpoint/usbdev1.6_ep00
-r--r--r-- 1 root root 4096 Feb 13 20:39 idProduct
-r--r--r-- 1 root root 4096 Feb 13 20:39 idVendor
-r--r--r-- 1 root root 4096 Feb 13 20:39 maxchild
drwxr-xr-x 2 root root    0 Feb 13 20:39 power
lrwxrwxrwx 1 root root    0 Feb 13 20:43 sound:audio3 ->
../../../../../class/sound/audio3
lrwxrwxrwx 1 root root    0 Feb 13 20:39 sound:controlC3 ->
../../../../../class/sound/controlC3
lrwxrwxrwx 1 root root    0 Feb 13 20:43 sound:dmmidi3 ->
../../../../../class/sound/dmmidi3
lrwxrwxrwx 1 root root    0 Feb 13 20:43 sound:dsp3 ->
../../../../../class/sound/dsp3
lrwxrwxrwx 1 root root    0 Feb 13 20:39 sound:hwC3D0 ->
../../../../../class/sound/hwC3D0
lrwxrwxrwx 1 root root    0 Feb 13 20:43 sound:hwC3D1 ->
../../../../../class/sound/hwC3D1
lrwxrwxrwx 1 root root    0 Feb 13 20:43 sound:midi3 ->
../../../../../class/sound/midi3
lrwxrwxrwx 1 root root    0 Feb 13 20:43 sound:midiC3D0 ->
../../../../../class/sound/midiC3D0
lrwxrwxrwx 1 root root    0 Feb 13 20:39 sound:mixer3 ->
../../../../../class/sound/mixer3
lrwxrwxrwx 1 root root    0 Feb 13 20:43 sound:pcmC3D0c ->
../../../../../class/sound/pcmC3D0c
lrwxrwxrwx 1 root root    0 Feb 13 20:43 sound:pcmC3D0p ->
../../../../../class/sound/pcmC3D0p
lrwxrwxrwx 1 root root    0 Feb 13 20:43 sound:pcmC3D2c ->
../../../../../class/sound/pcmC3D2c
lrwxrwxrwx 1 root root    0 Feb 13 20:43 sound:pcmC3D2p ->
../../../../../class/sound/pcmC3D2p
-r--r--r-- 1 root root 4096 Feb 13 20:39 speed
lrwxrwxrwx 1 root root    0 Feb 13 20:39 subsystem -> ../../../../../bus/usb
--w------- 1 root root 4096 Feb 13 20:39 uevent
lrwxrwxrwx 1 root root    0 Feb 13 20:39 usb_device:usbdev1.6 ->
../../../../../class/usb_device/usbdev1.6
lrwxrwxrwx 1 root root    0 Feb 13 20:39 usb_endpoint:usbdev1.6_ep00 ->
../../../../../class/usb_endpoint/usbdev1.6_ep00
-r--r--r-- 1 root root 4096 Feb 13 20:39 version

# cat /sys/bus/usb/devices/1-1/{idVendor,idProduct}
1604
8005


Cheers.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642

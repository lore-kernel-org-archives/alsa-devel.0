From: "John wr" <john_wr@hotmail.com>
Subject: Upgrading Mandrake 10.0
Date: Mon, 25 Oct 2004 20:04:07 +1000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <BAY17-F7cf3ednHM3SO0000e06e@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

Hello.

I am a relatively new Linux user and I really need some pointers upgrading 
Mandrake 10.0 to use the of ALSA drivers/lib/utils 1.0.6a or later.  I have 
tried them all.  I need support from my Terratec Aureon 7.1 (ice1724) card.

I am running 2.6.3-7mdk kernel, and obviously got the matching kernel source 
package from Mandrake CD.  Alsa seems to compile fine, but can't modprobe 
snd-ice1724.

-------------------------------------------------------------------------------------------------
[root@LinuxPC alsa-utils-1.0.7rc2]# modprobe snd-ice1724

WARNING: Error inserting snd-mpu401-uart 
(/lib/modules/2.6.3-7mdk/kernel/sound/drivers/mpu401/snd-mpu401-uart.ko.gz): 
Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd-ac97-codec 
(/lib/modules/2.6.3-7mdk/kernel/sound/pci/ac97/snd-ac97-codec.ko.gz): 
Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd-mpu401-uart 
(/lib/modules/2.6.3-7mdk/kernel/sound/drivers/mpu401/snd-mpu401-uart.ko.gz): 
Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd-ac97-codec 
(/lib/modules/2.6.3-7mdk/kernel/sound/pci/ac97/snd-ac97-codec.ko.gz): 
Unknown symbol in module, or unknown parameter (see dmesg)
FATAL: Error inserting snd-ice1724 
(/lib/modules/2.6.3-7mdk/kernel/sound/pci/ice1712/snd-ice1724.ko): Unknown 
symbol in module, or unknown parameter (see dmesg)
FATAL: Error running install command for snd-ice1724
-----------------------------------------------------------------------------------------------------------------------

dmesg reporsts lots of "Unknown symbol" and "disagrees about version".  eg:

---------------------------------------------------------------------------------------------------------------------
[root@LinuxPC alsa-utils-1.0.7rc2]# dmesg

snd-mpu401-uart: Unknown symbol snd_rawmidi_receive
snd-mpu401-uart: disagrees about version of symbol snd_rawmidi_transmit_ack
snd-mpu401-uart: Unknown symbol snd_rawmidi_transmit_ack
snd-mpu401-uart: Unknown symbol snd_kcalloc
snd-mpu401-uart: disagrees about version of symbol snd_rawmidi_transmit_peek
snd-mpu401-uart: Unknown symbol snd_rawmidi_transmit_peek
snd-mpu401-uart: disagrees about version of symbol snd_rawmidi_new
snd-mpu401-uart: Unknown symbol snd_rawmidi_new
snd-mpu401-uart: disagrees about version of symbol snd_rawmidi_set_ops
snd-mpu401-uart: Unknown symbol snd_rawmidi_set_ops
snd-mpu401-uart: disagrees about version of symbol snd_device_free
snd-mpu401-uart: Unknown symbol snd_device_free
snd-mpu401-uart: disagrees about version of symbol snd_rawmidi_receive
snd-mpu401-uart: Unknown symbol snd_rawmidi_receive
snd-mpu401-uart: disagrees about version of symbol snd_rawmidi_transmit_ack
snd-mpu401-uart: Unknown symbol snd_rawmidi_transmit_ack
snd-mpu401-uart: Unknown symbol snd_kcalloc
snd-mpu401-uart: disagrees about version of symbol snd_rawmidi_transmit_peek
snd-mpu401-uart: Unknown symbol snd_rawmidi_transmit_peek
snd-mpu401-uart: disagrees about version of symbol snd_rawmidi_new
snd-mpu401-uart: Unknown symbol snd_rawmidi_new
snd-mpu401-uart: disagrees about version of symbol snd_rawmidi_set_ops
snd-mpu401-uart: Unknown symbol snd_rawmidi_set_ops
snd-mpu401-uart: disagrees about version of symbol snd_device_free
snd-mpu401-uart: Unknown symbol snd_device_free
---------------------------------------------------------------------------------------------------------------------

I am hopeful that someone has come across this before.

regards,
John.




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl

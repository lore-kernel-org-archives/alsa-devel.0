From: Philip Prindeville <philipp_subx@redfish-solutions.com>
Subject: Disagreement about versions following CVS update
Date: Fri, 19 Aug 2005 13:33:28 -0600
Message-ID: <43063408.60402@redfish-solutions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
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

I did a CVS update yesterday, and a rebuild and tried to reinstall, and
I'm seeing:

WARNING: Error inserting snd_seq_device 
(/lib/modules/2.6.12-1.1372_FC3/kernel/sound/acore/seq/snd-seq-device.ko): 
Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_rawmidi 
(/lib/modules/2.6.12-1.1372_FC3/kernel/sound/acore/snd-rawmidi.ko): 
Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_mpu401_uart 
(/lib/modules/2.6.12-1.1372_FC3/kernel/sound/drivers/mpu401/snd-mpu401-uart.ko): 
Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_timer 
(/lib/modules/2.6.12-1.1372_FC3/kernel/sound/acore/snd-timer.ko): 
Unknown symbol in module, or unknown parameter (see dmesg)
WARNING: Error inserting snd_timer 
(/lib/modules/2.6.12-1.1372_FC3/kernel/sound/acore/snd-timer.ko): 
Unknown symbol in module, or unknown parameter (see dmesg)
FATAL: Error inserting snd_pcm 
(/lib/modules/2.6.12-1.1372_FC3/kernel/sound/acore/snd-pcm.ko): Unknown 
symbol in module, or unknown parameter (see dmesg)
WARNING: Error running install command for snd_pcm
WARNING: Error inserting snd_ac97_codec 
(/lib/modules/2.6.12-1.1372_FC3/kernel/sound/pci/ac97/snd-ac97-codec.ko): 
Unknown symbol in module, or unknown parameter (see dmesg)
FATAL: Error inserting snd_via82xx 
(/lib/modules/2.6.12-1.1372_FC3/kernel/sound/pci/snd-via82xx.ko): 
Unknown symbol in module, or unknown parameter (see dmesg)

Stupid question:  did a version number get changed somewhere?  And if
so, what's the fix?  I did a:

% make -C alsa-driver clean

and a rebuild, but I'm still seeing these.  What did I miss?

-Philip



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf

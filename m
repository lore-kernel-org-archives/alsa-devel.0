From: Friedrich Ewaldt <friedrich.ewaldt@gmx.de>
Subject: Re: Re: [Alsa-user] fm801 driver status?
Date: Fri, 13 Dec 2002 12:17:33 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DF9C1CD.3090205@gmx.de>
References: <3DF8A109.2030206@gmx.de> <s5hel8nuvee.wl@alsa2.suse.de>	<3DF8B8FA.3040009@gmx.de> <s5h3cp3uorz.wl@alsa2.suse.de> <m27keexn25.fsf@vador.mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Thierry Vignaud <tvignaud@mandrakesoft.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-user@lists.sourceforge.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi!
For new test results see the end of this mail.

Thierry Vignaud wrote:

>Takashi Iwai <tiwai@suse.de> writes:
>
>  
>
>>>Mandrake Control Center recognices the card as follows (partly in
>>>german, sorry, but perhaps that's no problem in ERL/NUE ;-) ):
>>>
>>>Hersteller: Fortemedia, Inc
>>>Bus: PCI
>>>Bus: 1319:801:1319:1319
>>>Standort auf den Bus: 0:b:0
>>>Beschreibung: Xwave QS3000A [FM801]
>>>Modul: snd-fm801
>>>Medienklasse: MULTIMEDIA_AUDIO
>>>      
>>>
>
>this information came frome harddrake which uses libldetect (which is
>also used by lspcidrake).
>
>bus is vendor_id:card_id:subvendor_id:subcard_id
>bus position (Standort auf den Bus) is pci_bus:pci_device:pci_function
>Beschreibung is of course description of the device and Hersteller is
>vendor
>module is of course kernel module
>
>the driver association is made by libldetect from
>/usr/share/ldetect-lst/pcitable :
>
>tv@vador ~ $ fgrep fm801 /usr/share/ldetect-lst/pcitable
>0x1319  0x0801  "snd-fm801"  "Fortemedia, Inc|Xwave QS3000A [FM801]"
>0x1319  0x1000  "snd-fm801"  "Fortemedia, Inc|FM801 PCI Audio"
>
>  
>
>>>I had no alsa installed while running hardware detection.
>>>      
>>>
>
>alsa drivers're included in mandrake kernel
>  
>
No, sorry. I recompiled the kernel with sound but without alsa because I 
wanted to use an alsa version newer than rc2 to check if the problem was 
solved already. I already installed rc6 and a newer cvs version on 
another mdk9.0 system without problems. I should have done 
recompiling/installing the kernel and newer alsa version correctly.

>>you can check this also via lspci command.
>>    
>>
>
>lspcidrake -v will give him the module too
>  
>
I already attached my lspci -v outputs in two previous mails, but to be 
sure they get to where they should ...

00:0b.0 Multimedia audio controller: Fortemedia, Inc Xwave QS3000A
[FM801] (rev a0)
        Subsystem: Fortemedia, Inc: Unknown device 1319
        Flags: bus master, medium devsel, latency 40, IRQ 10
        I/O ports at ec00 [size=128]
        Capabilities: [dc] Power Management version 1

00:0b.1 Input device controller: Fortemedia, Inc Xwave QS3000A [FM801]
(rev a0)
        Subsystem: Fortemedia, Inc: Unknown device 1319
        Flags: bus master, medium devsel, latency 40, IRQ 11
        Capabilities: [dc] Power Management version 1

>>in the output of lspci in your last mail, the i/o ports and irq are
>>missing.  please check again?
>>    
>>
>
>in order to have the full information, i would like Friedrich to send
>us the following information (what i call the classic bug sound
>tester) :
>
>"lspcidrake -v | fgrep AUDIO" will tell you which driver your card use
>by default
>
>"grep snd-slot /etc/modules.conf" will tell you what driver it
>currently uses
>  
>
I threw out all entries regarding soundcards from modules.conf. 
modprobing the snd-fm801 module is enough to cause the problems.

>"/sbin/lsmod" will enable you to check if its module (driver) is
>loaded or not
>
no sound module is loaded (because nothing there in modules.conf) up to 
the point where I do a 'modprobe snd-fm801'. As soon as I do,  the 
following modules are added:

snd-fm801               9772   0 (unused)
snd-pcm                71328   0 [snd-fm801]
snd-mpu401-uart         3840   0 [snd-fm801]
snd-rawmidi            15424   0 [snd-mpu401-uart]
snd-opl3-lib            7652   0 [snd-fm801]
snd-timer              12908   0 [snd-pcm snd-opl3-lib]
snd-hwdep               5152   0 [snd-opl3-lib]
snd-ac97-codec         31620   0 [snd-fm801]
snd                    36076   0 [snd-fm801 snd-pcm snd-mpu401-uart 
snd-rawmidi snd-opl3-lib snd-timer snd-hwdep snd-ac97-codec]
soundcore               4068   0 [snd]

>
>"/sbin/chkconfig --list sound" and "/sbin/chkconfig --list alsa" will
>tell you if sound and alsa services're configured to be run on
>initlevel 3
>
>"aumix -q" will tell you if the sound volume is muted or not
>  
>
no mixer problems

>"/sbin/fuser -v /dev/dsp" will tell which program uses the sound card.
>  
>
none. I've deactivated artsd and have no other sound daemon installed. 
The only programs that produce sound are controlled by me. (But now I 
know that even hitting backspace once in Konsole causes a beep that 
locks the system. Not really! The END of the beep does! see below)

>
>this will tell us at which stage the problem happen
>
>  
>
OK. I've done new tries. Now I know that modprobing snd-fm801 causes the 
following to be written in /var/log/messages:
Dec 13 11:53:24 localhost kernel: ALSA ../alsa-kernel/pci/fm801.c:922:
unable to grab region 0x0-0x7f

If I do not produce any sound output, the system does not lock up as 
I've written before (I must have caused an error beep in a KDE terminal. 
I've tried this: Causing a beep locks the system immediately). Sorry for 
the misleading information. My fault.
After another reboot (always interesting if the filesystem was damaged 
;-) ), I modprobed snd-fm801 and used aplay to play a wav file. It does 
without problems. But at the same time the playback stops, the system 
locks up.
So, in summary, the critical moment is stopping playback on the fm801. I 
think, I've read the same problem description somewhere before. What 
could I try next?
Thanks for all your help so far!
fe




-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/

From: Gou Zhuang <gouzhuang@bigfoot.com>
Subject: Re: Oops on resume, X crashes
Date: Thu, 23 Oct 2003 17:12:08 +0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F979B68.9030006@bigfoot.com>
References: <3F939367.80804@bigfoot.com>	<s5h4qy4dkx5.wl@alsa2.suse.de>	<3F94F094.80109@Sun.COM> <s5hr816de2j.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hr816de2j.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Gou Zhuang <gouzhuang@bigfoot.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org



Takashi Iwai wrote:
> At Tue, 21 Oct 2003 16:38:44 +0800,
> Bill Gou wrote:
> 
>>[1  <text/plain; us-ascii (7bit)>]
>>Takashi Iwai wrote:
>>
>>>At Mon, 20 Oct 2003 15:48:55 +0800,
>>>Gou Zhuang wrote:
>>>
>>>
>>>>I'm running kernel 2.4.22 and alsa-0.9.7c on a Dell laptop. I have problem on
>>>>suspend/resume when alsa modules loaded. I have done a few testings, below is my findings:
>>>>
>>>>If the snd-pcm-oss module is in use(by arts sound server) at the time of suspend, kernel
>>>>oops upon resuming and X server crashes. It has no problem when snd-pcm-oss is not in use(
>>>>released by arts). 0.9.6 has the same behavior. My sound card is on-board intel8x0.
>>>>
>>>>I searched the mail archive and didn't find any similar cases. Could anybody look into
>>>>this problem?
>>>
>>>
>>>i don't see any obvious bugs in the resume code, and i thought it
>>>worked fine once on my test machine.
>>>could you check at which funciton the oops occurs, e.g. simply by
>>>puttig debug printk at each entry point?  according to ksymoops, it's
>>>in snd_intel8x0_resume() (i.e. intel8x0_resume()).  this could be
>>>either in snd_intel8x0_chip_init() or snd_ac97_resume().
>>>in the latter function, there is no sleep or no wakeup, so it's likely
>>>in the former one.
>>>
>>>
>>>Takashi
>>>
>>
>>I added some printks in intel8x0.c and ac97_codec.c, all printk outputs are labeled
>>'MYDEBUG'. I also enabled debug when compiling. This time I noticed the below debug
>>message after resuming, it repeated for 170 times:
>>
>>ALSA pcm_oss.c:552: snd_pcm_oss_prepare: SNDRV_PCM_IOCTL_PREPARE failed
> 
>  
> that's strange if this message appears before snd_intel8x0_resume() is
> called.  if it's after the resume() call, it's ok.
> 
I turned on OSS_DEBUG in pcm_oss.c. I did not start X this time, I only started artsd from
console to reproduce the oops. Below is the messages after resume, my comments are marked
with <<<---------

-------------------------
MYDEBUG intel8x0.c:2141: Entering intel8x0_suspend()
MYDEBUG intel8x0.c:2149: Call snd_pcm_suspend_all() on Intel 82801CA-ICH3
MYDEBUG intel8x0.c:2149: Call snd_pcm_suspend_all() on Intel 82801CA-ICH3 - MIC ADC
MYDEBUG intel8x0.c:2152: Call snd_power_change_state(card, SNDRV_CTL_POWER_D3hot)
MYDEBUG intel8x0.c:2154: Return from snd_power_change_state()
pcm_oss: ioctl = 0x8010500c
pcm_oss: space: bytes = 7168, fragments = 7, fragstotal = 7, fragsize = 1024
pcm_oss: write: recovering from SUSPEND
ALSA pcm_oss.c:552: snd_pcm_oss_prepare: SNDRV_PCM_IOCTL_PREPARE failed
pcm_oss: write 1024 bytes (wrote -11 bytes)  <<<----------- IT SEEMS THE WRITE FAILED!
MYDEBUG intel8x0.c:2162: Entering intel8x0_resume()
MYDEBUG intel8x0.c:2167: Call pci_enable_device(chip->pci)
PCI: Found IRQ 11 for device 00:1f.5
PCI: Sharing IRQ 11 with 00:1f.6
MYDEBUG intel8x0.c:2169: Call pci_set_master(chip->pci)
PCI: Setting latency timer of device 00:1f.5 to 64
MYDEBUG intel8x0.c:2067: Entering snd_intel8x0_chip_init()
MYDEBUG ../../alsa-kernel/pci/ac97/ac97_codec.c:2148: Entering snd_ac97_resume()
MYDEBUG ../../alsa-kernel/pci/ac97/ac97_codec.c:2148: Entering snd_ac97_resume()
MYDEBUG intel8x0.c:2177: Call snd_power_change_state(card, SNDRV_CTL_POWER_D0)
Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c0115f09
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0115f09>]    Not tainted
EFLAGS: 00010046
eax: d7ed2e0c   ebx: d7ed2e14   ecx: d7783b2c   edx: 00000000
esi: d7ed2fc4   edi: 00000003   ebp: d567debc   esp: d567dea0
ds: 0018   es: 0018   ss: 0018
Process apmd (pid: 804, stackpage=d567d000)
Stack: d8be418f 00000000 00000001 00000282 00000003 d75f5418 d7ed2e14 00000000
       d8bf5cd8 d8bf7840 d8bf70aa 00000881 c1437808 c1439eb4 c1439ea0 d8bf5dbf
       d75f5418 d8c0fe91 d73cfcc0 c1438808 c021cd96 c1437800 c021cecb c1437800
Call Trace:    [<d8be418f>] [<d8bf5cd8>] [<d8bf7840>] [<d8bf70aa>] [<d8bf5dbf>]
  [<d8c0fe91>] [<c021cd96>] [<c021cecb>] [<c021d013>] [<c021d075>] [<c0126fe2>]
  [<c01270e4>] [<c0113973>] [<c011408c>] [<c0148cc9>] [<c013b504>] [<c010740f>]

Code: 8b 02 89 d3 89 c2 0f 18 00 39 f3 75 ea ff 75 f0 9d 83 c4 10
 <6>usb.c: USB disconnect on device 00:1d.0-1 address 4
hub.c: new USB device 00:1d.0-1, assigned address 5
input: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on usb1:5.0
-----------------------------

It looks like the error message was emitted from snd_pcm_oss_write3() in pcm_oss.c. There
must be a process(artsd?) trying to write to oss device before intel8x0_resume() is
called. Can we block those writes until intel8x0_resume() returns?


ksymoops output:
------------------------------
ksymoops 2.4.9 on i686 2.4.22.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.22/ (default)
     -m /boot/System.map-2.4.22 (specified)

MYDEBUG intel8x0.c:2141: Entering intel8x0_suspend()
MYDEBUG intel8x0.c:2149: Call snd_pcm_suspend_all() on Intel 82801CA-ICH3
MYDEBUG intel8x0.c:2149: Call snd_pcm_suspend_all() on Intel 82801CA-ICH3 - MIC ADC
MYDEBUG intel8x0.c:2152: Call snd_power_change_state(card, SNDRV_CTL_POWER_D3hot)
MYDEBUG intel8x0.c:2154: Return from snd_power_change_state()
MYDEBUG intel8x0.c:2162: Entering intel8x0_resume()
MYDEBUG intel8x0.c:2167: Call pci_enable_device(chip->pci)
MYDEBUG intel8x0.c:2169: Call pci_set_master(chip->pci)
MYDEBUG intel8x0.c:2067: Entering snd_intel8x0_chip_init()
MYDEBUG ../../alsa-kernel/pci/ac97/ac97_codec.c:2148: Entering snd_ac97_resume()
MYDEBUG ../../alsa-kernel/pci/ac97/ac97_codec.c:2148: Entering snd_ac97_resume()
MYDEBUG intel8x0.c:2177: Call snd_power_change_state(card, SNDRV_CTL_POWER_D0)
Unable to handle kernel NULL pointer dereference at virtual address 00000000
c0115f09
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0115f09>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010046
eax: d7ed2e0c   ebx: d7ed2e14   ecx: d7783b2c   edx: 00000000
esi: d7ed2fc4   edi: 00000003   ebp: d567debc   esp: d567dea0
ds: 0018   es: 0018   ss: 0018
Process apmd (pid: 804, stackpage=d567d000)
Stack: d8be418f 00000000 00000001 00000282 00000003 d75f5418 d7ed2e14 00000000
       d8bf5cd8 d8bf7840 d8bf70aa 00000881 c1437808 c1439eb4 c1439ea0 d8bf5dbf
       d75f5418 d8c0fe91 d73cfcc0 c1438808 c021cd96 c1437800 c021cecb c1437800
Call Trace:    [<d8be418f>] [<d8bf5cd8>] [<d8bf7840>] [<d8bf70aa>] [<d8bf5dbf>]
  [<d8c0fe91>] [<c021cd96>] [<c021cecb>] [<c021d013>] [<c021d075>] [<c0126fe2>]
  [<c01270e4>] [<c0113973>] [<c011408c>] [<c0148cc9>] [<c013b504>] [<c010740f>]
Code: 8b 02 89 d3 89 c2 0f 18 00 39 f3 75 ea ff 75 f0 9d 83 c4 10


>>EIP; c0115f09 <__wake_up+39/80>   <=====

>>eax; d7ed2e0c <_end+17b68f88/1880b1dc>
>>ebx; d7ed2e14 <_end+17b68f90/1880b1dc>
>>ecx; d7783b2c <_end+17419ca8/1880b1dc>
>>esi; d7ed2fc4 <_end+17b69140/1880b1dc>
>>ebp; d567debc <_end+15314038/1880b1dc>
>>esp; d567dea0 <_end+1531401c/1880b1dc>

Trace; d8be418f <[snd-pcm]snd_pcm_playback_drain+25f/2e0>
Trace; d8bf5cd8 <[snd-intel8x0]intel8x0_resume+108/140>
Trace; d8bf7840 <[snd-intel8x0]__module_parm_desc_mpu_port+52c/9ac>
Trace; d8bf70aa <[snd-intel8x0]__module_description+16/55>
Trace; d8bf5dbf <[snd-intel8x0]snd_intel8x0_resume+4f/60>
Trace; d8c0fe91 <[uhci]uhci_pci_resume+21/30>
Trace; c021cd96 <pci_pm_resume_device+26/30>
Trace; c021cecb <pci_pm_resume_bus+2b/70>
Trace; c021d013 <pci_pm_resume+33/50>
Trace; c021d075 <pci_pm_callback+45/50>
Trace; c0126fe2 <pm_send+72/a0>
Trace; c01270e4 <pm_send_all+74/b0>
Trace; c0113973 <suspend+e3/120>
Trace; c011408c <do_ioctl+10c/180>
Trace; c0148cc9 <sys_ioctl+c9/250>
Trace; c013b504 <fsync_dev+54/60>
Trace; c010740f <system_call+33/38>

Code;  c0115f09 <__wake_up+39/80>
00000000 <_EIP>:
Code;  c0115f09 <__wake_up+39/80>   <=====
   0:   8b 02                     mov    (%edx),%eax   <=====
Code;  c0115f0b <__wake_up+3b/80>
   2:   89 d3                     mov    %edx,%ebx
Code;  c0115f0d <__wake_up+3d/80>
   4:   89 c2                     mov    %eax,%edx
Code;  c0115f0f <__wake_up+3f/80>
   6:   0f 18 00                  prefetchnta (%eax)
Code;  c0115f12 <__wake_up+42/80>
   9:   39 f3                     cmp    %esi,%ebx
Code;  c0115f14 <__wake_up+44/80>
   b:   75 ea                     jne    fffffff7 <_EIP+0xfffffff7>
Code;  c0115f16 <__wake_up+46/80>
   d:   ff 75 f0                  pushl  0xfffffff0(%ebp)
Code;  c0115f19 <__wake_up+49/80>
  10:   9d                        popf
Code;  c0115f1a <__wake_up+4a/80>
  11:   83 c4 10                  add    $0x10,%esp
---------------------------------

It's a bit different than previous ones, possibly because there's no X started.

> 
> 
>>The last function called before kernel oops is snd_power_change_state().
> 
> 
> yes, it looks like the wake_up() in that function.
> but it should be ok.  perhaps memory corruption already occured
> somewhere.  anyway, try to comment out the wake_up() there.
> 
> 
> also, please try to do suspend with the minimum setting - i.e.
> no applications running but just only the drivers.
> 

I tried suspend with minimum setting(fresh reboot and no X window), no trouble found. I
also tried to suspend while playing mp3 with amp at console, it seems ok too, except 1
"Unexpected hw_pointer value" message before entering intel8x0_suspend():

-------------------------
....
pcm_oss: write 4096 bytes (wrote 4096 bytes)  <<<---- PLAYING MP3
pcm_oss: write 4096 bytes (wrote 4096 bytes)
ALSA ../alsa-kernel/core/pcm_lib.c:182: Unexpected hw_pointer value (stream = 0, delta:
 -7432, max jitter = 8192): wrong interrupt acknowledge?
MYDEBUG intel8x0.c:2141: Entering intel8x0_suspend()   <<<----- GOING TO SUSPEND
MYDEBUG intel8x0.c:2149: Call snd_pcm_suspend_all() on Intel 82801CA-ICH3
MYDEBUG intel8x0.c:2149: Call snd_pcm_suspend_all() on Intel 82801CA-ICH3 - MIC ADC
MYDEBUG intel8x0.c:2152: Call snd_power_change_state(card, SNDRV_CTL_POWER_D3hot)
MYDEBUG intel8x0.c:2154: Return from snd_power_change_state()
pcm_oss: write: recovering from SUSPEND
MYDEBUG intel8x0.c:2162: Entering intel8x0_resume()
MYDEBUG intel8x0.c:2167: Call pci_enable_device(chip->pci)
PCI: Found IRQ 11 for device 00:1f.5
PCI: Sharing IRQ 11 with 00:1f.6
MYDEBUG intel8x0.c:2169: Call pci_set_master(chip->pci)
PCI: Setting latency timer of device 00:1f.5 to 64
MYDEBUG intel8x0.c:2067: Entering snd_intel8x0_chip_init()
MYDEBUG ../../alsa-kernel/pci/ac97/ac97_codec.c:2148: Entering snd_ac97_resume()
MYDEBUG ../../alsa-kernel/pci/ac97/ac97_codec.c:2148: Entering snd_ac97_resume()
MYDEBUG intel8x0.c:2177: Call snd_power_change_state(card, SNDRV_CTL_POWER_D0)
MYDEBUG intel8x0.c:2179: Return from snd_power_change_state()
usb.c: USB disconnect on device 00:1d.0-1 address 3
pcm_oss: write 4096 bytes (wrote 4096 bytes)   <<<---- CONTINUE PLAYING MP3 AFTER RESUMING
pcm_oss: write 4096 bytes (wrote 4096 bytes)
....

-------------------------

It's strange that suspend in the course of playing mp3 can survive the resume, while
suspend with artsd running causes kernel oops on rusume. What is artsd doing?



-------------------------------------------------------
This SF.net email is sponsored by OSDN developer relations
Here's your chance to show off your extensive product knowledge
We want to know what you know. Tell us and you have a chance to win $100
http://www.zoomerang.com/survey.zgi?HRPT1X3RYQNC5V4MLNSV3E54

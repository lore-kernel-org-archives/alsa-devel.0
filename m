From: =?iso-8859-1?q?Chris=20Rankin?= <rankincj@yahoo.com>
Subject: Pain and anguish: ALSA CVS and Linux-2.4.20
Date: Sat, 30 Nov 2002 19:57:43 +0000 (GMT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021130195743.99684.qmail@web40605.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

Hi,

Remind me to NEVER try and update two systems at the
same time again! I have compiled Linux 2.4.20 for my
SMP box with very latest ALSA CVS modules. However,
2.4.20 deadlocked when I rebooted it and needed
rescuing by the NMI watchdog.

Unfortunately, I have not tried these ALSA modules
with my trusty 2.4.19 kernel and so don't know whether
ALSA is to blame or whether its the new devfs. The
balance of opinion on linus-kernel is that it's ALSA:

ksymoops 2.4.8 on i686 2.4.20.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.20/ (default)
     -m /boot/System.map-2.4.20 (specified)

Nov 30 18:26:23 (none) kernel: NMI Watchdog detected
LOCKUP on CPU0, eip c01062f
Nov 30 18:26:23 (none) kernel: CPU:    0
Nov 30 18:26:23 (none) kernel: EIP:   
0010:[__write_lock_failed+15/32]    Not t
Nov 30 18:26:23 (none) kernel: EFLAGS: 00000087
Nov 30 18:26:23 (none) kernel: eax: f770cf4c   ebx:
f78fbd20   ecx: 00000286   e
Nov 30 18:26:23 (none) kernel: esi: f770ce00   edi:
f7e4a220   ebp: f7e4a220   e
Nov 30 18:26:23 (none) kernel: ds: 0018   es: 0018  
ss: 0018
Nov 30 18:26:23 (none) kernel: Process alsactl (pid:
391, stackpage=f76e1000)
Nov 30 18:26:23 (none) kernel: Stack: f88e3010
00000038 000001f0 f88e5c60 f88e13
Nov 30 18:26:23 (none) kernel:        f7e4a220
00000000 f7714a40 f7e4a220 f77139
Nov 30 18:26:23 (none) kernel:        f7e4a220
f76e1f84 c014e7d9 ffffffeb f7e4a2
Nov 30 18:26:23 (none) kernel: Call Trace:   
[<f88e3010>] [<f88e5c60>] [<f88e13
Nov 30 18:26:23 (none) kernel: Code: 75 f6 f0 81 28 00
00 00 01 0f 85 e2 ff ff f
Using defaults from ksymoops -t elf32-i386 -a i386

>>eax; f770cf4c <_end+373d8adc/38511bf0>
>>ebx; f78fbd20 <_end+375c78b0/38511bf0>
>>edx; f78fbd38 <_end+375c78c8/38511bf0>
>>esi; f770ce00 <_end+373d8990/38511bf0>
>>edi; f7e4a220 <_end+37b15db0/38511bf0>
>>ebp; f7e4a220 <_end+37b15db0/38511bf0>
>>esp; f76e1ee8 <_end+373ada78/38511bf0>

Trace; f88e3010 <[snd].text.lock.control+5/135>
Trace; f88e5c60 <[snd]snd_fops+0/48>
Trace; f88e1370 <[snd]snd_ctl_open+0/130>
Trace; f88de22f <[snd]snd_open+df/160>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   75 f6                     jne    fffffff8
<_EIP+0xfffffff8> fffffff8 <EN
Code;  00000002 Before first symbol
   2:   f0 81 28 00 00 00 01      lock subl
$0x1000000,(%eax)
Code;  00000009 Before first symbol
   9:   0f 85 e2 ff ff ff         jne    fffffff1
<_EIP+0xfffffff1> fffffff1 <EN
Code;  0000000f Before first symbol
   f:   c3                        ret    
Code;  00000010 Before first symbol
  10:   90                        nop    
Code;  00000011 Before first symbol
  11:   f0 ff 00                  lock incl (%eax)

To this end, I have been examining recent changes in
the alsa-kernel/core directory. In particular, the
snd_ctl_release() function in the file control.c:

Line 126:

        write_lock_irqsave(&card->control_rwlock,
flags);
        list_del(&ctl->list);
        list_for_each(list, &card->controls) {
                control = snd_kcontrol(list);
                if (control->owner == ctl)
                        control->owner = NULL;
        }
        write_unlock(&card->control_owner_lock);
 
Am I reading this wrong? It looks as if it's taking
one lock but releasing another.

Cheers,
Chris


__________________________________________________
Do You Yahoo!?
Everything you'll ever need on one web page
from News and Sport to Email and Music Charts
http://uk.my.yahoo.com


-------------------------------------------------------
This SF.net email is sponsored by: Get the new Palm Tungsten T 
handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en

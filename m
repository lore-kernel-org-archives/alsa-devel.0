From: Gou Zhuang <gouzhuang@bigfoot.com>
Subject: Oops on resume, X crashes
Date: Mon, 20 Oct 2003 15:48:55 +0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F939367.80804@bigfoot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
To: alsa-devel@lists.sourceforge.net
Cc: Gou Zhuang <gouzhuang@bigfoot.com>
List-Id: alsa-devel@alsa-project.org

I'm running kernel 2.4.22 and alsa-0.9.7c on a Dell laptop. I have problem on
suspend/resume when alsa modules loaded. I have done a few testings, below is my findings:

If the snd-pcm-oss module is in use(by arts sound server) at the time of suspend, kernel
oops upon resuming and X server crashes. It has no problem when snd-pcm-oss is not in use(
released by arts). 0.9.6 has the same behavior. My sound card is on-board intel8x0.

I searched the mail archive and didn't find any similar cases. Could anybody look into
this problem?

Below is the decoded oops(on kernel 2.4.22 with alsa-0.9.7c loaded):
--------------------------------------------------------------
ksymoops 2.4.9 on i686 2.4.22.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.22/ (default)
     -m /boot/System.map-2.4.22 (specified)

Unable to handle kernel paging request at virtual address fffffffc
c0116d70
*pde = 00001063
Oops: 0000
CPU:    0
EIP:    0010:[<c0116d70>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010007
eax: 00000000   ebx: 00000000   ecx: 00000000   edx: 00000000
esi: d7ec2fb0   edi: 00000003   ebp: d5307ee4   esp: d5307ec8
ds: 0018   es: 0018   ss: 0018
Process X (pid: 851, stackpage=d5307000)
Stack: 00000000 00000000 00000001 00000282 d7fc7808 d7fc9eb4 d7fc9ea0 00000000
       d8bee512 d754a000 c021dc06 d7fc7800 c021dd3b d7fc7800 d7fc9ea0 00000003
       00000000 c021de83 d7fc9ea0 c142d2a0 c021dee5 c142d420 c0127e52 c142d2a0
Call Trace:    [<d8bee512>] [<c021dc06>] [<c021dd3b>] [<c021de83>] [<c021dee5>]
  [<c0127e52>] [<c0127f54>] [<c0113a43>] [<c011415c>] [<c0149b39>] [<c010740f>]
Code: 8b 4b fc 8b 01 85 c7 75 19 8b 02 89 d3 89 c2 0f 18 00 39 f3


>>EIP; c0116d70 <__wake_up+30/80>   <=====

>>esi; d7ec2fb0 <_end+17b53f8c/1880603c>
>>ebp; d5307ee4 <_end+14f98ec0/1880603c>
>>esp; d5307ec8 <_end+14f98ea4/1880603c>

Trace; d8bee512 <[snd-intel8x0]snd_intel8x0_resume+12/20>
Trace; c021dc06 <pci_pm_resume_device+26/30>
Trace; c021dd3b <pci_pm_resume_bus+2b/70>
Trace; c021de83 <pci_pm_resume+33/50>
Trace; c021dee5 <pci_pm_callback+45/50>
Trace; c0127e52 <pm_send+72/a0>
Trace; c0127f54 <pm_send_all+74/b0>
Trace; c0113a43 <suspend+e3/120>
Trace; c011415c <do_ioctl+10c/180>
Trace; c0149b39 <sys_ioctl+c9/250>
Trace; c010740f <system_call+33/38>

Code;  c0116d70 <__wake_up+30/80>
00000000 <_EIP>:
Code;  c0116d70 <__wake_up+30/80>   <=====
   0:   8b 4b fc                  mov    0xfffffffc(%ebx),%ecx   <=====
Code;  c0116d73 <__wake_up+33/80>
   3:   8b 01                     mov    (%ecx),%eax
Code;  c0116d75 <__wake_up+35/80>
   5:   85 c7                     test   %eax,%edi
Code;  c0116d77 <__wake_up+37/80>
   7:   75 19                     jne    22 <_EIP+0x22>
Code;  c0116d79 <__wake_up+39/80>
   9:   8b 02                     mov    (%edx),%eax
Code;  c0116d7b <__wake_up+3b/80>
   b:   89 d3                     mov    %edx,%ebx
Code;  c0116d7d <__wake_up+3d/80>
   d:   89 c2                     mov    %eax,%edx
Code;  c0116d7f <__wake_up+3f/80>
   f:   0f 18 00                  prefetchnta (%eax)
Code;  c0116d82 <__wake_up+42/80>
  12:   39 f3                     cmp    %esi,%ebx

--------------------------------------------------------------

This is the list of modules:
Module                  Size  Used by    Not tainted
snd-pcm-oss            39364   1
snd-mixer-oss          13720   1 [snd-pcm-oss]
keybdev                 2112   0 (unused)
mousedev                4404   1
hid                    15624   0 (unused)
input                   3328   0 [keybdev mousedev hid]
uhci                   25968   0 (unused)
usbcore                62624   1 [hid uhci]
snd-intel8x0           19460   2
snd-pcm                61536   0 [snd-pcm-oss snd-intel8x0]
snd-timer              14628   0 [snd-pcm]
snd-ac97-codec         42456   0 [snd-intel8x0]
snd-page-alloc          6484   0 [snd-intel8x0 snd-pcm]
snd-mpu401-uart         3456   0 [snd-intel8x0]
snd-rawmidi            13536   0 [snd-mpu401-uart]
snd-seq-device          4288   0 [snd-rawmidi]
snd                    29956   0 [snd-pcm-oss snd-mixer-oss snd-intel8x0 snd-pcm snd-timer
snd-ac97-codec snd-mpu401-uart snd-rawmidi snd-seq-device]
soundcore               3588   4 [snd]
3c59x                  27984   1
yenta_socket           10816   0
pcmcia_core            43104   0 [yenta_socket]
nls_cp936             119964   1 (autoclean)
nls_gb2312               448   1 (autoclean)



-------------------------------------------------------
This SF.net email sponsored by: Enterprise Linux Forum Conference & Expo
The Event For Linux Datacenter Solutions & Strategies in The Enterprise 
Linux in the Boardroom; in the Front Office; & in the Server Room 
http://www.enterpriselinuxforum.com

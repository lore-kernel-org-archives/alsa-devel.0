From: Mark Constable <markc@renta.net>
Subject: ALSA AMD OOPS
Date: Thu, 21 Mar 2002 14:09:59 +1000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E16nttv-0002RN-00@usw-sf-list1.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

I have not been able to run ALSA all this year using an Athlon 1200
and a Duron 1000. Every few weeks I try CVS again but I am still
getting the same result with both computers. As soon as I load any
ALSA driver either machine will lock solid within a few minutes. I
just had an uptime of 10 days using the default kernel emu10k1 driver.

Stock 2.4.18 kernel, ALSA from CVS, testing Debian distro...

This is the result of running alsamixer right after loading the
snd-emu10k1 driver. The same happens with an onboard trident device
on my Duron box (been like this for me since xmas)...

------
Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c01112a3
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01112a3>]    Not tainted
EFLAGS: 00010097
eax: f693693c   ebx: f6936938   ecx: 00000000   edx: 00000003
esi: f571cc08   edi: 00000001   ebp: f5909c84   esp: f5909c6c
ds: 0018   es: 0018   ss: 0018
Process alsamixer (pid: 333, stackpage=f5909000)
Stack: f6fec8a0 f571cc08 f6fec8e8 f693693c 00000082 00000003 f6936920 f8883d61
       f6936920 00000282 bffff5b0 f571cc08 f5909cfc f7718a00 f88847e1 f7718a00
       00000001 f571cbc8 00000000 f7718a00 00000028 00000002 00000000 00000000
Call Trace: [<f8883d61>] [<f88847e1>] [<c01395f7>] [<c0106d93>]

Code: 8b 01 85 45 fc 74 4d 31 c0 9c 5e fa c7 01 00 00 00 00 83 79
 Segmentation fault

--markc

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

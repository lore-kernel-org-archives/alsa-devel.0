From: Chris Rankin <cj.rankin@ntlworld.com>
Subject: xine CVS deadlock (2.4.18)?
Date: Fri, 15 Mar 2002 21:40:57 +0000 (GMT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200203152140.g2FLev2Y006891@twopit.underworld>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Received: from mta05-svc.ntlworld.com (mta05-svc.ntlworld.com [62.253.162.45])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id WAA23643
	for <alsa-devel@alsa-project.org>; Fri, 15 Mar 2002 22:41:16 +0100
Received: from wittsend.underworld ([80.0.71.165])
          by mta05-svc.ntlworld.com
          (InterMail vM.4.01.03.27 201-229-121-127-20010626) with ESMTP
          id <20020315214059.YTOH7206.mta05-svc.ntlworld.com@wittsend.underworld>
          for <alsa-devel@alsa-project.org>;
          Fri, 15 Mar 2002 21:40:59 +0000
Received: from twopit.underworld (root@twopit [192.168.0.2])
	by wittsend.underworld (8.12.1/8.12.1) with ESMTP id g2FLewdS001564
	for <alsa-devel@alsa-project.org>; Fri, 15 Mar 2002 21:40:58 GMT
Received: from twopit.underworld (chris@localhost [127.0.0.1])
	by twopit.underworld (8.12.2/8.12.2) with ESMTP id g2FLewiQ006892
	for <alsa-devel@alsa-project.org>; Fri, 15 Mar 2002 21:40:58 GMT
Received: (from chris@localhost)
	by twopit.underworld (8.12.2/8.12.1/Submit) id g2FLev2Y006891
	for alsa-devel@alsa-project.org; Fri, 15 Mar 2002 21:40:57 GMT
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

I have noticed this deadlock before and had attributed it to having
compiled the ALSA modules with gcc-3.0.4. However, it has just
happened again and I am no longer certain that gcc is responsible. I
was able to rescue the box by killing either the wine or the aplay
process - I'm not sure which because the only way I could view the
process list was by using "ls" on the /proc filesystem and spotting
the processes under my username. Here is the system trace,

Cheers,
Chris

ksymoops 2.4.4 on i686 2.4.18.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.18/ (default)
     -m /boot/System.map-2.4.18 (specified)

init          S C2411F2C  3888     1      0  4165       3       (NOTLB)
Using defaults from ksymoops -t elf32-i386 -a i386
Call Trace: [<c0113f5a>] [<c0113e80>] [<c014740e>] [<c01477b0>] [<c0106e9b>] 
keventd       R C2432660  5784     2      1             8       (L-TLB)
Call Trace: [<c0124005>] [<c01055c4>] 
ksoftirqd_CPU S C242E000  6028     3      0             4     1 (L-TLB)
Call Trace: [<c011ba2f>] [<c011bf4c>] [<c01055c4>] 
ksoftirqd_CPU S C242C000  6148     4      0             5     3 (L-TLB)
Call Trace: [<c011ba2f>] [<c011bf4c>] [<c01055c4>] 
kswapd        S F7BFE000  6356     5      0             6     4 (L-TLB)
Call Trace: [<c011a12a>] [<c012ff46>] [<c01055c4>] 
bdflush       S 00000286  6312     6      0             7     5 (L-TLB)
Call Trace: [<c011491a>] [<c013bf87>] [<c01055c4>] 
kupdated      S F7BD9FC8  5496     7      0                   6 (L-TLB)
Call Trace: [<c0113f5a>] [<c0113e80>] [<c013c02f>] [<c01055c4>] 
kjournald     S 00000286  5076     8      1            14     2 (L-TLB)
Call Trace: [<c011491a>] [<c016b449>] [<c016b2e0>] [<c01055c4>] 
devfsd        S F76A2000  5596    14      1            39     8 (NOTLB)
Call Trace: [<c01762a6>] [<c0130b88>] [<c0130ba6>] [<c0119c23>] [<c01375e7>] 
   [<c0106e9b>] 
khubd         S 00000286  4956    39      1           306    14 (L-TLB)
Call Trace: [<f88a26a8>] [<c011491a>] [<f88a0e87>] [<f88a26ac>] [<f88a26ac>] 
   [<f889a62f>] [<c01055c4>] 
syslogd       S 7FFFFFFF  2404   305      1           312   310 (NOTLB)
Call Trace: [<c0113ef7>] [<c014740e>] [<c01477b0>] [<c0106e9b>] 
klogd         R F778C000  4572   306      1           308    39 (NOTLB)
Call Trace: [<c0117044>] [<c0158955>] [<c01375e7>] [<c0106e9b>] 
rpc.portmap   S 7FFFFFFF  5092   308      1           310   306 (NOTLB)
Call Trace: [<c01c8aa3>] [<c0113ef7>] [<c01479fa>] [<c0147a2f>] [<c0147c2d>] 
   [<c01c9dec>] [<c0106e9b>] 
inetd         S 7FFFFFFF     0   310      1           305   308 (NOTLB)
Call Trace: [<c0113ef7>] [<c014740e>] [<c01477b0>] [<c0106e9b>] 
lpd           S 7FFFFFFF  4440   312      1           315   305 (NOTLB)
Call Trace: [<c014719c>] [<c0113ef7>] [<c014740e>] [<c01477b0>] [<c0106e9b>] 
rpc.mountd    S 7FFFFFFF   512   315      1           320   312 (NOTLB)
Call Trace: [<c01c8aa3>] [<c0113ef7>] [<c01479fa>] [<c0147a2f>] [<c0147c2d>] 
   [<c013706a>] [<c0106e9b>] 
nfsd          S 7FFFFFFF     0   320      1           321   315 (L-TLB)
Call Trace: [<c01144be>] [<c0113ef7>] [<f88fdda4>] [<f88e96de>] [<f8900294>] 
   [<f890fb20>] [<f890fb20>] [<c01055c4>] 
lockd         S 7FFFFFFF  2400   321      1   322     324   320 (L-TLB)
Call Trace: [<c0113ef7>] [<c0106f49>] [<f88e96de>] [<f88f4d09>] [<c01055c4>] 
rpciod        S 00000001     0   322    321                     (L-TLB)
Call Trace: [<f88ed412>] [<f88e62b4>] [<f88efd1c>] [<f88efd1c>] [<f88efd14>] 
   [<f88efd14>] [<c01055c4>] [<f88efd1c>] [<f88efd28>] 
rpc.statd     S 7FFFFFFF     0   324      1           326   321 (NOTLB)
Call Trace: [<c014719c>] [<c01e2432>] [<c0113ef7>] [<c014740e>] [<c01477b0>] 
   [<c0106e9b>] 
rpc.rquotad   S 7FFFFFFF     0   326      1           329   324 (NOTLB)
Call Trace: [<c01c8aa3>] [<c0113ef7>] [<c01479fa>] [<c0147a2f>] [<c0147c2d>] 
   [<c011a344>] [<c0106e9b>] 
cron          S F77AFF88     0   329      1           335   326 (NOTLB)
Call Trace: [<c0113f5a>] [<c0113e80>] [<c011fbac>] [<c0106e9b>] 
sendmail      S F779DF2C     0   335      1           350   329 (NOTLB)
Call Trace: [<c0113f5a>] [<c0113e80>] [<c014740e>] [<c01477b0>] [<c0106e9b>] 
acpid         S 7FFFFFFF     0   350      1   351     416   335 (NOTLB)
Call Trace: [<c0113ef7>] [<c014740e>] [<c01477b0>] [<c0106e9b>] 
acpid         S F7766000     0   351    350                     (NOTLB)
Call Trace: [<c0136c95>] [<f8918bc8>] [<f891ac78>] [<f891ac78>] [<c01375e7>] 
   [<c0106e9b>] 
ntpd          S 7FFFFFFF     0   416      1           417   350 (NOTLB)
Call Trace: [<c0113ef7>] [<c014740e>] [<c01477b0>] [<c0106e9b>] 
bash          S 00000000     0   417      1  4223     418   416 (NOTLB)
Call Trace: [<c011aab5>] [<c0106e9b>] 
xdm           S F7A4FFB0  4696   418      1   489     500   417 (NOTLB)
Call Trace: [<c0105fb3>] [<c0106e9b>] 
X             S F7681F2C     0   488    418           489       (NOTLB)
Call Trace: [<c014719c>] [<c0113f5a>] [<c0113e80>] [<c014740e>] [<c01477b0>] 
   [<c0106e9b>] 
xdm           S 00000000  2400   489    418   503           488 (NOTLB)
Call Trace: [<c011aab5>] [<c0106e9b>] 
xconsole      S 7FFFFFFF     0   500      1           511   418 (NOTLB)
Call Trace: [<c0113ef7>] [<c014740e>] [<c01477b0>] [<c0106e9b>] 
xsm           S 7FFFFFFF     0   503    489                     (NOTLB)
Call Trace: [<c0113ef7>] [<c014740e>] [<c01477b0>] [<c0106e9b>] 
twm           S 7FFFFFFF  2400   511      1           513   500 (NOTLB)
Call Trace: [<c0113ef7>] [<c014740e>] [<c01477b0>] [<c0106e9b>] 
smproxy       S 7FFFFFFF     0   513      1           553   511 (NOTLB)
Call Trace: [<c0113ef7>] [<c014740e>] [<c01477b0>] [<c0106e9b>] 
xclock        S F7677F2C  4956   518      1           589   555 (NOTLB)
Call Trace: [<c014719c>] [<c0113f5a>] [<c0113e80>] [<c014740e>] [<c01477b0>] 
   [<c0106e9b>] 
fetchmail     S F66A7F2C     0   553      1           556   513 (NOTLB)
Call Trace: [<c0113f5a>] [<c0113e80>] [<c014740e>] [<c01477b0>] [<c0106e9b>] 
xbiff         S F666DF2C  4956   555      1           518   556 (NOTLB)
Call Trace: [<c014719c>] [<c0113f5a>] [<c0113e80>] [<c014740e>] [<c01477b0>] 
   [<c0106e9b>] 
xmcd          S 7FFFFFFF     0   556      1           555   553 (NOTLB)
Call Trace: [<c0113ef7>] [<c014740e>] [<c01477b0>] [<c0106e9b>] 
xterm         S 7FFFFFFF  1376   589      1   594     597   518 (NOTLB)
Call Trace: [<c0113ef7>] [<c014740e>] [<c01477b0>] [<c0106e9b>] 
bash          S 00000000  1376   594    589  4155               (NOTLB)
Call Trace: [<c0130b88>] [<c011aab5>] [<c0106e9b>] 
xterm         S 7FFFFFFF     4   597      1   602     605   589 (NOTLB)
Call Trace: [<c0113ef7>] [<c014740e>] [<c01477b0>] [<c0106e9b>] 
bash          S 00000000  1376   602    597   640               (NOTLB)
Call Trace: [<c011aab5>] [<c0106e9b>] 
xterm         S 7FFFFFFF  2400   605      1   610     629   597 (NOTLB)
Call Trace: [<c0113ef7>] [<c014740e>] [<c01477b0>] [<c0106e9b>] 
bash          S 00000000  1376   610    605  4152               (NOTLB)
Call Trace: [<c011aab5>] [<c0106e9b>] 
setiwatcher   S F63C7FB0  4696   629      1  3893    3956   605 (NOTLB)
Call Trace: [<c0105fb3>] [<c0106e9b>] 
bash          S 00000000     0   640    602  4158               (NOTLB)
Call Trace: [<c011aab5>] [<c0106e9b>] 
setiathome    R current   2400  3879    629          3893       (NOTLB)
Call Trace: [<c0108736>] 
setiathome    R F685F140  2404  3893    629                3879 (NOTLB)
Call Trace: [<c010ba05>] [<c0106f8c>] 
xterm         S 7FFFFFFF     0  3956      1  3957    4053   629 (NOTLB)
Call Trace: [<c0113ef7>] [<c014740e>] [<c01477b0>] [<c0106e9b>] 
telnet        S 7FFFFFFF  2400  3957   3956                     (NOTLB)
Call Trace: [<c0113ef7>] [<c014740e>] [<c01477b0>] [<c0106e9b>] 
wine          S EB9A5C64  2400  4053      1          4142  3956 (L-TLB)
Call Trace: [<c0113f5a>] [<c0113e80>] [<f898426c>] [<f8985ddd>] [<c0207fc7>] 
   [<c0208035>] [<f88da6de>] [<c0166d5e>] [<c0168065>] [<c016742c>] [<c0160caf>] 
   [<c0160d16>] [<c016111e>] [<c016112f>] [<c0161219>] [<c01612d3>] [<c014c022>] 
   [<c015b819>] [<c01203cc>] [<c01204bd>] [<c0120945>] [<c0120a0a>] [<c0113e77>] 
   [<f89861bf>] [<fb3ae423>] [<c0140f45>] [<fb3af57b>] [<c0138505>] [<c013706a>] 
   [<c0119da8>] [<c011a5a9>] [<c011a71a>] [<c0106e9b>] 
aplay         D F7199780  2404  4142      1          4165  4053 (NOTLB)
Call Trace: [<c0105b24>] [<c0105cc0>] [<f89869e7>] [<f8985967>] [<f89859a7>] 
   [<f8985e16>] [<c01309ff>] [<c013078e>] [<c01261c9>] [<c0126222>] [<c0126554>] 
   [<f8992774>] [<c01309ff>] [<c0129d94>] [<c0129dc1>] [<c012624e>] [<c0126554>] 
   [<c01134b4>] [<c0113338>] [<c01293d2>] [<c012972a>] [<c011f604>] [<f8986158>] 
   [<c0146907>] [<c0106e9b>] 
xine          D F7199780     0  4152    610  4153               (NOTLB)
Call Trace: [<c0105b24>] [<c0105cc0>] [<f8986a2f>] [<c01134b4>] [<f8985314>] 
   [<c0138505>] [<c0127426>] [<c0127793>] [<c0127832>] [<c0106e9b>] 
xine          D EA92FF6C     0  4153   4152                     (NOTLB)
Call Trace: [<c0209afc>] [<c010b094>] [<c010b089>] [<c0106e9b>] 
ps            D EA941F14  2400  4155    594                     (NOTLB)
Call Trace: [<c02099cc>] [<c0158872>] [<c013078e>] [<c0155e9f>] [<c01375e7>] 
   [<c0106e9b>] 
ps            D EA8E9F14  5244  4157    640          4158       (NOTLB)
Call Trace: [<c02099cc>] [<c0141710>] [<c0158872>] [<c013078e>] [<c0155e9f>] 
   [<c01375e7>] [<c0106e9b>] 
grep          S EA8CA000  5244  4158    640                4157 (NOTLB)
Call Trace: [<c014096d>] [<c0140a44>] [<c01375e7>] [<c0106e9b>] 
xterm         S 7FFFFFFF  2392  4165      1  4170          4142 (NOTLB)
Call Trace: [<c0113ef7>] [<c014740e>] [<c01477b0>] [<c0106e9b>] 
bash          S 7FFFFFFF  5244  4170   4165                     (NOTLB)
Call Trace: [<c0113ef7>] [<c0195a6e>] [<c019157a>] [<c01375e7>] [<c0106e9b>] 
ps            D F3F13F14     0  4223    417                     (NOTLB)
Call Trace: [<c02099cc>] [<c0141710>] [<c0158872>] [<c013078e>] [<c0155e9f>] 
   [<c01375e7>] [<c0106e9b>] 
Warning (Oops_read): Code line not seen, dumping what data is available

Proc;  init
>>EIP; c2411f2c <_end+2110020/385570f4>   <=====
Trace; c0113f5a <schedule_timeout+7a/9c>
Trace; c0113e80 <process_timeout+0/60>
Trace; c014740e <do_select+1ca/204>
Trace; c01477b0 <sys_select+340/47c>
Trace; c0106e9b <system_call+33/38>
Proc;  keventd
>>EIP; c2432660 <_end+2130754/385570f4>   <=====
Trace; c0124005 <context_thread+115/1d0>
Trace; c01055c4 <kernel_thread+28/38>
Proc;  ksoftirqd_CPU
>>EIP; c242e000 <_end+212c0f4/385570f4>   <=====
Trace; c011ba2f <do_softirq+6f/cc>
Trace; c011bf4c <ksoftirqd+90/c4>
Trace; c01055c4 <kernel_thread+28/38>
Proc;  ksoftirqd_CPU
>>EIP; c242c000 <_end+212a0f4/385570f4>   <=====
Trace; c011ba2f <do_softirq+6f/cc>
Trace; c011bf4c <ksoftirqd+90/c4>
Trace; c01055c4 <kernel_thread+28/38>
Proc;  kswapd
>>EIP; f7bfe000 <_end+378fc0f4/385570f4>   <=====
Trace; c011a12a <exit_mm+e/7c>
Trace; c012ff46 <kswapd+82/b4>
Trace; c01055c4 <kernel_thread+28/38>
Proc;  bdflush
>>EIP; 00000286 Before first symbol   <=====
Trace; c011491a <interruptible_sleep_on+4a/6c>
Trace; c013bf87 <bdflush+cf/d4>
Trace; c01055c4 <kernel_thread+28/38>
Proc;  kupdated
>>EIP; f7bd9fc8 <_end+378d80bc/385570f4>   <=====
Trace; c0113f5a <schedule_timeout+7a/9c>
Trace; c0113e80 <process_timeout+0/60>
Trace; c013c02f <kupdate+a3/120>
Trace; c01055c4 <kernel_thread+28/38>
Proc;  kjournald
>>EIP; 00000286 Before first symbol   <=====
Trace; c011491a <interruptible_sleep_on+4a/6c>
Trace; c016b449 <kjournald+159/1cc>
Trace; c016b2e0 <commit_timeout+0/c>
Trace; c01055c4 <kernel_thread+28/38>
Proc;  devfsd
>>EIP; f76a2000 <_end+373a00f4/385570f4>   <=====
Trace; c01762a6 <devfsd_read+fe/3bc>
Trace; c0130b88 <__free_pages+1c/20>
Trace; c0130ba6 <free_pages+1a/1c>
Trace; c0119c23 <release_task+193/1b8>
Trace; c01375e7 <sys_read+8f/110>
Trace; c0106e9b <system_call+33/38>
Proc;  khubd
>>EIP; 00000286 Before first symbol   <=====
Trace; f88a26a8 <[usbcore]khubd_wait+0/c>
Trace; c011491a <interruptible_sleep_on+4a/6c>
Trace; f88a0e87 <[usbcore]usb_bandwidth_option+1db3/1db4>
Trace; f88a26ac <[usbcore]khubd_wait+4/c>
Trace; f88a26ac <[usbcore]khubd_wait+4/c>
Trace; f889a62f <[usbcore]usb_hub_thread+4b/94>
Trace; c01055c4 <kernel_thread+28/38>
Proc;  syslogd
>>EIP; 7fffffff Before first symbol   <=====
Trace; c0113ef7 <schedule_timeout+17/9c>
Trace; c014740e <do_select+1ca/204>
Trace; c01477b0 <sys_select+340/47c>
Trace; c0106e9b <system_call+33/38>
Proc;  klogd
>>EIP; f778c000 <_end+3748a0f4/385570f4>   <=====
Trace; c0117044 <do_syslog+c4/3a4>
Trace; c0158955 <kmsg_read+11/18>
Trace; c01375e7 <sys_read+8f/110>
Trace; c0106e9b <system_call+33/38>
Proc;  rpc.portmap
>>EIP; 7fffffff Before first symbol   <=====
Trace; c01c8aa3 <sock_poll+23/28>
Trace; c0113ef7 <schedule_timeout+17/9c>
Trace; c01479fa <do_poll+86/dc>
Trace; c0147a2f <do_poll+bb/dc>
Trace; c0147c2d <sys_poll+1dd/2e4>
Trace; c01c9dec <sys_socketcall+1e4/200>
Trace; c0106e9b <system_call+33/38>
Proc;  inetd
>>EIP; 7fffffff Before first symbol   <=====
Trace; c0113ef7 <schedule_timeout+17/9c>
Trace; c014740e <do_select+1ca/204>
Trace; c01477b0 <sys_select+340/47c>
Trace; c0106e9b <system_call+33/38>
Proc;  lpd
>>EIP; 7fffffff Before first symbol   <=====
Trace; c014719c <__pollwait+88/90>
Trace; c0113ef7 <schedule_timeout+17/9c>
Trace; c014740e <do_select+1ca/204>
Trace; c01477b0 <sys_select+340/47c>
Trace; c0106e9b <system_call+33/38>
Proc;  rpc.mountd
>>EIP; 7fffffff Before first symbol   <=====
Trace; c01c8aa3 <sock_poll+23/28>
Trace; c0113ef7 <schedule_timeout+17/9c>
Trace; c01479fa <do_poll+86/dc>
Trace; c0147a2f <do_poll+bb/dc>
Trace; c0147c2d <sys_poll+1dd/2e4>
Trace; c013706a <filp_close+aa/b4>
Trace; c0106e9b <system_call+33/38>
Proc;  nfsd
>>EIP; 7fffffff Before first symbol   <=====
Trace; c01144be <schedule+4b6/580>
Trace; c0113ef7 <schedule_timeout+17/9c>
Trace; f88fdda4 <[lockd]lockd_start+8/14>
Trace; f88e96de <[sunrpc]svc_recv+1d6/4b8>
Trace; f8900294 <[nfsd]nfsd+10c/348>
Trace; f890fb20 <[nfsd]nfsd_list+0/0>
Trace; f890fb20 <[nfsd]nfsd_list+0/0>
Trace; c01055c4 <kernel_thread+28/38>
Proc;  lockd
>>EIP; 7fffffff Before first symbol   <=====
Trace; c0113ef7 <schedule_timeout+17/9c>
Trace; c0106f49 <reschedule+5/c>
Trace; f88e96de <[sunrpc]svc_recv+1d6/4b8>
Trace; f88f4d09 <[lockd]lockd+175/2a8>
Trace; c01055c4 <kernel_thread+28/38>
Proc;  rpciod
>>EIP; 00000001 Before first symbol   <=====
Trace; f88ed412 <[sunrpc].rodata.start+1fb2/3c7f>
Trace; f88e62b4 <[sunrpc]rpciod+1c4/288>
Trace; f88efd1c <[sunrpc]rpciod_killer+0/c>
Trace; f88efd1c <[sunrpc]rpciod_killer+0/c>
Trace; f88efd14 <[sunrpc]rpciod_idle+4/c>
Trace; f88efd14 <[sunrpc]rpciod_idle+4/c>
Trace; c01055c4 <kernel_thread+28/38>
Trace; f88efd1c <[sunrpc]rpciod_killer+0/c>
Trace; f88efd28 <[sunrpc]rpciod_sema+0/14>
Proc;  rpc.statd
>>EIP; 7fffffff Before first symbol   <=====
Trace; c014719c <__pollwait+88/90>
Trace; c01e2432 <tcp_poll+2e/158>
Trace; c0113ef7 <schedule_timeout+17/9c>
Trace; c014740e <do_select+1ca/204>
Trace; c01477b0 <sys_select+340/47c>
Trace; c0106e9b <system_call+33/38>
Proc;  rpc.rquotad
>>EIP; 7fffffff Before first symbol   <=====
Trace; c01c8aa3 <sock_poll+23/28>
Trace; c0113ef7 <schedule_timeout+17/9c>
Trace; c01479fa <do_poll+86/dc>
Trace; c0147a2f <do_poll+bb/dc>
Trace; c0147c2d <sys_poll+1dd/2e4>
Trace; c011a344 <exit_notify+1ac/2e0>
Trace; c0106e9b <system_call+33/38>
Proc;  cron
>>EIP; f77aff88 <_end+374ae07c/385570f4>   <=====
Trace; c0113f5a <schedule_timeout+7a/9c>
Trace; c0113e80 <process_timeout+0/60>
Trace; c011fbac <sys_nanosleep+110/1d5>
Trace; c0106e9b <system_call+33/38>
Proc;  sendmail
>>EIP; f779df2c <_end+3749c020/385570f4>   <=====
Trace; c0113f5a <schedule_timeout+7a/9c>
Trace; c0113e80 <process_timeout+0/60>
Trace; c014740e <do_select+1ca/204>
Trace; c01477b0 <sys_select+340/47c>
Trace; c0106e9b <system_call+33/38>
Proc;  acpid
>>EIP; 7fffffff Before first symbol   <=====
Trace; c0113ef7 <schedule_timeout+17/9c>
Trace; c014740e <do_select+1ca/204>
Trace; c01477b0 <sys_select+340/47c>
Trace; c0106e9b <system_call+33/38>
Proc;  acpid
>>EIP; f7766000 <_end+374640f4/385570f4>   <=====
Trace; c0136c95 <dentry_open+e1/18c>
Trace; f8918bc8 <[ospm_busmgr]bm_osl_read_event+b0/198>
Trace; f891ac78 <[ospm_busmgr]bm_event_wait_queue+4/c>
Trace; f891ac78 <[ospm_busmgr]bm_event_wait_queue+4/c>
Trace; c01375e7 <sys_read+8f/110>
Trace; c0106e9b <system_call+33/38>
Proc;  ntpd
>>EIP; 7fffffff Before first symbol   <=====
Trace; c0113ef7 <schedule_timeout+17/9c>
Trace; c014740e <do_select+1ca/204>
Trace; c01477b0 <sys_select+340/47c>
Trace; c0106e9b <system_call+33/38>
Proc;  bash
>>EIP; 00000000 Before first symbol
Trace; c011aab5 <sys_wait4+399/3d0>
Trace; c0106e9b <system_call+33/38>
Proc;  xdm
>>EIP; f7a4ffb0 <_end+3774e0a4/385570f4>   <=====
Trace; c0105fb3 <sys_rt_sigsuspend+fb/118>
Trace; c0106e9b <system_call+33/38>
Proc;  X
>>EIP; f7681f2c <_end+37380020/385570f4>   <=====
Trace; c014719c <__pollwait+88/90>
Trace; c0113f5a <schedule_timeout+7a/9c>
Trace; c0113e80 <process_timeout+0/60>
Trace; c014740e <do_select+1ca/204>
Trace; c01477b0 <sys_select+340/47c>
Trace; c0106e9b <system_call+33/38>
Proc;  xdm
>>EIP; 00000000 Before first symbol
Trace; c011aab5 <sys_wait4+399/3d0>
Trace; c0106e9b <system_call+33/38>
Proc;  xconsole
>>EIP; 7fffffff Before first symbol   <=====
Trace; c0113ef7 <schedule_timeout+17/9c>
Trace; c014740e <do_select+1ca/204>
Trace; c01477b0 <sys_select+340/47c>
Trace; c0106e9b <system_call+33/38>
Proc;  xsm
>>EIP; 7fffffff Before first symbol   <=====
Trace; c0113ef7 <schedule_timeout+17/9c>
Trace; c014740e <do_select+1ca/204>
Trace; c01477b0 <sys_select+340/47c>
Trace; c0106e9b <system_call+33/38>
Proc;  twm
>>EIP; 7fffffff Before first symbol   <=====
Trace; c0113ef7 <schedule_timeout+17/9c>
Trace; c014740e <do_select+1ca/204>
Trace; c01477b0 <sys_select+340/47c>
Trace; c0106e9b <system_call+33/38>
Proc;  smproxy
>>EIP; 7fffffff Before first symbol   <=====
Trace; c0113ef7 <schedule_timeout+17/9c>
Trace; c014740e <do_select+1ca/204>
Trace; c01477b0 <sys_select+340/47c>
Trace; c0106e9b <system_call+33/38>
Proc;  xclock
>>EIP; f7677f2c <_end+37376020/385570f4>   <=====
Trace; c014719c <__pollwait+88/90>
Trace; c0113f5a <schedule_timeout+7a/9c>
Trace; c0113e80 <process_timeout+0/60>
Trace; c014740e <do_select+1ca/204>
Trace; c01477b0 <sys_select+340/47c>
Trace; c0106e9b <system_call+33/38>
Proc;  fetchmail
>>EIP; f66a7f2c <_end+363a6020/385570f4>   <=====
Trace; c0113f5a <schedule_timeout+7a/9c>
Trace; c0113e80 <process_timeout+0/60>
Trace; c014740e <do_select+1ca/204>
Trace; c01477b0 <sys_select+340/47c>
Trace; c0106e9b <system_call+33/38>
Proc;  xbiff
>>EIP; f666df2c <_end+3636c020/385570f4>   <=====
Trace; c014719c <__pollwait+88/90>
Trace; c0113f5a <schedule_timeout+7a/9c>
Trace; c0113e80 <process_timeout+0/60>
Trace; c014740e <do_select+1ca/204>
Trace; c01477b0 <sys_select+340/47c>
Trace; c0106e9b <system_call+33/38>
Proc;  xmcd
>>EIP; 7fffffff Before first symbol   <=====
Trace; c0113ef7 <schedule_timeout+17/9c>
Trace; c014740e <do_select+1ca/204>
Trace; c01477b0 <sys_select+340/47c>
Trace; c0106e9b <system_call+33/38>
Proc;  xterm
>>EIP; 7fffffff Before first symbol   <=====
Trace; c0113ef7 <schedule_timeout+17/9c>
Trace; c014740e <do_select+1ca/204>
Trace; c01477b0 <sys_select+340/47c>
Trace; c0106e9b <system_call+33/38>
Proc;  bash
>>EIP; 00000000 Before first symbol
Trace; c0130b88 <__free_pages+1c/20>
Trace; c011aab5 <sys_wait4+399/3d0>
Trace; c0106e9b <system_call+33/38>
Proc;  xterm
>>EIP; 7fffffff Before first symbol   <=====
Trace; c0113ef7 <schedule_timeout+17/9c>
Trace; c014740e <do_select+1ca/204>
Trace; c01477b0 <sys_select+340/47c>
Trace; c0106e9b <system_call+33/38>
Proc;  bash
>>EIP; 00000000 Before first symbol
Trace; c011aab5 <sys_wait4+399/3d0>
Trace; c0106e9b <system_call+33/38>
Proc;  xterm
>>EIP; 7fffffff Before first symbol   <=====
Trace; c0113ef7 <schedule_timeout+17/9c>
Trace; c014740e <do_select+1ca/204>
Trace; c01477b0 <sys_select+340/47c>
Trace; c0106e9b <system_call+33/38>
Proc;  bash
>>EIP; 00000000 Before first symbol
Trace; c011aab5 <sys_wait4+399/3d0>
Trace; c0106e9b <system_call+33/38>
Proc;  setiwatcher
>>EIP; f63c7fb0 <_end+360c60a4/385570f4>   <=====
Trace; c0105fb3 <sys_rt_sigsuspend+fb/118>
Trace; c0106e9b <system_call+33/38>
Proc;  bash
>>EIP; 00000000 Before first symbol
Trace; c011aab5 <sys_wait4+399/3d0>
Trace; c0106e9b <system_call+33/38>
Proc;  setiathome
>>EIP; 0000000c Before first symbol   <=====
Trace; c0108736 <do_IRQ+a6/ec>
Proc;  setiathome
>>EIP; f685f140 <_end+3655d234/385570f4>   <=====
Trace; c010ba05 <sys_mmap2+65/94>
Trace; c0106f8c <error_code+34/3c>
Proc;  xterm
>>EIP; 7fffffff Before first symbol   <=====
Trace; c0113ef7 <schedule_timeout+17/9c>
Trace; c014740e <do_select+1ca/204>
Trace; c01477b0 <sys_select+340/47c>
Trace; c0106e9b <system_call+33/38>
Proc;  telnet
>>EIP; 7fffffff Before first symbol   <=====
Trace; c0113ef7 <schedule_timeout+17/9c>
Trace; c014740e <do_select+1ca/204>
Trace; c01477b0 <sys_select+340/47c>
Trace; c0106e9b <system_call+33/38>
Proc;  wine
>>EIP; eb9a5c64 <_end+2b6a3d58/385570f4>   <=====
Trace; c0113f5a <schedule_timeout+7a/9c>
Trace; c0113e80 <process_timeout+0/60>
Trace; f898426c <[snd-pcm]snd_pcm_playback_drain+224/30c>
Trace; f8985ddd <[snd-pcm]snd_pcm_playback_ioctl1+375/3bc>
Trace; c0207fc7 <__delay+13/28>
Trace; c0208035 <__const_udelay+29/34>
Trace; f88da6de <[eepro100]speedo_start_xmit+166/1f0>
Trace; c0166d5e <do_get_write_access+5f6/61c>
Trace; c0168065 <__journal_file_buffer+e5/21c>
Trace; c016742c <journal_dirty_metadata+1a4/1cc>
Trace; c0160caf <ext3_do_update_inode+2fb/398>
Trace; c0160d16 <ext3_do_update_inode+362/398>
Trace; c016111e <ext3_mark_iloc_dirty+22/48>
Trace; c016112f <ext3_mark_iloc_dirty+33/48>
Trace; c0161219 <ext3_mark_inode_dirty+29/34>
Trace; c01612d3 <ext3_dirty_inode+af/118>
Trace; c014c022 <__mark_inode_dirty+2e/98>
Trace; c015b819 <ext3_free_blocks+5a1/5ac>
Trace; c01203cc <send_signal+2c/100>
Trace; c01204bd <deliver_signal+1d/80>
Trace; c0120945 <wake_up_parent+1d/30>
Trace; c0120a0a <do_notify_parent+b2/bc>
Trace; c0113e77 <reschedule_idle+25f/268>
Trace; f89861bf <[snd-pcm]snd_pcm_kernel_playback_ioctl+27/30>
Trace; fb3ae423 <[snd-pcm-oss]snd_pcm_oss_sync+13b/1a4>
Trace; c0140f45 <pipe_release+75/88>
Trace; fb3af57b <[snd-pcm-oss]snd_pcm_oss_release+1b/7c>
Trace; c0138505 <fput+4d/e8>
Trace; c013706a <filp_close+aa/b4>
Trace; c0119da8 <put_files_struct+58/c0>
Trace; c011a5a9 <do_exit+131/27c>
Trace; c011a71a <sys_exit+e/10>
Trace; c0106e9b <system_call+33/38>
Proc;  aplay
>>EIP; f7199780 <_end+36e97874/385570f4>   <=====
Trace; c0105b24 <__down+6c/c8>
Trace; c0105cc0 <__down_failed+8/c>
Trace; f89869e7 <[snd-pcm]_text_lock_KBUILD_BASENAME+119/362>
Trace; f8985967 <[snd-pcm]snd_pcm_common_ioctl1+15f/260>
Trace; f89859a7 <[snd-pcm]snd_pcm_common_ioctl1+19f/260>
Trace; f8985e16 <[snd-pcm]snd_pcm_playback_ioctl1+3ae/3bc>
Trace; c01309ff <__alloc_pages+33/164>
Trace; c013078e <_alloc_pages+16/18>
Trace; c01261c9 <do_anonymous_page+15d/180>
Trace; c0126222 <do_no_page+36/30c>
Trace; c0126554 <handle_mm_fault+5c/bc>
Trace; f8992774 <[snd-emu10k1]snd_emu10k1_pcm_mixer_notify1+2c/30>
Trace; c01309ff <__alloc_pages+33/164>
Trace; c0129d94 <filemap_nopage+bc/1f8>
Trace; c0129dc1 <filemap_nopage+e9/1f8>
Trace; c012624e <do_no_page+62/30c>
Trace; c0126554 <handle_mm_fault+5c/bc>
Trace; c01134b4 <do_page_fault+17c/4ad>
Trace; c0113338 <do_page_fault+0/4ad>
Trace; c01293d2 <do_generic_file_read+456/464>
Trace; c012972a <generic_file_read+7e/12c>
Trace; c011f604 <update_process_times+20/94>
Trace; f8986158 <[snd-pcm]snd_pcm_playback_ioctl+20/30>
Trace; c0146907 <sys_ioctl+1bb/208>
Trace; c0106e9b <system_call+33/38>
Proc;  xine
>>EIP; f7199780 <_end+36e97874/385570f4>   <=====
Trace; c0105b24 <__down+6c/c8>
Trace; c0105cc0 <__down_failed+8/c>
Trace; f8986a2f <[snd-pcm]_text_lock_KBUILD_BASENAME+161/362>
Trace; c01134b4 <do_page_fault+17c/4ad>
Trace; f8985314 <[snd-pcm]snd_pcm_release+24/b4>
Trace; c0138505 <fput+4d/e8>
Trace; c0127426 <unmap_fixup+56/158>
Trace; c0127793 <do_munmap+1e7/250>
Trace; c0127832 <sys_munmap+36/54>
Trace; c0106e9b <system_call+33/38>
Proc;  xine
>>EIP; ea92ff6c <_end+2a62e060/385570f4>   <=====
Trace; c0209afc <rwsem_down_write_failed+108/130>
Trace; c010b094 <_text_lock_ldt+6/22>
Trace; c010b089 <sys_modify_ldt+59/5e>
Trace; c0106e9b <system_call+33/38>
Proc;  ps
>>EIP; ea941f14 <_end+2a640008/385570f4>   <=====
Trace; c02099cc <rwsem_down_read_failed+10c/134>
Trace; c0158872 <_text_lock_array+63/111>
Trace; c013078e <_alloc_pages+16/18>
Trace; c0155e9f <proc_info_read+53/114>
Trace; c01375e7 <sys_read+8f/110>
Trace; c0106e9b <system_call+33/38>
Proc;  ps
>>EIP; ea8e9f14 <_end+2a5e8008/385570f4>   <=====
Trace; c02099cc <rwsem_down_read_failed+10c/134>
Trace; c0141710 <vfs_permission+74/f0>
Trace; c0158872 <_text_lock_array+63/111>
Trace; c013078e <_alloc_pages+16/18>
Trace; c0155e9f <proc_info_read+53/114>
Trace; c01375e7 <sys_read+8f/110>
Trace; c0106e9b <system_call+33/38>
Proc;  grep
>>EIP; ea8ca000 <_end+2a5c80f4/385570f4>   <=====
Trace; c014096d <pipe_wait+7d/a4>
Trace; c0140a44 <pipe_read+b0/1f8>
Trace; c01375e7 <sys_read+8f/110>
Trace; c0106e9b <system_call+33/38>
Proc;  xterm
>>EIP; 7fffffff Before first symbol   <=====
Trace; c0113ef7 <schedule_timeout+17/9c>
Trace; c014740e <do_select+1ca/204>
Trace; c01477b0 <sys_select+340/47c>
Trace; c0106e9b <system_call+33/38>
Proc;  bash
>>EIP; 7fffffff Before first symbol   <=====
Trace; c0113ef7 <schedule_timeout+17/9c>
Trace; c0195a6e <read_chan+3ae/754>
Trace; c019157a <tty_read+d6/128>
Trace; c01375e7 <sys_read+8f/110>
Trace; c0106e9b <system_call+33/38>
Proc;  ps
>>EIP; f3f13f14 <_end+33c12008/385570f4>   <=====
Trace; c02099cc <rwsem_down_read_failed+10c/134>
Trace; c0141710 <vfs_permission+74/f0>
Trace; c0158872 <_text_lock_array+63/111>
Trace; c013078e <_alloc_pages+16/18>
Trace; c0155e9f <proc_info_read+53/114>
Trace; c01375e7 <sys_read+8f/110>
Trace; c0106e9b <system_call+33/38>


1 warning issued.  Results may not be reliable.

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

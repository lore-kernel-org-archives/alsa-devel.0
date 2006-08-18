From: rob arnold <rob@loci.net>
Subject: hda intel D945GNT, a few stability/latency issues
Date: Thu, 17 Aug 2006 20:19:34 -0700
Message-ID: <3C2001A3-6696-4F74-885D-3F07E1881B3F@loci.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi, I'm running into some stability and latency problems with the hda  
driver, and after trying different releases, including pulling latest  
from hg, still am not getting anywhere on a few remaining issues.   
I'd like to report them and see if there is anything I can do to help  
resolve them.

1) audio channels can "go away" over time.  By this, I mean that I've  
seen line in and/or line out go away, though mixer settings haven't  
changed.  There are no application errors displayed, nor errors  
displayed in /var/log/messages (though possible I don't have logging  
turned up enough).  Once it occurs, which can happen anytime after  
boot to days or weeks later (we have high uptime systems), the channel 
(s) stay dead until the machine is rebooted, or until /etc/init.d/ 
alsasound restart is performed

2) Audio channels can develop a "crackle".  It's typically a single  
left or right channel of line out.  The crackle doesn't necessarily  
go away with an alsasound restart, but will with a reboot.  I've seen  
the crackle happen immediately after a reboot.  I am not positive,  
but think it also might develop over time, since I've walked in and  
heard it one day, where I didn't hear it previously, without an  
intervening reboot to my knowledge.  The crackle is only audible when  
there is a sound playing (via any app), it's not continuous.

3)  capture mute seems to do something odd to the driver and apps  
connected to it.  I need to dig into our app code and get more  
information, but from what I can tell, my read on the dsp (this would  
be through oss emulation, though the above problems are with direct  
alsa apps) seems to block for a lot longer than expected or  
something.  I understand this description might be useless, and will  
try to get more information.

4) (this occurs only on one FC5 x86 build, whereas the above occur on  
both FC5 x86 and x86_64 builds)  my app, which is playing audio  
sync'd with video, both through SDL (SDL set to use alsa directly),  
slowly looses audio sync.  The audio playback drift out longer and  
longer.  We're not talking seconds or anything, but probably 100's of  
milliseconds over an hour or three.  Oddly, it doesn't do this on the  
exact same hardware, exact same app software and libraries, on an  
almost identical FC5 x86_64 build (vs. 32bit x86 build).  The kernels  
are different, and at this point the alsa versions are as well,  
though I've gone through several alsa versions with the same results


System details:
Intel D945GNT motherboards

Fedora Core 5 distributions, both x86_64 (running 2.6.16-1.2096_FC5  
standard fedora kernel, alsa 1.0.11) and x86 (running  
2.6.17-1.2157_FC5smp standard fedora kernel, alsa various, from  
1.0.11 rc2 - 1.0.12rc2, rc3(drivers))

the lspci -v looks a little different between the x86_64 and the x86  
loads:
x86_64:

00:1b.0 Audio device: Intel Corporation 82801G (ICH7 Family) High  
Definition Audio Controller (rev 01)
         Subsystem: Intel Corporation Unknown device 0202
         Flags: bus master, fast devsel, latency 0, IRQ 22
         Memory at 52200000 (64-bit, non-prefetchable) [size=16K]
         Capabilities: [50] Power Management version 2
         Capabilities: [60] Message Signalled Interrupts: 64bit+  
Queue=0/0 Enable-
         Capabilities: [70] Express Unknown type IRQ 0
         Capabilities: [100] Virtual Channel
         Capabilities: [130] Unknown (5)


x86:

00:1b.0 Audio device: Intel Corporation 82801G (ICH7 Family) High  
Definition Audio Controller (rev 01)
         Subsystem: Intel Corporation Unknown device 0202
         Flags: bus master, fast devsel, latency 0, IRQ 66
         Memory at 52200000 (64-bit, non-prefetchable) [size=16K]
         Capabilities: [50] Power Management version 2
         Capabilities: [60] Message Signalled Interrupts: 64bit+  
Queue=0/0 Enable-
         Capabilities: [70] Express Unknown type IRQ 0


It seems like I should be providing more information, but I'm not  
sure where to go next.  I'd appreciate any suggestions, and I'm  
willing to work at whatever level needed to get these issues  
resolved, as it's killing my ability to rely on this particular  
platform for long term audio use.  I have not dug into the hda code  
itself, nor am I sure the problem necessarily lies entirely there,  
but I'll patch and recompile as needed if there are possible fixes to  
test.

Any ideas?   Thanks all.


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642

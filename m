From: "Andrew Nelless" <andrew@nelless.net>
Subject: IRQ issue with the hda-intel module,
	2.6.19 and my mobo?
Date: Fri, 27 Oct 2006 19:21:05 +0100 (BST)
Message-ID: <34389.86.7.220.119.1161973265.squirrel@wmbeta.mxes.net>
Reply-To: Andrew Nelless <andrew@nelless.net>
Mime-Version: 1.0
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

Hi,

I've been testing the 2.6.19 RC kernels out (I always test early new mainline kernels early)
and have been getting the following MCE error consistantly when I load the snd_hda_intel
module

"Hardware Error
CPU 0 : Machine Check Exception
TSC 2df07369b0 4 Bank 4 b20000 00000000070f0f
This is not a software problem"

This has occured since 2.6.19-rc1 (actually, on 2.6.18-mm2 as well but I didn't think anything
of it at the time, it being an -mm patch). Despite the error claiming this is a hardware fault
*I think* using a little detective work i've narrowed the problem down to the way IRQ's are
munged on my motherboard.

I've been using the HDA Intel driver with the sound onboard the Asus A8NVM CSM motherboard
since 2.6.15 (ALSA 1.0.10? Sorry, I tend to use whatever ALSA version is bundled with the
kernel release).

I started playing around with modprobe and loading all the sound modules manually and when I
load the modules in a certain order I can *sometimes* get the ominous looking message
"Disabling IRQ #22" *instead of the MCE error*.. so I decided to look at the IRQ's.

Output of my /proc/interrupts on 2.6.18:
  http://andrew.nelless.net/2.6.19-hda-intel-problem/2.6.18-proc-interrupts.txt

I notice that HDA Intel and libata are sharing an IRQ (atleast I assume this is what this
shows?) so I decided to compare how IRQ's are being handled differently between 2.6.18 and
2.6.19-rc3 by looking at lines from dmesg containing 'irq' and running it through diff...

Diff:
  http://andrew.nelless.net/2.6.19-hda-intel-problem/dmesg-irqs-diff.txt
2.6.18:
  http://andrew.nelless.net/2.6.19-hda-intel-problem/2.6.18-dmesg-irqs.txt
2.6.19-rc3:
  http://andrew.nelless.net/2.6.19-hda-intel-problem/2.6.19-rc3-dmesg-irqs.txt

I've tried passing pci=routeirq to the kernel, which had no effect, and some of my hardware
doesn't work right with ACPI disabled so I haven't even tried that.

The kernel .config files i'm using can be found at the same path,
http://andrew.nelless.net/2.6.19-hda-intel-problem/

My amateur (and humble :-P) guess is that libata and hda-intel have started screwing with each
other on my motherboard because 2.6.19 is now using ACPI to route some IRQ's whereas before it
wasn't?

Is this the case? If so, where should I file a bug report? and if not, what else can I try to
track this down?

Thanks for reading,
 Andrew




-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642

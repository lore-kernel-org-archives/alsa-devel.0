From: "Thomas Charbonnel" <thomas@undata.org>
Subject: hdsp cardbus coldboot bug workaround
Date: Sat, 2 Aug 2003 14:06:45 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <32812.80.11.13.118.1059826005.squirrel@www.undata.org>
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
List-Id: alsa-devel@alsa-project.org

Hi,

It has already been reported on this list that the hdsp cardbus card is
not detected correctly at boot time after a cold boot. When this happens
here's what dmesg says about it:
cs: cb_alloc(bus 3): vendor 0xffff, device 0xffff
PCI: device 03:00.0 has unknown header type 7f, ignoring.

This problem is reproducible every time for if those conditions are met:
* non acpi-enabled kernel
* boot on AC power

A workaround seems thus to build acpi into the kernel. My guess is that
when acpi is not enabled, the card is asked its id parameters before its
full initialization, or full initialization of the cardbus-to-pci bridge.
Things working on battery power could be explained by the fact that in
this case the CPU frequency (at least on my laptop) is scaled down by the
bios at boot time, leading to a slower boot process.

Thomas





-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01

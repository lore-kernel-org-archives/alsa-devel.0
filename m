From: Jesse Chappell <jesse@essej.net>
Subject: Re: hdsp cardbus coldboot bug workaround
Date: Sun, 03 Aug 2003 20:52:01 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <90bc1390e02860d700dc0b3ffab2eb74@essej.net>
References: <32812.80.11.13.118.1059826005.squirrel@www.undata.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <32812.80.11.13.118.1059826005.squirrel@www.undata.org>
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

Thomas Charbonnel wrote on Sat, 02-Aug-2003:

 > It has already been reported on this list that the hdsp cardbus card is
 > not detected correctly at boot time after a cold boot. When this happens
 > here's what dmesg says about it:
 > cs: cb_alloc(bus 3): vendor 0xffff, device 0xffff
 > PCI: device 03:00.0 has unknown header type 7f, ignoring.
 > 
 > This problem is reproducible every time for if those conditions are met:
 > * non acpi-enabled kernel
 > * boot on AC power

I have never had the cold boot problem and I use the conditions
you mention above.  My hardware is an IBM ThinkPad A31, with a
rev 0xb HDSP cardbus, acpi *not* enabled (not compiled in and
a noacpi kernel cmdline), with AC power.

Hmmm, your solution might help people that do have the problem,
though.

jlc


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01

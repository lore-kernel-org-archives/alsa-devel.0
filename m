From: Brice Goglin <Brice.Goglin@ens-lyon.fr>
Subject: support for PCI_DEVICE_ID_INTEL_ICH6_15
Date: Sat, 20 Nov 2004 18:27:59 +0100
Message-ID: <419F7E9F.6040807@ens-lyon.fr>
Reply-To: Brice.Goglin@ens-lyon.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

We have a machine here whose lspci shows this soundcard :

0000:00:1b.0 0403: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) High 
Definition Audio Controller (rev 03)
                 Subsystem: Hewlett-Packard Company: Unknown device 2a09
                 Flags: bus master, fast devsel, latency 0, IRQ 169
                 Memory at d7dfc000 (64-bit, non-prefetchable) [size=16K]
                 Capabilities: [50] Power Management version 2
                 Capabilities: [60] Message Signalled Interrupts: 64bit+ 
Queue=0/0 Enable-
                 Capabilities: [70] #10 [0091]

lspci -n says that the PCI id is "8086:2668".
include/linux/pci_ids.h says this is PCI_DEVICE_ID_INTEL_ICH6_15.
The intel8x0.c alsa driver code seems to handle several ICH chips,
but we didn't get this one to work.

Anyway, I didn't find this PCI id in intel8x0.c. I just found 
PCI_DEVICE_ID_INTEL_ICH6_3 (whose id is 266e instead of 2668 here).

Is there any way to get this soundcard to work ?

Best Regards,
--
Brice Goglin


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8

From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: support for PCI_DEVICE_ID_INTEL_ICH6_15
Date: Sat, 20 Nov 2004 12:48:21 -0500
Message-ID: <1100972902.6879.24.camel@krustophenia.net>
References: <419F7E9F.6040807@ens-lyon.fr>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <419F7E9F.6040807@ens-lyon.fr>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Brice.Goglin@ens-lyon.org
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sat, 2004-11-20 at 18:27 +0100, Brice Goglin wrote:
> lspci -n says that the PCI id is "8086:2668".
> include/linux/pci_ids.h says this is PCI_DEVICE_ID_INTEL_ICH6_15.
> The intel8x0.c alsa driver code seems to handle several ICH chips,
> but we didn't get this one to work.
> 
> Anyway, I didn't find this PCI id in intel8x0.c. I just found 
> PCI_DEVICE_ID_INTEL_ICH6_3 (whose id is 266e instead of 2668 here).

Well that could be a typo.  Did you try just adding this PCI id to
intel8x0.c?

Otherwise this is probably a new device.  But Intel is Linux friendly so
even if your card is not supported it can be.

Lee



-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8

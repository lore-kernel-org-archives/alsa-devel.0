From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: support for PCI_DEVICE_ID_INTEL_ICH6_15
Date: Sat, 20 Nov 2004 13:31:48 -0500
Message-ID: <1100975509.6879.31.camel@krustophenia.net>
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
> Hi,
> 
> We have a machine here whose lspci shows this soundcard :
> 
> 0000:00:1b.0 0403: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) High 
> Definition Audio Controller (rev 03)

Sorry I missed the 'HD Audio' part.  I think you want the 'azx' driver:

http://sourceforge.net/mailarchive/message.php?msg_id=8912810

AFAIK Intel posted this driver and it was committed to CVS but we have
no user feedback yet.  So it should be considered experimental, though
it should work.  It would be good to know how it works...

If this is the case "ICH 6 Family" is misleading, as this needs a
completely different driver.

Lee




-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8

From: Lee Revell <rlrevell@joe-job.com>
Subject: pci_disable_device warning
Date: Wed, 17 Nov 2004 13:40:48 -0500
Message-ID: <1100716849.6930.31.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain
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
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

I get this warning when removing ALSA modules.  I believe the warning is
going away, so maybe we should address the issue now.  Is this something
that could be done by the ALSA middle layer? 

Nov 16 23:32:09 krustophenia kernel: EMU10K1_Audigy 0000:00:14.0: Device
was removed without properly calling pci_disable_device(). This may need
fixing.

I tried adding a call to pci_disable_device and the warning persisted,
maybe I did not add it in the right place.

Lee



-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8

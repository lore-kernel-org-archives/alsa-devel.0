From: "Luuk van Dijk" <lvd@mndmttr.nl>
Subject: full/half duplex support
Date: Mon, 15 Nov 2004 17:03:21 +0100
Message-ID: <courier.4198D349.0001155D@outpost.mndmttr.nl>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="utf-8"
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

LS. 

I am currently writing a driver for the ADI 1836 on the (ongoing) 
blackfin/uclinux port (blackfin.uclinux.org) and I have some questions (that 
I'll post in separate mails, so that they may be separate threads) 

The particular hardware configuration I am programming for is full-duplex in 
principle, i.e. it should be no problem to send and receive pcm bitstreams 
simultaneously, except that it requires that both dma channels are started 
simultaneously.  Currently, I configure an unused substream with a dummy dma 
buffer, but the alsa mid layer seems to handle this badly: it appears to 
re-triggers the last-started substream when it finds out that the dma is at 
an other address than it expects. 

my question is: is there a way around this, i.e. can I tell the mid layer to 
resync itself with the dma instead of the other way around? 

thanks
   Luuk van Dijk


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8

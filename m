From: Chris Horler <chris.horler@clara.co.uk>
Subject: intel-8x0 dumping registers
Date: Thu, 9 Sep 2004 00:24:16 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200409090024.17116.chris.horler@clara.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

Hi All,

I get no sound from my 8x0, I've checked most standard settings and should be.
I dumped the registers from windows using PCItree.  I compared them with the 
ac97 dump the linux driver provides, I don't see any problems there.
However I've still got the rest of the configuration space to consider.  I 
don't know how to dump this in Linux, I tried reading /dev/mem but I'm 
getting zeros and I think I must be missing a step.  I'm using the bar0 and 
bar1 addresses which are configured for io.

Any pointers on accessing the io registers on Linux to dump their contents for 
comparison?  Further I have no docs on anything but the ad1981b,  do I need 
any other information as this doesn't cover the values I'm reading in windows 
from the range not listed there (i.e. past the end of the ac97 registers 
listed in the docs from ad).

Thanks,

Chris


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click

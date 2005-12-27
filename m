From: John Rigg <j@sound-man.co.uk>
Subject: Re: [Alsa-devel] Re: Real-world reports on two Delta 1010LTs/ice1712 synched?
Date: Tue, 27 Dec 2005 13:00:29 +0000
Message-ID: <20051227130029.GB3770@localhost.localdomain>
References: <20051223233816.GA5102@localhost.localdomain> <43AC8990.7040900@nostar.net> <20051224124823.GA4183@localhost.localdomain> <20051224144548.GA4306@localhost.localdomain> <20051224165610.GA4484@localhost.localdomain> <43AE9FA6.2020207@nostar.net> <20051226130327.GA4763@localhost.localdomain> <43B059A3.2050302@nostar.net> <20051227000428.GA3805@localhost.localdomain> <43B0A83F.1040907@nostar.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <jackit-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <43B0A83F.1040907@nostar.net>
Sender: jackit-devel-admin@lists.sourceforge.net
Errors-To: jackit-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/jackit-devel>,
	<mailto:jackit-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:jackit-devel@lists.sourceforge.net>
List-Help: <mailto:jackit-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/jackit-devel>,
	<mailto:jackit-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=jackit-devel>
To: Doug McLain <doug@nostar.net>
Cc: alsa-devel@lists.sourceforge.net, jackit-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 26, 2005 at 09:34:39PM -0500, Doug McLain wrote:
> All of the envy24control code treats the 1010 and 1010LT equally, so if 
> there is a difference, its in the hardware of the devices:
> 
> if (card_eeprom.subvendor == ICE1712_SUBDEVICE_DELTA1010 ||
> 	    card_eeprom.subvendor == ICE1712_SUBDEVICE_DELTA1010LT) {
> 		delta specific stuff here...
> 
> I find it strange that the envy24control patch does not change anything 
> for me.  What exactly was your issue with envy24control before applying 
> that patch?

With 2.6.14 or later kernel, starting envy24control (from alsa-tools-1.0.10)
from xterm resulted in a slew of error messages saying "Unable to determine
word clock status" scrolling off the xterm. The patch fixed that. Maybe that
only happens with the 1010 not the 1010LT. It's possible that with the broken
word clock on the 1010LT it wasn't even trying to determine word clock
status so it didn't trigger the bug.

John


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click

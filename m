From: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
Subject: Re: [PATCH] Adds dB gain to alsa-driver, alsa-lib.
Date: Thu, 15 Dec 2005 19:32:05 +0000
Message-ID: <1134675125.3313.23.camel@localhost.localdomain>
References: <43A1B744.2050703@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <43A1B744.2050703@superbug.co.uk>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thu, 2005-12-15 at 18:34 +0000, James Courtier-Dutton wrote:

> 
> The only piece of information reported by the kernel sound driver is a 
> db_scale value.  It is a unsigned int at application layer, but the 
> current IOCTL TLV truncates this to 32bit unsigned int. alsa-lib then 
> uses this value to decide which translation function to apply to the 
> currently available "volume" value.
> I view this "db_scale" value as simply a hint from the low level driver 
> at which conversion function should be used.
> The conversion function in alsa-lib can then be as simple or as 
> complicated as required.
> 

I'm wondering whether it might be a better idea to use the "db_scale" to
store the specifics of the gain rather than just a hint.

IMHO we need to be able to specify:-

 o number of steps in control
 o starting dB setting
 o step size (including negative bit)

This could either be divided up into the 32 bits of db_scale or by
adding another member(s) to the struct.

This would then mean alsa lib doesn't need to know about the dB settings
for each codec/card (as they are quite different) and the dB information
would be in the driver where it belongs.

Liam

 



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click

From: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
Subject: Re: [PATCH] Adds dB gain to alsa-driver, alsa-lib.
Date: Fri, 16 Dec 2005 10:49:01 +0000
Message-ID: <1134730142.3137.17.camel@scooper.cruach>
References: <43A1B744.2050703@superbug.co.uk>
	 <1134675125.3313.23.camel@localhost.localdomain>
	 <43A1C89D.90200@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <43A1C89D.90200@superbug.co.uk>
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

On Thu, 2005-12-15 at 19:48 +0000, James Courtier-Dutton wrote:

> Problems with your approach were:
> 1) Control with non-linear dB steps. E.g. attenuation using a different 
> scale than gain.

In my experience, the majority of controls (certainly in the embedded
space) use a linear dB scale to adjust the gain/attenuation and would be
better served by a value rather than a hint. A hint would still be
required for the non linear controls.

How do you feel about adding a further field called db_hint. This way
the hint method could be used for the more complex and non linear
controls whilst the value method could be used for the simple ones. 

This would save a lot effort, as driver developers wouldn't need to add
any hints to alsa-lib for simple controls.
 
> 2) Complicates controls where only a lookup table will do.
> 

I agree, but with both fields this isn't an issue.

Further to this, I realised this code could also be used for other
controls that are unitised. i.e. some ALC controls use ms for timeouts.
This hint and scale could also be used to describe them.

Liam 



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click

From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: [PATCH] Adds dB gain to alsa-driver, alsa-lib.
Date: Thu, 15 Dec 2005 19:48:45 +0000
Message-ID: <43A1C89D.90200@superbug.co.uk>
References: <43A1B744.2050703@superbug.co.uk> <1134675125.3313.23.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1134675125.3313.23.camel@localhost.localdomain>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Liam Girdwood wrote:
> 
> I'm wondering whether it might be a better idea to use the "db_scale" to
> store the specifics of the gain rather than just a hint.
> 
> IMHO we need to be able to specify:-
> 
>  o number of steps in control
>  o starting dB setting
>  o step size (including negative bit)
> 
> This could either be divided up into the 32 bits of db_scale or by
> adding another member(s) to the struct.
> 
> This would then mean alsa lib doesn't need to know about the dB settings
> for each codec/card (as they are quite different) and the dB information
> would be in the driver where it belongs.
> 
> Liam
> 

We discussed this point some time ago on the list.
the "hint" is better, because it then lets alsa-lib decide which 
conversion function to use.
Problems with your approach were:
1) Control with non-linear dB steps. E.g. attenuation using a different 
scale than gain.
2) Complicates controls where only a lookup table will do.

James



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click

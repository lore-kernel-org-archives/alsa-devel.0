From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: RFC: OSS driver removal, a slightly different approach
Date: Fri, 20 Jan 2006 04:46:20 +0100
Message-ID: <43D05D0C.1030900@keyaccess.nl>
References: <20060119174600.GT19398@stusta.de> <m3ek34vucz.fsf@defiant.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtpq1.tilbu1.nb.home.nl (smtpq1.tilbu1.nb.home.nl [213.51.146.200])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 29F8C138
	for <alsa-devel@alsa-project.org>; Fri, 20 Jan 2006 04:45:06 +0100 (MET)
In-Reply-To: <m3ek34vucz.fsf@defiant.localdomain>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, perex@suse.cz
List-Id: alsa-devel@alsa-project.org

Krzysztof Halasa wrote:

>> SOUND_ADLIB
> 
> IIRC 8-bit sound, ISA. GUS on DOS used to emulate it

Extremely classic card. Would be fun to still have around if only for 
history's sake...

>> SOUND_PAS
> 
> Pro Audio Spectrum. Earlier than GUS? 8-bit I think

Also drives my PAS16s. Yes, it's very old -- non-pnp ISA and all that. 
Used to be a fairly popular card at the time though (since it sounds 
better than most other cards of the era) so there's still a couple of 
those around. I believe I have three lying around somewhere, one of them 
in fact still installed (in a machine that's currently not available 
though).

Sure, wouldn't be a tragedy to remove, but keeping it neither (writing 
an ALSA driver for the stupid thing has been on my personal TODO only 
slightly shorter then all the items preceding it).

>> SOUND_PSS
>> SOUND_SB
> 
> The original one (8-bit)? Not sure about relation to Kahlua and PAS

The relation to PAS16 at least is that the PAS includes a (independent) 
SB8 compatible chip. The OSS driver supplies two sound devices. At the 
moment, I'm not recalling with certainty whether or not they were also 
hardware mixed, but I guess they were...

Rene.


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642

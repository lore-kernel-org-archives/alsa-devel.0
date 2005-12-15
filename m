From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: [PATCH] Adds dB gain to alsa-driver, alsa-lib.
Date: Thu, 15 Dec 2005 19:06:37 +0000
Message-ID: <43A1BEBD.4010304@superbug.co.uk>
References: <43A1B744.2050703@superbug.co.uk> <1134673103.12086.144.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1134673103.12086.144.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Lee Revell wrote:
> On Thu, 2005-12-15 at 18:34 +0000, James Courtier-Dutton wrote:
> 
>>Hi,
>>
>>I have implemented dB gain reporting for ALSA mixer controls.
>>By applying the attached patches to alsa-driver and alsa-lib, one will 
>>then see dB values appear in alsamixer. (I added support to alsamixer a 
>>long time ago)
>>
>>Currently, only the snd-ca0106 sound card reports the values.
>>
>>If the method is agreed upon, I will extend it to many more sound cards.
> 
> 
> Can you briefly explain the process for adding this feature to an
> existing driver (IOW say you have no docs just a vendor-obfuscated or
> RE'd driver, how do you determine db_scale)?
> 
> Lee
> 

There is no point in RE the windows driver, because windows does not 
display dB values.
You do it simply by measurements.
You calibrate a line-in from a sound card that has documentation.
Then connect it to the suspect sound card's output and measure it.

Same for mic/line in.

I will be implementing this dB support on creative cards first, as I 
have some details for them. We have docs for all AC97 controls. So 
hopefully that won't leave many other controls to do.

Please note, my last patch has a few errors in it, so that it does not 
always supress the dB display with unsupported cards. I have fixed this 
in my own tree, but I would like full feedback first.

Which sound card do you have?

James



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click

From: Doug McLain <doug@nostar.net>
Subject: Re: ice1712 -wordclock and SPDIF
Date: Fri, 03 Feb 2006 11:24:26 -0500
Message-ID: <43E383BA.1040204@nostar.net>
References: <200601262301.23064.gineera@aspect135.co.uk> <200601281424.14897.gineera@aspect135.co.uk> <43E12866.4030903@nostar.net> <200602020947.29156.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200602020947.29156.gineera@aspect135.co.uk>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alan Horstmann <gineera@aspect135.co.uk>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org



Alan Horstmann wrote:
> On Wednesday 01 February 2006 21:30, you wrote:
> 
>>CS8427 register dump:
>>   reg[0x01] = 0x81
>>   reg[0x02] = 0x00
>>   reg[0x03] = 0x0c
>>   reg[0x04] = 0x41
> 
> 
> I have been looking at reg0x04 for bug1785; value 41 means the AES3 bit 
> (bit'0') is set, which will mess-up SPDIF IN.  Perhaps try the reset patch on 
> that report.  With DMX6fire it is often re-written correctly anyway, so it 
> may be a similar but separate problem here.
> 
> However, reg0x03 I notice now also looks wrong, and controls the output data 
> source with bits'1'&'2': value 0c means bits are '1,0' =sourced from AES3 
> receiver.  Think it should be '0,1' ie reg value 0a?

setting it to 0x0a breaks it completely, as in no spdif functionality no 
way, no how.  Patches didnt help either. Wtih any luck, the status of 
your registers may tell the story.
> 
> Busy few evenings, but will get full info dump fromDMX6fire asap.
> 
Thanks
Doug
--
http://nostar.net


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642

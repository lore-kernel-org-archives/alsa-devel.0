From: Rimas Kudelis <rq@akl.lt>
Subject: Re: Re: Test model
Date: Fri, 17 Feb 2006 15:17:53 +0200
Message-ID: <43F5CD01.2070900@akl.lt>
References: <200602170159.k1H1xYkI018018@auster.physics.adelaide.edu.au>	 <43F5BC71.6040404@akl.lt> <acb0c1690602170457l5335e137vf3db87bdc7f3857e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <acb0c1690602170457l5335e137vf3db87bdc7f3857e@mail.gmail.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paulo Matias <syscoder@gmail.com>
Cc: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Paulo Matias wrote:
> (Copy only of the body of the email I sent to Jonathan with the files)

Could you send a copy for me now? :) Well, OTOH, I can look them up on 
the Acer's website.

> But, hey, I've looked better at the driver files and found an
> AzMixerSel.ini. This file has clsids associated with mixer controls,
> like this:
> 
> [008F1025&Dev0_{0A8C1AA2-42B0-11D2-95D2-00C04FB925D3}]
> Name=Master Volume
> DeviceName=Realtek HD Audio output
> Volume=32845
> Mute=0
> SelectMode=0
> 
> I've installed the driver in my Wine and then looked for these clsids
> in the drive_c directory of Wine, and found only one binary file that
> references all these clsids: windows/system32/drivers/RtkHDAud.Sys.
> 
> I suspect all the manufacturers use the same driver provided by
> Realtek and then change the AzMixerSel.ini for adjusting the internal
> routings.

IMO, that would make a lot of sense, indeed.

> Now, how can we know what clsid refers to what?
> 
> 1. by comparision with models we already know the routings, like Fujitsu
> 2. by contacting Realtek
> 3. maybe by reverse engineering?

1 and 2 should be easiest (if effective), probably. It should be 
relatively easy to find the manufacturer's drivers for other ALC260 
laptops on the Internet. Then we could at least try to compare Acer's 
ini with Fujitsu's with HP's. Hopefully, that would help us. I'll try 
to dig into this right now. :)

Rimas


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642

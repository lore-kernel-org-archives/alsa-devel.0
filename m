From: Rimas Kudelis <rq@akl.lt>
Subject: Re: Re: Test model
Date: Fri, 17 Feb 2006 20:18:47 +0200
Message-ID: <43F61387.1050109@akl.lt>
References: <200602170159.k1H1xYkI018018@auster.physics.adelaide.edu.au>	 <43F5BC71.6040404@akl.lt> <acb0c1690602170457l5335e137vf3db87bdc7f3857e@mail.gmail.com> <43F5CD01.2070900@akl.lt>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <43F5CD01.2070900@akl.lt>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
Cc: Paulo Matias <syscoder@gmail.com>, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi again,

Rimas Kudelis wrote:
>> [008F1025&Dev0_{0A8C1AA2-42B0-11D2-95D2-00C04FB925D3}]
>> Name=Master Volume
>> DeviceName=Realtek HD Audio output
>> Volume=32845
>> Mute=0
>> SelectMode=0
>>
>> I've installed the driver in my Wine and then looked for these clsids
>> in the drive_c directory of Wine, and found only one binary file that
>> references all these clsids: windows/system32/drivers/RtkHDAud.Sys.
>>
>> I suspect all the manufacturers use the same driver provided by
>> Realtek and then change the AzMixerSel.ini for adjusting the internal
>> routings.
> 
> IMO, that would make a lot of sense, indeed.
> 
>> Now, how can we know what clsid refers to what?
>>
>> 1. by comparision with models we already know the routings, like Fujitsu
>> 2. by contacting Realtek
>> 3. maybe by reverse engineering?
> 
> 1 and 2 should be easiest (if effective), probably. It should be 
> relatively easy to find the manufacturer's drivers for other ALC260 
> laptops on the Internet. Then we could at least try to compare Acer's 
> ini with Fujitsu's with HP's. Hopefully, that would help us. I'll try to 
> dig into this right now. :)

I've compared the ini files for my Acer and a Fujitsu (Downloaded both 
drivers from the internet). As expected - there are some matching 
GUIDs, but also, quite a few are different (for example, the one 
labeled "CD volume"). It's a bit pity I couldn't find similarly 
distributed drivers for HP or Sony Vaio models (Along with Fujitsu, 
these are the only ones that are detected by the driver). Both HP and 
Sony distribute their drivers in exe format, and Sony requires you to 
enter your laptop serial number before giving you a link to the 
download. That sucks a little, as I'm not sure all that would install 
under Wine, or that it would have that ini file...

It would be great to get more ini files though. Or more information on 
them...

Rimas


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642

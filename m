From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: Urgent question
Date: Mon, 09 Jan 2006 11:17:50 +0000
Message-ID: <43C2465E.8070504@superbug.co.uk>
References: <0AEFDFCCEC85B24E8051B23293C2CB640F2503@MMMSTCAE1.muac.corp.eurocontrol.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <0AEFDFCCEC85B24E8051B23293C2CB640F2503@MMMSTCAE1.muac.corp.eurocontrol.int>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: PIVATY Bertrand <bertrand.pivaty@eurocontrol.int>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

PIVATY Bertrand wrote:

>Dear all,
>
> 
>
>(Happy New Year)
>
> 
>
>My name is Bertrand Pivaty and I'm a software engineer.
>
> 
>
>We use an audio software to simulate sound communication on our Air
>Traffic Control simulator.
>
>The sound quality looks good when using the onboard sound card provided,
>but when using any PCI sound card the sound quality is really poor.
>
>Do you have any idea of what could be the reason, or any track where we
>should investigate.
>
> 
>
>The software is running on Suse 9.0 with the last Alsa version.
>
> 
>
>Do not hesitate if any question. I will not be allowed to send any part
>of the software, but I will do my best to answer.
>
> 
>
>Any comment would be really appreciated.
>
> 
>
>Many thanks in advance.
>
> 
>
>Bertrand
>  
>
There is obviously a bug in your software causing this.
In order to test this, try the "speaker-test" program that comes with 
alsa-utils.
It can send pink noise, a single tone, or a .wav file to the sound card.
Another option is "aplay". If these two application deliver sound to the 
sound card parfectly, then it is most certainly a bug in your software.
Without being able to view the source code, there is very little else we 
can do to help you.
If these test programs, cause exactly the same problems that you are 
getting with your software, we would need more detailed information 
regarding your hardware.

e.g.
cat /proc/asound/cards
cat /proc/asound/version





-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click

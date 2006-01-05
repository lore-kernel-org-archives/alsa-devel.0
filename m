From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: OSS emulation improvements.
Date: Thu, 05 Jan 2006 23:57:16 +0000
Message-ID: <43BDB25C.1020802@superbug.demon.co.uk>
References: <43BD7B69.7030103@superbug.demon.co.uk> <1136503659.18700.63.camel@renegade>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1136503659.18700.63.camel@renegade>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Ove Kaaven <ovek@transgaming.com>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Ove Kaaven wrote:
> tor, 05,.01.2006 kl. 20.02 +0000, skrev James Courtier-Dutton:
> 
>>Hi,
>>
>>I have be trying to think of ways to improve OSS emulation for ALSA.
>>Now, the ideal solution is probably a userland daemon that will create 
>>kernel /dev/dspX  nodes.
>>Any application opening/ioctl/read/write to /dev/dspX would have all 
>>those calls redirected to the userland daemon.
>>But I am not exactly sure how to achieve this.
> 
> 
> Perhaps this project I once came across can inspire you:
> http://fort.xdas.com/~kor/oss2jack/
> 

Thank you. That looks very promising.
If it works for Quake3 and Doom3, it will get those pesky OSS lovers off 
our backs!  ;-)

James



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click

From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: alsa-driver in the kernel
Date: Fri, 25 Nov 2005 20:36:31 +0000
Message-ID: <438775CF.4060300@superbug.co.uk>
References: <438761DD.3090009@brend.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <438761DD.3090009@brend.org>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Peter Ganzhorn <shutdown@brend.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Peter Ganzhorn wrote:
> Hi there,
> 
> there are several hints on how to update the in-kernel alsa driver with 
> the alsa driver one can download from alsa-project.org, but I had no 
> luck at all updating kernel 2.6.14.3 with alsa 1.0.10 - it seems that 
> there is something missing in the kernel, but there is nothing more 
> mentioned to do in the howtos.
> 

Why are you even trying to do this?
The easiest way is to make all ALSA modules, and then just install 
alsa-driver from alsa-project.org.

If you really have to, just use git.
Get the 2.6.14.3 git tree, and then pull the alsa git into it. It will 
merge it all nicely for you.

James


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click

From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: snd-es1968 (+ snd-cs4236) trouble
Date: Sun, 11 Dec 2005 16:16:38 +0100
Message-ID: <439C42D6.1050002@keyaccess.nl>
References: <439B36E0.3090709@keyaccess.nl> <20051211090848.GB11694@procyon.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtpq1.groni1.gr.home.nl (smtpq1.groni1.gr.home.nl [213.51.130.200])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 0A4E81A1
	for <alsa-devel@alsa-project.org>; Sun, 11 Dec 2005 16:13:08 +0100 (MET)
In-Reply-To: <20051211090848.GB11694@procyon.home>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Sergey Vlasov <vsu@altlinux.ru>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Sergey Vlasov wrote:

>>Call Trace:
>> [<f093f00c>] snd_platform_driver_probe+0xc/0xd [snd]

> This also looks like the bug #1623:
> 
> https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1623
> 
> Please try the patch attached to that bugreport.

Yes, this lets the 1.0.10 snd-cs4236 load again, thanks.

Also confirmed that the 1.0.10 snd-cs4236 + snd-es1968 behaviour is 
still as described for 1.0.10-rc1: snd-cs4236 dead as soon as snd-es1968 
is inserted.

Rene.




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click

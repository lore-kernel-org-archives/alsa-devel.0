From: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: RFC: OSS driver removal, a slightly different
 approach
Date: Sat, 21 Jan 2006 10:01:33 +0100 (MET)
Message-ID: <Pine.LNX.4.61.0601211000060.21704@yvahk01.tjqt.qr>
References: <20060119174600.GT19398@stusta.de>  <200601191947.20748.pzad@pobox.sk>
  <Pine.LNX.4.61.0601201524080.22940@yvahk01.tjqt.qr> <1137810430.3241.97.camel@mindpipe>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from linux01.gwdg.de (linux01.gwdg.de [134.76.13.21])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 97839176
	for <alsa-devel@alsa-project.org>; Sat, 21 Jan 2006 10:01:34 +0100 (MET)
In-Reply-To: <1137810430.3241.97.camel@mindpipe>
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
Cc: Peter Zubaj <pzad@pobox.sk>, alsa-devel@lists.sourceforge.net, Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, perex@suse.cz
List-Id: alsa-devel@alsa-project.org

>> I have a card that works with the snd-cs46xx module.
>> With the OSS emulation (/dev/dsp), I can only output 2 channels, and the 
>> other two must be sent to /dev/adsp. Is this intended? Would not it be 
>> easier to make /dev/dsp allow receiving an ioctl setting 4 channels?
>
>Why can't you just use aoss?

Did not know it before.


Jan Engelhardt
-- 


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642

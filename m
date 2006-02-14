From: Pierre Ossman <ossman@cendio.se>
Subject: Re: [RFC][PATCH] Transparent network support through
 polypaudio
Date: Tue, 14 Feb 2006 16:48:56 +0100
Message-ID: <43F1FBE8.6050509@cendio.se>
References: <43F09D76.9060004@cendio.se> <20060214094741.GA8943@turing.informatik.uni-halle.de> <43F1B26E.5@cendio.se> <20060214143540.GB11753@turing.informatik.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.cendio.se (mail.cendio.se [193.12.253.69])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E029A197
	for <alsa-devel@alsa-project.org>; Tue, 14 Feb 2006 16:48:57 +0100 (MET)
In-Reply-To: <20060214143540.GB11753@turing.informatik.uni-halle.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org, mzcbylcnhqvb@0pointer.de
List-Id: alsa-devel@alsa-project.org

Clemens Ladisch wrote:
> Pierre Ossman wrote:
> 
>>Clemens Ladisch wrote:
>>
>>>I think you may be required to use a timer for the mainloop.  What does
>>>polypaudio actually do in this callback?  How often must it be called?
>>
>>Primarily updates to available buffer space on the server.
> 
> 
> Shouldn't the data be sent as early as possible, i.e., directly after
> the snd_pcm_write() or snd_mmap_commit()?
> 

I believe it does. What I meant was that the server reports back as it 
consumes the buffer in the other end. That allows us to check available 
space without a round trip to the server.

Rgds
-- 
Pierre Ossman                Telephone: +46-13-21 46 00
Cendio AB                    Web: http://www.cendio.com


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642

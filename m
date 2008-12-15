From: Pete <peterpion@yahoo.com>
Subject: Re: Xrun stack trace for 1010LT
Date: Mon, 15 Dec 2008 07:23:36 -0800 (PST)
Message-ID: <395938.70869.qm@web65412.mail.ac4.yahoo.com>
References: <20081205160215.GA3295@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from web65412.mail.ac4.yahoo.com (web65412.mail.ac4.yahoo.com
	[76.13.9.32]) by alsa0.perex.cz (Postfix) with SMTP id AF1D91037ED
	for <alsa-devel@alsa-project.org>; Mon, 15 Dec 2008 16:23:37 +0100 (CET)
In-Reply-To: <20081205160215.GA3295@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: John Rigg <aldev@sound-man.co.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I have fixed my problem and thought it was best to make a record of what worked in case anyone is ever searching for it. This will I guess be obvious to most people seeing this but if I had been able to find a snippet like this a month ago, I would have saved many dozens of hours searching and trying things! So for those like me who dont intuitivley know this...

Turned out very simple, I just used /dev/sda3 (a 'raw' partition on the disk) as the output file. Now having tested for many hours, it works perfectly, and there has not been a single overrun, on a non RT kernel, with no special permissions, priority, prempt flags or anything. This is probably not suitable for many people as the output 'file' is not as conveniently accessable as a simple file, but if you need to make it work, thats how to do it.

I found that I couldent use arecord to write directly to the partition, im not exactly sure why but I guess its because arecord dosent quite know how to write to a partition. However making arecord output the digital data to stdout and piping it to dd which then writes it to the partition works fine. For the record thats 16 channels at 88200 kHz, 24 bit.

The partition can then be turned into a file using DD again to read it from the partition and write it to a file.

BTW if any developers are reading this, maybe you can improve the performance of some of the tools youre writing by using a scratch disk accessed directly? I would be interested to try if anyone does write it.

Thanks for the help.


John Rigg <aldev@sound-man.co.uk> wrote: On Fri, Dec 05, 2008 at 07:23:00AM -0800, Pete wrote:
> Is there likely to be any disadvantage to running arecord rather
> than say Jack to capture? Does (say) Jack read the card in a 'better' 
> way?

jackd runs with realtime priority if -R option is specified
when starting it. Running it without -R produces xruns fairly 
often, but with -R they almost never happen on a properly configured
system. I don't know if arecord can run with realtime priority.

John
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: [PATCH] Adds dB gain to alsa-driver, alsa-lib.
Date: Fri, 16 Dec 2005 15:05:12 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0512161456560.10849@tm8103.perex-int.cz>
References: <43A1B744.2050703@superbug.co.uk> <Pine.LNX.4.61.0512151940270.9555@tm8103.perex-int.cz>
 <43A1C7F5.6070307@superbug.co.uk> <Pine.LNX.4.61.0512161323540.10849@tm8103.perex-int.cz>
 <43A2BC38.5060001@superbug.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <43A2BC38.5060001@superbug.co.uk>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Fri, 16 Dec 2005, James Courtier-Dutton wrote:

> Once the call gets into the kernel, whether it gathers the required
> information via a callback or just grabbing a value from a kernel structure
> makes very little difference.

It makes. The memory usage is a bit different. In your case you'll eat
a bit more memory, my solution eats a bit more code. Your solution cannot
be optimized with a programmer, my solution (code) can be nicely 
optimized.

> For the db_scale "hint", I though a callback was overkill, but some 
> other value might be more complex and thus need a callback.

Really? Imagine that all your control will use one callback (the hint is 
same). The code might use less or equal amount of memory than yours 
without extra runtime memory in the kcontrol structure.

> Your static structure idea seems a little more constraining than my method.

Sure, but the kernel API is not about to solve everything 100 years ahead.

> I was thinking that a possible addition to my method would be a batch 
> request.

It's not problem with my solution, too. Imagine a new ioctl() which 
requests a key and value size - which should be collected for application 
and a pointer to large user space memory area and you can do collecting, 
too. But these optimizations can be implemented on demand.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click

From: Glenn English <ghe@slsware.com>
Subject: Re: jerks
Date: Thu, 08 Dec 2005 12:49:46 -0700
Message-ID: <1134071386.13439.93.camel@snuk.slsware.lan>
References: <1134063707.13439.37.camel@snuk.slsware.lan>
	 <20051208193138.GA4312@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20051208193138.GA4312@localhost.localdomain>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 2005-12-08 at 19:31 +0000, John Rigg wrote:

> > This happens with a 2.6 kernel from the current updated Sarge or a 2.4
> > from DeMuDi 1.2.1 distro.
> 
> Could this be the libc NPTL bug? Sarge has a buggy version of glibc with
> a broken NPTL implementation (don't know about DeMuDi 1.2.1).
> If so, threaded apps won't perform properly - I switched to sid for this
> reason.
> Workaround is to set LD_ASSUME_KERNEL=2.4.22 for jackd and other audio
> apps. In sid it's fixed, and you'll also get the extra benefits of
> gcc-4.0's better AMD64 optimisation.

The prospect of sid is terrifying on a machine I'd like to rely on :-)
But I'll try it. Thanks.

DeMuDi, though, runs a 2.4 (.27, I think) and it does the same thing.

-- 
Glenn English
ghe@slsware.com
GPG ID: D0D7FF20



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click

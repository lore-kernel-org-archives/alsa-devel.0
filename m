From: John Anderson <ardour@semiosix.com>
Subject: Re: anybody else OK with current CVS *and* SMP?
Date: 06 Aug 2003 16:39:12 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1060180752.399.166.camel@groovious.semiosix.local>
References: <200308051417.h75EHwpr020319@localhost.localdomain>
	 <1060178716.392.160.camel@groovious.semiosix.local>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1060178716.392.160.camel@groovious.semiosix.local>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 2003-08-06 at 16:05, John Anderson wrote:
> On Tue, 2003-08-05 at 16:17, Paul Davis wrote:
> > i am having a repeated problem with system lockups using current CVS
> > with JACK running SCHED_FIFO on an SMP system, with the Planet's
> > 2.4.21 kernel.
> > 
> > can anyone report that a similar configuration is working for them?
> 
> I'm using alsa-0.9.6, slightly patched but otherwise vanilla
> linux-2.4.20 SMP, jack-0.74.1. Starting jack with
> 
> jackd -R -a --tmpdir /mnt/ramfs -d alsa -d terratec -n 3 -p 128
> 
> with an EWS88MT (ice1712) and it's fine. I'm fetching latest CVS now,
> will let you know.

Nope. Latest CVS (1/2 an hour ago) compile fails with

rawmidi_virt.c: In function `snd_rawmidi_virtual_open':
rawmidi_virt.c:342: `SND_RAWMIDI_TYPE_VIRTUAL' undeclared (first use in this function)

Maybe this is a SourceForge CVS problem?

bye
John




-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01

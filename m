From: John Anderson <ardour@semiosix.com>
Subject: Re: anybody else OK with current CVS *and* SMP?
Date: 06 Aug 2003 17:04:51 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1060182291.387.178.camel@groovious.semiosix.local>
References: <200308051417.h75EHwpr020319@localhost.localdomain>
	 <1060178716.392.160.camel@groovious.semiosix.local>
	 <1060180752.399.166.camel@groovious.semiosix.local>
	 <s5hhe4ulu5b.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hhe4ulu5b.wl@alsa2.suse.de>
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

On Wed, 2003-08-06 at 16:48, Takashi Iwai wrote:
> > > On Tue, 2003-08-05 at 16:17, Paul Davis wrote:
> > > > i am having a repeated problem with system lockups using current CVS
> > > > with JACK running SCHED_FIFO on an SMP system, with the Planet's
> > > > 2.4.21 kernel.
> > > > 
> > > > can anyone report that a similar configuration is working for them?
> the fix is just the change from SND_RAWMIDI_TYPE_VIRT to
> SND_RAWMIDI_TYPE_VIRTUAL in include/rawmidi.h, BTW.

OK, compiled, installed etc. But no lockups with a 2.4.20 kernel. Is
there anything in particular that triggers it?

bye
John




-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01

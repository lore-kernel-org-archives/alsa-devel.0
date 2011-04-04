From: Svante Signell <srs@kth.se>
Subject: Re: Problems with snd_hda_intel in Linux kernel 2.6.38
Date: Mon, 04 Apr 2011 11:21:46 +0200
Message-ID: <1301908906.32453.94.camel@s1499.it.kth.se>
References: <1301394280.3906.29.camel@s1499.it.kth.se>
	<s5haage43qz.wl%tiwai@suse.de>
	<1301396296.32453.1.camel@s1499.it.kth.se>
	<s5h7hbi41xs.wl%tiwai@suse.de>
	<1301480744.21366.110.camel@hp.my.own.domain>
	<s5hpqp827sv.wl%tiwai@suse.de>
	<1301486370.32453.9.camel@s1499.it.kth.se>
	<4D932C71.10402@ladisch.de>
	<1301524966.21366.118.camel@hp.my.own.domain>
	<1301906577.32453.92.camel@s1499.it.kth.se>
	<s5h8vvqv0r2.wl%tiwai@suse.de>
Reply-To: srs@kth.se
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-2.sys.kth.se (smtp-2.sys.kth.se [130.237.32.160])
	by alsa0.perex.cz (Postfix) with ESMTP id 3272B1038FD
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Apr 2011 11:21:49 +0200 (CEST)
In-Reply-To: <s5h8vvqv0r2.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: 619034@bugs.debian.org, alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>, 613979@bugs.debian.org
List-Id: alsa-devel@alsa-project.org

On Mon, 2011-04-04 at 11:12 +0200, Takashi Iwai wrote:
> At Mon, 04 Apr 2011 10:42:57 +0200,
> Svante Signell wrote:
> > 
> > On Thu, 2011-03-31 at 00:42 +0200, Svante Signell wrote:
> > > On Wed, 2011-03-30 at 15:13 +0200, Clemens Ladisch wrote:
...
> > Anything happening here with respect to this bug? How can I help
> > further? Booting with 2.6.32 all the time does not feel like a good
> > solution in long term.
> 
> The point where it Oops implies that the problem isn't in the sound
> driver but rather in a breakage in a deeper level, either PCI core,
> x86 mm or ACPI/BIOS.
> 
> Any chance to bisect the kernel?

Never done that before. Is there a bisect HOWTO somewhere?

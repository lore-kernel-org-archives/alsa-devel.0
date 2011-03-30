From: Svante Signell <srs@kth.se>
Subject: Re: Problems with snd_hda_intel in Linux kernel 2.6.38
Date: Wed, 30 Mar 2011 13:59:30 +0200
Message-ID: <1301486370.32453.9.camel@s1499.it.kth.se>
References: <1301394280.3906.29.camel@s1499.it.kth.se>
	<s5haage43qz.wl%tiwai@suse.de>
	<1301396296.32453.1.camel@s1499.it.kth.se>
	<s5h7hbi41xs.wl%tiwai@suse.de>
	<1301480744.21366.110.camel@hp.my.own.domain>
	<s5hpqp827sv.wl%tiwai@suse.de>
Reply-To: srs@kth.se
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-2.sys.kth.se (smtp-2.sys.kth.se [130.237.32.160])
	by alsa0.perex.cz (Postfix) with ESMTP id E13C32444E
	for <alsa-devel@alsa-project.org>;
	Wed, 30 Mar 2011 13:59:34 +0200 (CEST)
In-Reply-To: <s5hpqp827sv.wl%tiwai@suse.de>
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
Cc: 619034@bugs.debian.org, alsa-devel@alsa-project.org, 613979@bugs.debian.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2011-03-30 at 12:59 +0200, Takashi Iwai wrote:
> At Wed, 30 Mar 2011 12:25:44 +0200,
> Svante Signell wrote:
> > 
> > On Tue, 2011-03-29 at 13:10 +0200, Takashi Iwai wrote:
> > > At Tue, 29 Mar 2011 12:58:16 +0200,
> > > Svante Signell wrote:
> > > > 
> > > > On Tue, 2011-03-29 at 12:31 +0200, Takashi Iwai wrote:
> > > > > At Tue, 29 Mar 2011 12:24:40 +0200,
> > > > > Svante Signell wrote:
> > ...
> > > > > But let's check the Oops first as below.
...
> The offset is 0x3ad.  As azx_probe() in the disassembled code begins
> with 0x1fd, it points to 0x5aa (0x1fd + 0x3ad).  You can see the
> disassembled code matches with the dump in "Code:" in Oops.

Sorry, I did not see any match in the objdump and Oops Code.
Code: f4 01 00 00 ef 31 f6 48 89 df e8 15 dd ff ff 85 c0
0f 88 2b 03 00 00 48 89 ef e8 ee 11 b9 e0 8b 7b 40 e8 9f 25 a7 e0 48 8b
43 38 <66> 8b 10 66 89 14 24 8b 43 14 83 e8 03 83 f8 01 77 32 31 d2 be 
Never mind, tanks anyway.

> However, you objdump output doesn't give the line number.  Did you
> install the corresponding debug package?  Usually this is stripped in
> the main package and provided as an add-on.

You mean that I need to install a debug version of the kernel? If yes I
will do that when having physical access to that computer again
(probably tonight or tomorrow)

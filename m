From: "James Courtier-Dutton" <James@superbug.demon.co.uk>
Subject: RE: some bits about cirrus 46xx: from LKML
Date: Sat, 16 Mar 2002 20:22:31 -0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <NGBBLNODKDFPBFMBBFAFGEOJCDAA.James@superbug.demon.co.uk>
References: <3C9330CF.3@tin.it>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 7bit
Received: from anchor-post-35.mail.demon.net (anchor-post-35.mail.demon.net [194.217.242.93])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id VAA10618
	for <alsa-devel@alsa-project.org>; Sat, 16 Mar 2002 21:22:55 +0100
In-Reply-To: <3C9330CF.3@tin.it>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: "Andrea Venturi (personale)" <andrea.venturi@tin.it>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

It is a shame that this person is really missing the point of what the open
source community really wants.
Good technical documentation, so that the open source DSP audio engineers
around the world can write a good 46xx driver for Linux.
We really don't need cirrus audio engineers, we just need good technical
documentation on the DSP.
E.g. Instruction sets, registers, assemblers, dis-assemblers, current source
code for the DSP static images.

If cirrus don't support or sell the product any more, what is the reason for
not giving out this information.

Cheers
James



> -----Original Message-----
> From: alsa-devel-admin@lists.sourceforge.net
> [mailto:alsa-devel-admin@lists.sourceforge.net]On Behalf Of Andrea
> Venturi (personale)
> Sent: 16 March 2002 11:47
> To: alsa-devel@alsa-project.org
> Subject: [Alsa-devel] some bits about cirrus 46xx: from LKML
>
>
> FYI: i didn't see this email on ALSA-DEVEL, so i'm posting here too..
>
> don't know if useful to anyone.. but it's a real pity to see the cirrus
> dsp couldn't be exploited to its "real" power by lack of a single cirrus
> people! :-(
>
> bye
>
> andrea venturi
>
> ================================
>
> From: "Woller, Thomas" <tom.woller@cirrus.com>
> To: "'David Ford'" <david+cert@blue-labs.org>,
>     "Woller, Thomas" <tom.woller@cirrus.com>,
>     linux-kernel <linux-kernel@vger.kernel.org>
> Subject: RE: 2.4.3+ sound distortion
> Date: 	Wed, 6 Mar 2002 10:43:53 -0600
>
> david, et al
> a) i am very sorry about the tinny sound you are experiencing. we
> no longer have any DSP pc audio engineers working at cirrus, and
> pc audio products are no longer developed or supported here at
> cirrus. i have talked this problem over with the only person that
> might help, and the debugging effort involved is extensive and
> may not yield results.  we do not fully understand the issue, but
> believe that several internal points in the DSP become misaligned
> resulting in the tinny sound.
> b) the static DSP image that is currently used with the linux
> cs46xx driver, is not capable of any of the fancy extensive
> feature set, and the work involved would require an engineer with
> intimate knowledge of the DSP which no longer is present.
> c)see b
> d) i am always willing to assist the linux effort, it's just
> difficult due to the lack of any support at cirrus for pc audio
> any longer.  i am working on embedded RTOS in my official job,
> but always try to fix any linux pc audio related bugs as i am
> able. also, without any DSP engineers we can not create another
> static DSP image with the additional tasks necessary to take
> advantage of the wonderful features of cards with the cs46xx
> controller. we are stuck with the current DSP images that are
> available.
>
> there is a small glimmer of light concerning secondary codec
> support and SPDIF support.  i had found 2 other "test" static DSP
> images that might be useful.
> i placed 2 piles of code out on a cirrus ftp site (see below).
> the first is a cs46xx driver with an untested static DSP image
> that snoops the data to the primary codec and pumps it to the
> secondary, so that there is sound coming from the rear speakers,
> although the same as the the front.
> the second pile of code (EOLT) contains a set of tests that we
> used for testing the cs4630.  the static image used in these
> tests contained in this directory functioned with SPDIF in/out. i
> am unsure whether the other tasks are loaded in this image to
> support the general audio data paths, so this static image may
> not support more than spdif.  i tried using the static "spdif"
> image on the latest cs46xx linux driver, but it did not work with
> a simple static image replacement in the source. specific problem
> definition and resolution using the spdif EOLT static image with
> the linux cs46xx sources, has not been determined.  anyone and
> everyone are welcome to look over these 2 piles of source, but my
> time is very limited concerning any new development for spdif
> and/or secondary codec.
> here is the ftp site info. the cs46xx code is based on an older
> version of the 2.4 kernel.
>
> server: ftp1.cirrus.com
> login: ftppclink
> password: cSPxQMd
>
> thanks
> Tom Woller
>
>
>
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

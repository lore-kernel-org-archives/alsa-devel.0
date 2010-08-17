From: Sander Knopper <sander@knopper.tk>
Subject: Re: ALC892 support for multiple spdif outputs
Date: Tue, 17 Aug 2010 09:00:27 +0200
Message-ID: <201008170900.27189.sander@knopper.tk>
References: <201008151457.51996.sander@knopper.tk>
	<201008161043.42070.sander@knopper.tk>
	<s5hmxsliv9z.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.knopper-ict.nl (odysseus.knopper-ict.nl [82.94.221.120])
	by alsa0.perex.cz (Postfix) with ESMTP id BAB042438A
	for <alsa-devel@alsa-project.org>;
	Tue, 17 Aug 2010 08:59:41 +0200 (CEST)
In-Reply-To: <s5hmxsliv9z.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tuesday 17 August 2010 08:54:32 Takashi Iwai wrote:
> At Mon, 16 Aug 2010 10:43:41 +0200,
> 
> Sander Knopper wrote:
> > On Monday 16 August 2010 10:30:14 you wrote:
> > > At Mon, 16 Aug 2010 09:52:31 +0200,
> > > 
> > > Sander Knopper wrote:
> > > > [1  <text/plain; iso-8859-1 (7bit)>]
> > > > 
> > > > On Monday 16 August 2010 08:42:07 you wrote:
> > > > > At Sun, 15 Aug 2010 14:57:51 +0200,
> > > > > 
> > > > > Sander Knopper wrote:
> > > > > > Dear developers,
> > > > > > 
> > > > > > I've opened a bug about this problem which can be viewed here:
> > > > > > https://bugtrack.alsa-project.org/alsa-bug/view.php?id=5101
> > > > > > 
> > > > > > Raymond mentions in his last comment that I should ask you to, if
> > > > > > I understand correctly, do the same trick as in the commit he
> > > > > > refers to also for the ALC892 chip. Which obviously is the one I
> > > > > > have...
> > > > > > 
> > > > > > You can find all the relevant information in the bug entry.
> > > > > 
> > > > > Could you post the exact problem and attach alsa-info.sh output to
> > > > > ML? It'll help much for communication on ML.
> > > > > 
> > > > > 
> > > > > Takashi
> > > > 
> > > > Ok, I can do that...
> > > > 
> > > > The problem is that I have an Asus P7H55 M Pro motherboard which uses
> > > > the ALC892 codec. I'm using this system as a HTPC and thus I'm
> > > > trying to get sound from the HTPC to my receiver. The motherboard
> > > > only has an optical output which shouldn't be an problem, be it that
> > > > my receiver only has a coaxial input.
> > > > 
> > > > So I bought an spdif bracket made by Asus which has both a coaxial
> > > > and optical output and connected it to the internal spdif pins on
> > > > the motherboard. So far so good, but the real problem is that I
> > > > can't get the bracket to work. When I unmute all the spdif related
> > > > entries with alsamixer only the optical output on the motherboard
> > > > itself "gives light" and the one on the bracket doesn't.
> > > > 
> > > > I've searched the internet a bit and I tried switching the audio
> > > > output in the bios from HDMI to SPDIF and vice versa, but that
> > > > doesn't make any difference.
> > > > 
> > > > alsa-info is attached.
> > > 
> > > OK.  Did you test the latest alsa-driver-snapshot?
> > > 
> > > 
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/tiwai/snapshot/alsa-driver
> > > -sn apshot.tar.gz
> > > 
> > > The multi-SPDIF support is generic for all Realtek codecs.
> > > 
> > > 
> > > Takashi
> > 
> > Should kernel 2.6.36-rc1 work too? Otherwise I'll try the snapshot...
> 
> 2.6.36-rc1 should be OK, too.
> 
> 
> Takashi


It works! Thanks a lot!


Sander

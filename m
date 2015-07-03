From: Antonio Ospite <ao2@ao2.it>
Subject: Re: Intel Baytrail Linux Audio
Date: Fri, 3 Jul 2015 12:32:08 +0200
Message-ID: <20150703123208.31881e788efd500dba8fe1dd@ao2.it>
References: <5589D025.7090700@gmail.com> <20150624101115.GI19530@localhost>
 <558ABDB6.4010702@gmail.com> <20150624160314.GM19530@localhost>
 <558BA1D8.8040508@intel.com> <55931EE8.5000604@gmail.com>
 <20150702184035.GA1418140@phare.normalesup.org>
 <1435913462.2478.14.camel@loki>
 <20150703110838.2cef7f669102bd60b5ee1b8c@ao2.it>
 <20150703094606.GA1643220@phare.normalesup.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp206.alice.it (smtp206.alice.it [82.57.200.102])
 by alsa0.perex.cz (Postfix) with ESMTP id E41FD260476
 for <alsa-devel@alsa-project.org>; Fri,  3 Jul 2015 12:32:14 +0200 (CEST)
In-Reply-To: <20150703094606.GA1643220@phare.normalesup.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolas George <george@nsup.org>
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Jarkko Nikula <jarkko.nikula@intel.com>, Tyler Yeomans <tyeo098@gmail.com>, Liam Girdwood <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 3 Jul 2015 11:46:06 +0200
Nicolas George <george@nsup.org> wrote:

> > Liam Girdwood <liam.r.girdwood@intel.com> wrote:
> > > Can you try the bytcr_rt5640 machine driver as the byt-rt5640 machine
> > > driver will be getting deprecated (since it only works with a small
> > > number of FWs). The bytcr_rt5640 driver works with a wider range of FW.
> 
> If that means just "modprobe snd-soc-sst-bytcr-rt5640" instead of "modprobe
> snd-soc-sst-byt-rt5640-mach" then it has no effect at all: the module is
> loaded but does not create any card and does not print anything.
> 

snd-soc-sst-bytcr-rt5640 will be loaded automatically if you use
snd-intel-sst-acpi instead of snd-soc-sst-acpi, you can blacklist
the latter using a file in /etc/modprobe.d (look up the details), or
just remove snd-soc-sst-acpi.ko from the installation dir as a dirty
hack.

> If that requires changing the source or using sources from a different
> repository, please be a little more specific.
>

In my tests I used the code from mainline linux.

> Antonio Ospite:
> > When testing the bytcr_rt5640 machine driver give also a try to the
> > latest firmwares:
> > 
> > https://git.kernel.org/cgit/linux/kernel/git/vkoul/firmware.git/tree/intel?h=byt
> > 
> > I had some success with fw_sst_0f28_ssp0.bin
> 
> I tried overwriting the fw_sst_0f28.bin-48kHz_i2s_master file with that
> file, but it just gives me this message:
>
> [  390.704580] baytrail-pcm-audio baytrail-pcm-audio: wrong ram type 0x7 in block0x0
> [  390.704591] baytrail-pcm-audio baytrail-pcm-audio: invalid module 0
> [  390.704596] baytrail-pcm-audio baytrail-pcm-audio: error: parse fw failed -22
> [  390.704610] baytrail-pcm-audio baytrail-pcm-audio: error: failed to load firmware
> 
> It happens when loading snd-soc-sst-baytrail-pcm, i.e. before loading
> snd-soc-sst-bytcr-rt5640(-mach).
> 
> I guess I am not following the instructions correctly.

Note that different drivers expect different firmwares, you cannot mix
them:

 snd-soc-sst-acpi   -> fw_sst_0f28.bin-48kHz_i2s_master
 snd-intel-sst-acpi -> fw_sst_0f28.bin
 snd-intel-sst-acpi -> fw_sst_0f28_ssp0.bin (renamed to fw_sst_0f28.bin)

Ciao,
   Antonio

-- 
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?

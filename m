From: Antonio Ospite <ao2@ao2.it>
Subject: Re: Intel Baytrail Linux Audio
Date: Fri, 3 Jul 2015 11:08:38 +0200
Message-ID: <20150703110838.2cef7f669102bd60b5ee1b8c@ao2.it>
References: <5589D025.7090700@gmail.com> <20150624101115.GI19530@localhost>
 <558ABDB6.4010702@gmail.com> <20150624160314.GM19530@localhost>
 <558BA1D8.8040508@intel.com> <55931EE8.5000604@gmail.com>
 <20150702184035.GA1418140@phare.normalesup.org>
 <1435913462.2478.14.camel@loki>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp206.alice.it (smtp206.alice.it [82.57.200.102])
 by alsa0.perex.cz (Postfix) with ESMTP id 5221A260484
 for <alsa-devel@alsa-project.org>; Fri,  3 Jul 2015 11:08:42 +0200 (CEST)
In-Reply-To: <1435913462.2478.14.camel@loki>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@intel.com>
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Tyler Yeomans <tyeo098@gmail.com>, Jarkko Nikula <jarkko.nikula@intel.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 03 Jul 2015 09:51:02 +0100
Liam Girdwood <liam.r.girdwood@intel.com> wrote:

> On Thu, 2015-07-02 at 20:40 +0200, Nicolas George wrote:
> > Hi.
> > 
> > Tyler Yeomans:
> > > I was able to recompile the distribution kernel after a long wait, and with
> > > the changes that were made I was able to get some semblance of an audio
> > > device registered.
> > > 
> > > I've attached the dmesg.
> > > 
> > > $ aplay -l
> > > **** List of PLAYBACK Hardware Devices ****
> > > card 0: bytrt5640 [byt-rt5640], device 0: Audio rt5640-aif1-0 []
> > >   Subdevices: 1/1
> > >   Subdevice #0: subdevice #0
> > > 
> 
> Can you try the bytcr_rt5640 machine driver as the byt-rt5640 machine
> driver will be getting deprecated (since it only works with a small
> number of FWs). The bytcr_rt5640 driver works with a wider range of FW.
> 

When testing the bytcr_rt5640 machine driver give also a try to the
latest firmwares:

https://git.kernel.org/cgit/linux/kernel/git/vkoul/firmware.git/tree/intel?h=byt

I had some success with fw_sst_0f28_ssp0.bin

Ciao,
   Antonio

-- 
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?

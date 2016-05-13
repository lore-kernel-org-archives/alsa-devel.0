From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: WM5102 - Help to make baytrail machine driver work
Date: Fri, 13 May 2016 12:41:36 +0100
Message-ID: <20160513114136.GM1646@localhost.localdomain>
References: <CAJcYhpZU-6_AO_Gye1VttuvOP0Z2=wLuWGCOP7tBWc6DsuLU1g@mail.gmail.com>
 <20160505091122.GE1646@localhost.localdomain>
 <CAJcYhpbdr-3qBSdaLX-=MCSGX7VC0XGz6tKbzJ3K3RHeGMhs7g@mail.gmail.com>
 <CAJcYhpZ1NRUa_7nu5kT6yJ_NTbDxRtK5Uy0H1fxMBEHhvA1fxw@mail.gmail.com>
 <20160509142210.GH1646@localhost.localdomain>
 <CAJcYhpa8OrxyFxL1L4VQJL=WSEhrKhvfcdLeUj40Hb=N2kDUUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 529EC260526
 for <alsa-devel@alsa-project.org>; Fri, 13 May 2016 13:41:30 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CAJcYhpa8OrxyFxL1L4VQJL=WSEhrKhvfcdLeUj40Hb=N2kDUUQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Paulo Sergio <pstglia@gmail.com>
Cc: alsa-devel@alsa-project.org, Christian Hartmann <cornogle@googlemail.com>, vinod.koul@intel.com, broonie@opensource.wolfsonmicro.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, mika.westerberg@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On Thu, May 12, 2016 at 11:54:55PM -0300, Paulo Sergio wrote:
> Hi again
> 
> 2016-05-09 11:22 GMT-03:00 Charles Keepax <ckeepax@opensource.wolfsonmicro.com>:
> > 'HPOUT1R Input 1' 'Tone Generator 1'
> >
> > This will hook the right headphone channel up to the chips
> > internal 1k tone generator. Careful it will be loud, but its
> > a good check to make sure the clocks are all happy inside the
> > chip. If you hear that tone, I would say the CODEC side looks
> > happy, but let me know how you get on.
> 
> We tried, but unfortunatelly no tone when hooking the tone generator.
> Saved dmesg, logcat and alsa_amixer output in case you want to take a look [2]

Hmm... that is really odd, I would very much have expected that
to work or the FLL to have given us a lock timed out error, which
it didn't appear to be from your log.

Could perhaps send through a register dump of the CODEC whilst in
this state? You can do this through the regmap debugfs it would
be good to turn cache_bypass on as well whilst doing it to make
sure we capture the actual hardware status.

> 
> I'm still having this message on logcat:
> "out_write: error -1 - cannot prepare channel: Device or resource busy"
> which happens when trying to ioctl
> SNDRV_PCM_IOCTL_PREPARE to /dev/snd/pcmC0D0p
> 
> Maybe the problem is something wrong/missing on Machine Driver...
> Pierre said It would be good base the code on bytcr_5640...

Yeah this is pretty unlikely to be coming from the CODEC side.

Thanks,
Charles

From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: WM5102 - Help to make baytrail machine driver work
Date: Sun, 15 May 2016 11:13:08 +0100
Message-ID: <20160515101308.GN1646@localhost.localdomain>
References: <CAJcYhpZU-6_AO_Gye1VttuvOP0Z2=wLuWGCOP7tBWc6DsuLU1g@mail.gmail.com>
 <20160505091122.GE1646@localhost.localdomain>
 <CAJcYhpbdr-3qBSdaLX-=MCSGX7VC0XGz6tKbzJ3K3RHeGMhs7g@mail.gmail.com>
 <CAJcYhpZ1NRUa_7nu5kT6yJ_NTbDxRtK5Uy0H1fxMBEHhvA1fxw@mail.gmail.com>
 <20160509142210.GH1646@localhost.localdomain>
 <CAJcYhpa8OrxyFxL1L4VQJL=WSEhrKhvfcdLeUj40Hb=N2kDUUQ@mail.gmail.com>
 <20160513114136.GM1646@localhost.localdomain>
 <CAJcYhpYJcTE0qBwYAHtGF9tbNCKXAVaLP3RnS5CF5=Z1LBijmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 5B6CA2606B4
 for <alsa-devel@alsa-project.org>; Sun, 15 May 2016 12:13:04 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CAJcYhpYJcTE0qBwYAHtGF9tbNCKXAVaLP3RnS5CF5=Z1LBijmA@mail.gmail.com>
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

On Sat, May 14, 2016 at 08:14:57PM -0300, Paulo Sergio wrote:
> Hi Charles,
> 
> >> 2016-05-09 11:22 GMT-03:00 Charles Keepax <ckeepax@opensource.wolfsonmicro.com>:
> >> > 'HPOUT1R Input 1' 'Tone Generator 1'
> >> >
> >> > This will hook the right headphone channel up to the chips
> >> > internal 1k tone generator. Careful it will be loud, but its
> >> > a good check to make sure the clocks are all happy inside the
> >> > chip. If you hear that tone, I would say the CODEC side looks
> >> > happy, but let me know how you get on.
> >>
> >> We tried, but unfortunatelly no tone when hooking the tone generator.
> >> Saved dmesg, logcat and alsa_amixer output in case you want to take a look [2]
> >
> > Hmm... that is really odd, I would very much have expected that
> > to work or the FLL to have given us a lock timed out error, which
> > it didn't appear to be from your log.
> >
> > Could perhaps send through a register dump of the CODEC whilst in
> > this state? You can do this through the regmap debugfs it would
> > be good to turn cache_bypass on as well whilst doing it to make
> > sure we capture the actual hardware status.
> 
> Here's the link for info collected [1]. Got info from the following
> files while attempting to play audio, with cache_bypass set to "Y"
> and with 'HPOUT1R Input 1' hooked to 'Tone Generator 1':
> 
> name
> registers
> access
> range
> rbtree
> 
> Thanks again for your help!
> 
> [1] - https://drive.google.com/folderview?id=0BxO6THtB865fSUZ3MDdFYktHanc&usp=sharing

That is a bit of a head scratcher, everything looks setup
correctly in the register map, tone gen goes to the output
everything is unmuted, everything is turned on. Even the IRQ
registers definitely show that the FLL locked. I can only really
think of a couple of options:

1) Probably the most likely option is that the clock to the FLL
is being removed before you are setting up your route. Probably a
reasonable thing to do next for test purposes would be to change
the machine driver to use the 32k clock that should be on MCLK2
incase the high quality clock on MCLK1 is being removed and then
try again.

2) HPOUT1 is not the headphones, but this is exceptionally
unlikely but you could try the other HPOUT's just in case.

Thanks,
Charles

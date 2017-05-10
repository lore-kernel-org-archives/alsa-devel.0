From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: WM5102 - Help to make baytrail machine driver work
Date: Wed, 10 May 2017 09:21:23 +0100
Message-ID: <20170510082123.GK1594@localhost.localdomain>
References: <CAJcYhpa8OrxyFxL1L4VQJL=WSEhrKhvfcdLeUj40Hb=N2kDUUQ@mail.gmail.com>
 <20160513114136.GM1646@localhost.localdomain>
 <CAJcYhpYJcTE0qBwYAHtGF9tbNCKXAVaLP3RnS5CF5=Z1LBijmA@mail.gmail.com>
 <20160515101308.GN1646@localhost.localdomain>
 <CAJcYhpaFiDrMYmbS1cUWL=ix-L2crjnNekpCXjjdHVThwp2Xag@mail.gmail.com>
 <20170508082422.GJ1594@localhost.localdomain>
 <CAJcYhpb0amzyug01nN3TUWBFSgGWfZcfOVfMgV01rxgTnbNnHg@mail.gmail.com>
 <7c35cd21-35a4-726d-71b5-1ef9f096fbee@linux.intel.com>
 <CAJcYhpb9yOJjDwG6ZGEYFQTiLXtkHNgmVkmF2ssQp6QPOX0ueA@mail.gmail.com>
 <6615d589-9124-5f71-0d6d-e634caf2fdaa@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id DBE5F2667E7
 for <alsa-devel@alsa-project.org>; Wed, 10 May 2017 10:20:09 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <6615d589-9124-5f71-0d6d-e634caf2fdaa@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: vinod.koul@intel.com, mika.westerberg@linux.intel.com, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, Paulo Sergio <pstglia@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Tue, May 09, 2017 at 09:57:14AM -0500, Pierre-Louis Bossart wrote:
> On 5/9/17 9:45 AM, Paulo Sergio wrote:
> >>>>How are you setting up the I2S? As in which side is master, what
> >>>>format are you using? Also do you see any over/underflow error,
> >>>>does the system complain with "Error playing sample".
> >>>
> >>>
> >>>The only part where I2S is explicity used on machine driver is this
> >>>setting on backend DAI (SSP0-Codec)
> >>>
> >>>dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
> >>>| SND_SOC_DAIFMT_CBS_CFS,
> >>>
> >>>And after setting the routes using routes mentioned on [3], I have no
> >>>errors, but no sound
> >>>
> >>>Note: Based on Lenovo code, I concluded this device uses ssp0, so I'm
> >>>using a fw file "fw_sst_0f28_ssp0.bin" posted another thread.
> >>>Could use the hacks used on kernel 4.11, but as I'm still testing with
> >>>kernel 4.4, using this fw would make things easier
> >>
> >>
> >>nope. I don't know how many issues we've fixed since 4.4 but it's not a
> >>matter of just swapping out one firmware with another. You'll have better
> >>luck with plain vanilla 4.11 + regular firmware and restarting modifying one
> >>of the latest machine drivers.
> >
> >Ok, I'll use 4.11 and post the results later
> >
> >Should I have any special care about I2S other than setting the format
> >um backend DAI?
> >Some module should be loaded?
> 
> Things to look for
> - SSP routing: has to be SSP0 on baytrail-CR
> - number of slots: 2 or 4. if 4 then use DSP mode
> - DAI format
> - MCLK
> 
> If I can get my hands on a WM5102 eval board I might be able to help with a
> MinnowMax board.

If you really want one I can ask about see if we can send you one
over?

Thanks,
Charles

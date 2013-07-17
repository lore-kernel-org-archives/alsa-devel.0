From: "Wang, Xingchao" <xingchao.wang@intel.com>
Subject: Re: [Intel-gfx] [PATCH 0/4 V7] Power-well API
 implementation for Haswell
Date: Wed, 17 Jul 2013 23:17:39 +0000
Message-ID: <46B810F6945F7C4788E11DCE57EC48901184E321@SHSMSX104.ccr.corp.intel.com>
References: <1369922831-727-1-git-send-email-xingchao.wang@linux.intel.com>
 <20130606153441.GI7827@phenom.ffwll.local>
 <CA+gsUGSBf5hit=fmjcrcy=fKJPNaFe02VkkM_=pYkVUwVyvG2Q@mail.gmail.com>
 <20130704082314.GA2393@wxc-intel>
 <CA+gsUGR+xOEa5b7XnTWWwRYyyVxO6hNAVv6EJXAvtKUfuabb1w@mail.gmail.com>
 <20130704131330.GD2393@wxc-intel>
 <CA+gsUGRVkeArxvFPFH0=MfZH6M6-VTpu8L4fbGkfoTRaB7oX0w@mail.gmail.com>
 <s5hd2qww6no.wl%tiwai@suse.de>
 <46B810F6945F7C4788E11DCE57EC48901184D8BF@SHSMSX104.ccr.corp.intel.com>
 <s5h38rdmyh0.wl%tiwai@suse.de>
 <46B810F6945F7C4788E11DCE57EC48901184DB13@SHSMSX104.ccr.corp.intel.com>
 <s5hwqoplhv4.wl%tiwai@suse.de>
 <46B810F6945F7C4788E11DCE57EC48901184DB3D@SHSMSX104.ccr.corp.intel.com>
 <CA+gsUGTCimKS35XaX7V+aWXtmGBeHS2ftChU5ndzsray5Aipuw@mail.gmail.com>
 <s5hwqopthff.wl%tiwai@suse.de>	<51E6A4B7.7060605@canonical.com>
 <s5hsizdtgg8.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id 15C1C26553A
 for <alsa-devel@alsa-project.org>; Thu, 18 Jul 2013 01:17:45 +0200 (CEST)
In-Reply-To: <s5hsizdtgg8.wl%tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, David Henningsson <david.henningsson@canonical.com>, Paulo Zanoni <przanoni@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Daniel Vetter <daniel@ffwll.ch>, "daniel.vetter@ffwll.ch" <daniel.vetter@ffwll.ch>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, Wang xingchao <xingchao.wang@linux.intel.com>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>, "Jin, Gordon" <gordon.jin@intel.com>
List-Id: alsa-devel@alsa-project.org



> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Wednesday, July 17, 2013 10:22 PM
> To: David Henningsson
> Cc: Paulo Zanoni; Wang, Xingchao; alsa-devel@alsa-project.org; Daniel Vetter;
> daniel.vetter@ffwll.ch; intel-gfx@lists.freedesktop.org; Wang xingchao;
> Girdwood, Liam R; Jin, Gordon
> Subject: Re: [alsa-devel] [Intel-gfx] [PATCH 0/4 V7] Power-well API
> implementation for Haswell
> 
> At Wed, 17 Jul 2013 16:05:43 +0200,
> David Henningsson wrote:
> >
> > On 07/17/2013 04:00 PM, Takashi Iwai wrote:
> > > At Wed, 17 Jul 2013 10:31:26 -0300,
> > > Paulo Zanoni wrote:
> > >>
> > >> 2013/7/17 Wang, Xingchao <xingchao.wang@intel.com>:
> > >>>
> > >>>
> > >>>> -----Original Message-----
> > >>>> From: Takashi Iwai [mailto:tiwai@suse.de]
> > >>>> Sent: Wednesday, July 17, 2013 4:18 PM
> > >>>> To: Wang, Xingchao
> > >>>> Cc: Paulo Zanoni; alsa-devel@alsa-project.org; Daniel Vetter;
> > >>>> daniel.vetter@ffwll.ch; intel-gfx@lists.freedesktop.org; Wang
> > >>>> xingchao; Girdwood, Liam R; david.henningsson@canonical.com
> > >>>> Subject: Re: [alsa-devel] [Intel-gfx] [PATCH 0/4 V7] Power-well
> > >>>> API implementation for Haswell
> > >>>>
> > >>>> At Wed, 17 Jul 2013 08:03:38 +0000, Wang, Xingchao wrote:
> > >>>>>
> > >>>>>
> > >>>>>
> > >>>>>> -----Original Message-----
> > >>>>>> From: Takashi Iwai [mailto:tiwai@suse.de]
> > >>>>>> Sent: Wednesday, July 17, 2013 3:34 PM
> > >>>>>> To: Wang, Xingchao
> > >>>>>> Cc: Paulo Zanoni; alsa-devel@alsa-project.org; Daniel Vetter;
> > >>>>>> daniel.vetter@ffwll.ch; intel-gfx@lists.freedesktop.org; Wang
> > >>>>>> xingchao; Girdwood, Liam R; david.henningsson@canonical.com
> > >>>>>> Subject: Re: [alsa-devel] [Intel-gfx] [PATCH 0/4 V7] Power-well
> > >>>>>> API implementation for Haswell
> > >>>>>>
> > >>>>>> At Wed, 17 Jul 2013 02:52:41 +0000, Wang, Xingchao wrote:
> > >>>>>>>
> > >>>>>>> Hi Takashi/Paulo,
> > >>>>>>>
> > >>>>>>>>>> would you change it to "auto" and test again.
> > >>>>>>>>>> Runtime power save should be enabled with "auto".
> > >>>>>>>>>
> > >>>>>>>>> Doesn't solve the problem. Should I open a bug report
> somewhere?
> > >>>>>>>>> Having the power well enabled prevents some power saving
> > >>>>>>>>> features from the graphics driver.
> > >>>>>>>>
> > >>>>>>>> Is the HD-audio power-saving itself working?  You can check
> > >>>>>>>> it via watching /sys/class/hwC*/power_{on|off}_acct files.
> > >>>>>>>>
> > >>>>>>>> power_save option has to be adjusted appropriately.  Note
> > >>>>>>>> that many DEs change this value dynamically per AC-cable
> > >>>>>>>> plug/unplug depending on the configuration, and often it's
> > >>>>>>>> set to 0 (= no power save) when AC-cable is plugged.
> > >>>>>>>>
> > >>>>>>> [Wang, Xingchao] Paulo used a new Ultrabook board with charger
> > >>>>>>> connected,
> > >>>>>> and see the default parameter "auto=on".
> > >>>>>>> In such scenario, power-well is always occupied by Display
> > >>>>>>> audio controller. Moreover, in this board, if no external
> > >>>>>>> monitors connected, It's
> > >>>>>> using internal eDP and totally no audio support. Power-well
> > >>>>>> usage in such case also blocks some eDP features as Paulo told me.
> > >>>>>>>
> > >>>>>>> So I think it's not a good idea to break the rule of power
> > >>>>>>> policy when charger
> > >>>>>> connected but it's necessary to add support in this particular case.
> > >>>>>>> Takashi, do you think it's acceptable to let Display audio
> > >>>>>>> controller/codec
> > >>>>>> suspend in such case?
> > >>>>>>
> > >>>>>> Do you mean the driver enables the powersave forcibly?
> > >>>>>
> > >>>>> Yes. I mean call pm_runtime_allow() for the power-well HD-A
> controller.
> > >>>>>
> > >>>>>> Then, no, not in general.
> > >>>>>>
> > >>>>>> If the default parameter of autopm is the problem, this should
> > >>>>>> be changed, instead of forcing the policy in the driver.
> > >>>>>>
> > >>>>>> OTOH, the audio codec's powersave policy is governed by the
> > >>>>>> power_save option and it's set up dynamically by the desktop system.
> > >>>>>> We shouldn't override it in the driver.
> > >>>>>>
> > >>>>>> If the power well *must* be off when only an eDP is used (e.g.
> > >>>>>> otherwise the hardware doesn't work properly), then it's a
> > >>>>>> different story.  Is it the case?   And what exactly would be the
> > >>>>>> problem?
> > >>>>> In the eDP only case, no audio is needed for the HD-A
> > >>>>> controller, so it's
> > >>>> wasting power in current design.
> > >>>>> I think Paulo or Daniel could explain more details on the impact.
> > >>>>
> > >>>> Consuming more power is the expected behavior.  What else?
> > >>>>
> > >>>>
> > >>>>>> If it's the case, controlling the power well based on the
> > >>>>>> runtime PM is likely a bad design, as it relies on the parameter user
> sets.
> > >>>>>> (And remember that the power-saving of the audio can be
> > >>>>>> disabled completely via Kconfig, too.)
> > >>>>>  From audio controller's point of view, if it's asked be active,
> > >>>>> it needs power
> > >>>> and should request power-well from gfx side.
> > >>>>> In above case, audio controller should not be active but user
> > >>>>> set it be
> > >>>> "active".
> > >>>>
> > >>>> By setting the autopm "on", user expects that no runtime PM happens.
> > >>>> In other words, the audio controller must be kept active as long
> > >>>> as this parameter is set.  And this is the parameter user
> > >>>> controls, and not what the driver forcibly sets.
> > >>>
> > >>> Okay, become clear now. :)
> > >>> So I think the conflict for Paulo becomes, in eDP caes, if audio is active
> and requested power-well, some eDP feature was under impact?
> > >>> Paulo, would you clarify this in more details?
> > >>
> > >> On our driver we try to disable the power well whenever possible,
> > >> as soon as possible. We don't change our behavior based on power AC
> > >> or other user-space modifiable behavior (except the
> > >> i915.disable_power_well Kernel option). If the power well is not
> > >> disabled we can't enable some features, like PSR (panel self
> > >> refresh, and eDP feature) or PC8, which is another power-saving
> > >> feature. This will also make our QA procedures a lot more complex
> > >> since when we want to test specific features (e.g., PSR, PC8) we'll
> > >> have to disconnect the AC adapter or run scripts. So the
> > >> behavior/predictability of our driver will be based on the Audio driver
> power management policies.
> > >
> > > So all missing feature are about the power saving?
> > >
> > >> I am not so experienced with general Linux Power Management code,
> > >> so maybe the way the Audio driver is behaving is just the usual
> > >> way, but I have to admit I was expecting the audio driver would
> > >> only require the power well when it is actually needed, and release
> > >> it as soon as possible.
> > >
> > > It would behave so, if all setups are for power-saving.
> > >
> > > But, in your case, the runtime PM control attribute shows "on"; it
> > > implies that the runtime PM is effectively disabled, thus disabling
> > > power well is also impossible (because it would require turning off
> > > the audio controller, too).
> >
> > So, if the machine only has an eDP (which has no audio function in
> > itself, right?) and never HDMI, DP output because there are no such
> > physical ports, the audio controller has no function.
> > Maybe we can, before doing anything else, ask the video driver first
> > if this is the case, and if so, never create the sound card at all,
> > and just leave things the way the video driver wants?
> 
> Well, doesn't BIOS mark HDMI/DP audio pins as unused?  Then the audio
> driver won't create any instances.  Of course, we can optimize such a case,
> indeed.

As I know, the eDP only case doesnot mean no HDMI/DP support. User would plug in HDMI/DP monitor at any time.
So diable audio controller totoally is not a good idea. :(.
Paulo, is that correct for you case? 

--xingchao
> 
> 
> Takashi

From: Paulo Zanoni <przanoni@gmail.com>
Subject: Re: [alsa-devel] [PATCH 0/4 V7] Power-well API
 implementation for Haswell
Date: Wed, 17 Jul 2013 10:31:26 -0300
Message-ID: <CA+gsUGTCimKS35XaX7V+aWXtmGBeHS2ftChU5ndzsray5Aipuw@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org>
In-Reply-To: <46B810F6945F7C4788E11DCE57EC48901184DB3D@SHSMSX104.ccr.corp.intel.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
Errors-To: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
To: "Wang, Xingchao" <xingchao.wang@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Girdwood,
	Liam R" <liam.r.girdwood@intel.com>, Takashi Iwai <tiwai@suse.de>, "daniel.vetter@ffwll.ch" <daniel.vetter@ffwll.ch>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, Wang xingchao <xingchao.wang@linux.intel.com>, "david.henningsson@canonical.com" <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

2013/7/17 Wang, Xingchao <xingchao.wang@intel.com>:
>
>
>> -----Original Message-----
>> From: Takashi Iwai [mailto:tiwai@suse.de]
>> Sent: Wednesday, July 17, 2013 4:18 PM
>> To: Wang, Xingchao
>> Cc: Paulo Zanoni; alsa-devel@alsa-project.org; Daniel Vetter;
>> daniel.vetter@ffwll.ch; intel-gfx@lists.freedesktop.org; Wang xingchao;
>> Girdwood, Liam R; david.henningsson@canonical.com
>> Subject: Re: [alsa-devel] [Intel-gfx] [PATCH 0/4 V7] Power-well API
>> implementation for Haswell
>>
>> At Wed, 17 Jul 2013 08:03:38 +0000,
>> Wang, Xingchao wrote:
>> >
>> >
>> >
>> > > -----Original Message-----
>> > > From: Takashi Iwai [mailto:tiwai@suse.de]
>> > > Sent: Wednesday, July 17, 2013 3:34 PM
>> > > To: Wang, Xingchao
>> > > Cc: Paulo Zanoni; alsa-devel@alsa-project.org; Daniel Vetter;
>> > > daniel.vetter@ffwll.ch; intel-gfx@lists.freedesktop.org; Wang
>> > > xingchao; Girdwood, Liam R; david.henningsson@canonical.com
>> > > Subject: Re: [alsa-devel] [Intel-gfx] [PATCH 0/4 V7] Power-well API
>> > > implementation for Haswell
>> > >
>> > > At Wed, 17 Jul 2013 02:52:41 +0000,
>> > > Wang, Xingchao wrote:
>> > > >
>> > > > Hi Takashi/Paulo,
>> > > >
>> > > > > > > would you change it to "auto" and test again.
>> > > > > > > Runtime power save should be enabled with "auto".
>> > > > > >
>> > > > > > Doesn't solve the problem. Should I open a bug report somewhere?
>> > > > > > Having the power well enabled prevents some power saving
>> > > > > > features from the graphics driver.
>> > > > >
>> > > > > Is the HD-audio power-saving itself working?  You can check it
>> > > > > via watching /sys/class/hwC*/power_{on|off}_acct files.
>> > > > >
>> > > > > power_save option has to be adjusted appropriately.  Note that
>> > > > > many DEs change this value dynamically per AC-cable plug/unplug
>> > > > > depending on the configuration, and often it's set to 0 (= no
>> > > > > power save) when AC-cable is plugged.
>> > > > >
>> > > > [Wang, Xingchao] Paulo used a new Ultrabook board with charger
>> > > > connected,
>> > > and see the default parameter "auto=on".
>> > > > In such scenario, power-well is always occupied by Display audio
>> > > > controller. Moreover, in this board, if no external monitors
>> > > > connected, It's
>> > > using internal eDP and totally no audio support. Power-well usage in
>> > > such case also blocks some eDP features as Paulo told me.
>> > > >
>> > > > So I think it's not a good idea to break the rule of power policy
>> > > > when charger
>> > > connected but it's necessary to add support in this particular case.
>> > > > Takashi, do you think it's acceptable to let Display audio
>> > > > controller/codec
>> > > suspend in such case?
>> > >
>> > > Do you mean the driver enables the powersave forcibly?
>> >
>> > Yes. I mean call pm_runtime_allow() for the power-well HD-A controller.
>> >
>> > > Then, no, not in general.
>> > >
>> > > If the default parameter of autopm is the problem, this should be
>> > > changed, instead of forcing the policy in the driver.
>> > >
>> > > OTOH, the audio codec's powersave policy is governed by the
>> > > power_save option and it's set up dynamically by the desktop system.
>> > > We shouldn't override it in the driver.
>> > >
>> > > If the power well *must* be off when only an eDP is used (e.g.
>> > > otherwise the hardware doesn't work properly), then it's a
>> > > different story.  Is it the case?   And what exactly would be the
>> > > problem?
>> > In the eDP only case, no audio is needed for the HD-A controller, so it's
>> wasting power in current design.
>> > I think Paulo or Daniel could explain more details on the impact.
>>
>> Consuming more power is the expected behavior.  What else?
>>
>>
>> > > If it's the case, controlling the power well based on the runtime PM
>> > > is likely a bad design, as it relies on the parameter user sets.
>> > > (And remember that the power-saving of the audio can be disabled
>> > > completely via Kconfig, too.)
>> > From audio controller's point of view, if it's asked be active, it needs power
>> and should request power-well from gfx side.
>> > In above case, audio controller should not be active but user set it be
>> "active".
>>
>> By setting the autopm "on", user expects that no runtime PM happens.
>> In other words, the audio controller must be kept active as long as this
>> parameter is set.  And this is the parameter user controls, and not what the
>> driver forcibly sets.
>
> Okay, become clear now. :)
> So I think the conflict for Paulo becomes, in eDP caes, if audio is active and requested power-well, some eDP feature was under impact?
> Paulo, would you clarify this in more details?

On our driver we try to disable the power well whenever possible, as
soon as possible. We don't change our behavior based on power AC or
other user-space modifiable behavior (except the
i915.disable_power_well Kernel option). If the power well is not
disabled we can't enable some features, like PSR (panel self refresh,
and eDP feature) or PC8, which is another power-saving feature. This
will also make our QA procedures a lot more complex since when we want
to test specific features (e.g., PSR, PC8) we'll have to disconnect
the AC adapter or run scripts. So the behavior/predictability of our
driver will be based on the Audio driver power management policies.

I am not so experienced with general Linux Power Management code, so
maybe the way the Audio driver is behaving is just the usual way, but
I have to admit I was expecting the audio driver would only require
the power well when it is actually needed, and release it as soon as
possible.

>
> thanks
> --xingchao
>>
>>
>> Takashi



-- 
Paulo Zanoni

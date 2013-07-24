From: "Wang, Xingchao" <xingchao.wang@intel.com>
Subject: Re: [Intel-gfx] [PATCH 0/4 V7] Power-well API
 implementation for Haswell
Date: Wed, 24 Jul 2013 10:31:22 +0000
Message-ID: <46B810F6945F7C4788E11DCE57EC489011851134@SHSMSX104.ccr.corp.intel.com>
References: <46B810F6945F7C4788E11DCE57EC48901184D8BF@SHSMSX104.ccr.corp.intel.com>
 <s5h38rdmyh0.wl%tiwai@suse.de>
 <46B810F6945F7C4788E11DCE57EC48901184DB13@SHSMSX104.ccr.corp.intel.com>
 <s5hwqoplhv4.wl%tiwai@suse.de>
 <46B810F6945F7C4788E11DCE57EC48901184DB3D@SHSMSX104.ccr.corp.intel.com>
 <CA+gsUGTCimKS35XaX7V+aWXtmGBeHS2ftChU5ndzsray5Aipuw@mail.gmail.com>
 <s5hwqopthff.wl%tiwai@suse.de>	<51E6A4B7.7060605@canonical.com>
 <s5hsizdtgg8.wl%tiwai@suse.de>
 <46B810F6945F7C4788E11DCE57EC48901184E3B6@SHSMSX104.ccr.corp.intel.com>
 <20130718064415.GH4550@phenom.ffwll.local>
 <46B810F6945F7C4788E11DCE57EC48901184E58D@SHSMSX104.ccr.corp.intel.com>
 <s5h61w8tdnb.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="_002_46B810F6945F7C4788E11DCE57EC489011851134SHSMSX104ccrcor_"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
 by alsa0.perex.cz (Postfix) with ESMTP id E3BA1265251
 for <alsa-devel@alsa-project.org>; Wed, 24 Jul 2013 12:31:29 +0200 (CEST)
In-Reply-To: <s5h61w8tdnb.wl%tiwai@suse.de>
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
To: Paulo Zanoni <przanoni@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Daniel Vetter <daniel@ffwll.ch>, Takashi Iwai <tiwai@suse.de>, "daniel.vetter@ffwll.ch" <daniel.vetter@ffwll.ch>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "Wang,
 Xingchao" <xingchao.wang@intel.com>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>, "Jin, Gordon" <gordon.jin@intel.com>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

--_002_46B810F6945F7C4788E11DCE57EC489011851134SHSMSX104ccrcor_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Paulo,

Would you help verify attached patch to fix this issue for you?

The patch is based on Takashi's tree, the last commit is:
commit 9b298cfe296c0f8e088b9ed9a670783a06005e6b
I think it should be safe to merge into your tree. :)

I tested the patch on Harris Beach, it would let audio driver release power=
-well even with charger connected.

Please note maybe this is not the final solution for this issue as it break=
s some rule from user's point of view.

Some background of this issue:
This patch intended to fix power-well regression on Haswell.

On Harris Beach(Ultrabook with battery), there's only eDP panel connected b=
y default, no HDMI/DP.
And gfx driver needs enable some HW feature for eDP, power-well *must* be
disabled in this scenario.
- Witout charger connected, power-well feature is perfect
- with charger connected, audio never release power-well.

Basically, power-well should be release if audio driver doesnot use it, tha=
t's
why we enabled runtime power-save feature.

In second case above, with charger connected, the parameter under
"/sys/devices/../power/control" become "on" always.
In audio driver side, power_save was set to "0", which disable power_down t=
he
codecs and controller, thus never release power->usage_count.

And this blocks audio driver release power-well.

In the second case, if audio driver detect hdmi pins are free and no Apps
opened device, it will eanble runtime power-save feature as an exception.

I test this patch on Harris beach with charger connected, the power-well co=
uld
be released as expected.

Thanks
--xingchao

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Thursday, July 18, 2013 5:35 PM
> To: Wang, Xingchao
> Cc: Daniel Vetter; Paulo Zanoni; daniel.vetter@ffwll.ch;
> alsa-devel@alsa-project.org; intel-gfx@lists.freedesktop.org; Wang xingch=
ao;
> Girdwood, Liam R; Jin, Gordon; David Henningsson
> Subject: Re: [alsa-devel] [Intel-gfx] [PATCH 0/4 V7] Power-well API
> implementation for Haswell
>=20
> At Thu, 18 Jul 2013 09:23:57 +0000,
> Wang, Xingchao wrote:
> >
> >
> >
> > > -----Original Message-----
> > > From: Daniel Vetter [mailto:daniel.vetter@ffwll.ch] On Behalf Of
> > > Daniel Vetter
> > > Sent: Thursday, July 18, 2013 2:44 PM
> > > To: Wang, Xingchao
> > > Cc: Paulo Zanoni; daniel.vetter@ffwll.ch;
> > > alsa-devel@alsa-project.org; Daniel Vetter;
> > > intel-gfx@lists.freedesktop.org; Wang xingchao; Girdwood, Liam R;
> > > Jin, Gordon; Takashi Iwai; David Henningsson
> > > Subject: Re: [alsa-devel] [Intel-gfx] [PATCH 0/4 V7] Power-well API
> > > implementation for Haswell
> > >
> > > On Thu, Jul 18, 2013 at 01:00:07AM +0000, Wang, Xingchao wrote:
> > > > Hi Paulo/Daniel,
> > > >
> > > > Do you agree to export an API in gfx side for eDP case?
> > > > Basically the api will let audio drver know which pipe in use.
> > > > i.e. in the eDP only caes, audio driver Will know gfx is not using
> > > > HDMI/DP and would
> > > like to let power-well off.
> > > > As there's the conflict when user expect display audio driver
> > > > always active but
> > > gfx need audio driver off.
> > > > Audio driver could make decision to release power-well if it knows
> > > > the eDP
> > > only case through the API.
> > > >
> > > > OTOH, I think audio driver could also export an API for gfx side,
> > > > if gfx driver need audio driver release power-well but it's in
> > > > usage, It will call
> > > this API and audio drvier will release power-well accordingly.
> > > >
> > > > This change make HDMI/DP hotplug handling complicated in audio
> > > > driver side,
> > > if audio driver release power-well, it would enter suspend mode.
> > > > Meanwhile the user may expect it's in active mode, this may cause
> > > > some
> > > confuse.
> > >
> > > Afaik (and I know very little about audio) the audio side already
> > > knows which pipes have audio enabled, since we set the respective bit=
 only
> when it's needed.
> > > And audio will receive the unsolicited even interrupt (or whatever
> > > it's called) when this happens.
> > >
> > For haswell, Audio driver can get DDI port/Pin usage information accord=
ing to
> the unsolicited event, not Pipe info.
> > However at this stage, seems only that is enough: if no pin has valid E=
LD,
> audio driver can think about that no monitor connected with DDI ports.
> > In this case, Audio driver could release power-well and enter suspend
> > mode automatically, this avoid blocking eDP feature enabling. And once =
gfx
> dirver Detect external monitor connected, it will also wake up audio driv=
er.
> >
> > Takashi, do you think this solution acceptable?
>=20
> It's the current situation, isn't it?  So the question is only whether th=
is works
> _as expected_.
>=20
> Basically system/user needs to set up two parameters for the audio
> power-saving.  If both are set well, but it still doesn't work, we need t=
o debug.
>=20
> Of course, we can improve things, for example, the default runtime PM set=
up.
> (Note that this is about the default value, not the value force to set.)
>=20
>=20
> Takashi
>=20
> >
> > Thanks
> > --xingchao
> >
> > > So I think we already have the means (albeit with that quirky hw
> > > interface, but it seems to have been good enough for a long time
> > > already) to do that. Or do I miss something?
> > > -Daniel
> > >
> > > >
> > > > Thanks
> > > > --xingchao
> > > >
> > > > > -----Original Message-----
> > > > > From: Wang, Xingchao
> > > > > Sent: Thursday, July 18, 2013 7:18 AM
> > > > > To: 'Takashi Iwai'; David Henningsson; Paulo Zanoni
> > > > > Cc: alsa-devel@alsa-project.org; Daniel Vetter;
> > > > > daniel.vetter@ffwll.ch; intel-gfx@lists.freedesktop.org; Wang
> > > > > xingchao; Girdwood, Liam R; Jin, Gordon
> > > > > Subject: RE: [alsa-devel] [Intel-gfx] [PATCH 0/4 V7] Power-well
> > > > > API implementation for Haswell
> > > > >
> > > > >
> > > > >
> > > > > > -----Original Message-----
> > > > > > From: Takashi Iwai [mailto:tiwai@suse.de]
> > > > > > Sent: Wednesday, July 17, 2013 10:22 PM
> > > > > > To: David Henningsson
> > > > > > Cc: Paulo Zanoni; Wang, Xingchao; alsa-devel@alsa-project.org;
> > > > > > Daniel Vetter; daniel.vetter@ffwll.ch;
> > > > > > intel-gfx@lists.freedesktop.org; Wang xingchao; Girdwood, Liam
> > > > > > R; Jin, Gordon
> > > > > > Subject: Re: [alsa-devel] [Intel-gfx] [PATCH 0/4 V7]
> > > > > > Power-well API implementation for Haswell
> > > > > >
> > > > > > At Wed, 17 Jul 2013 16:05:43 +0200, David Henningsson wrote:
> > > > > > >
> > > > > > > On 07/17/2013 04:00 PM, Takashi Iwai wrote:
> > > > > > > > At Wed, 17 Jul 2013 10:31:26 -0300, Paulo Zanoni wrote:
> > > > > > > >>
> > > > > > > >> 2013/7/17 Wang, Xingchao <xingchao.wang@intel.com>:
> > > > > > > >>>
> > > > > > > >>>
> > > > > > > >>>> -----Original Message-----
> > > > > > > >>>> From: Takashi Iwai [mailto:tiwai@suse.de]
> > > > > > > >>>> Sent: Wednesday, July 17, 2013 4:18 PM
> > > > > > > >>>> To: Wang, Xingchao
> > > > > > > >>>> Cc: Paulo Zanoni; alsa-devel@alsa-project.org; Daniel
> > > > > > > >>>> Vetter; daniel.vetter@ffwll.ch;
> > > > > > > >>>> intel-gfx@lists.freedesktop.org; Wang xingchao;
> > > > > > > >>>> Girdwood, Liam R; david.henningsson@canonical.com
> > > > > > > >>>> Subject: Re: [alsa-devel] [Intel-gfx] [PATCH 0/4 V7]
> > > > > > > >>>> Power-well API implementation for Haswell
> > > > > > > >>>>
> > > > > > > >>>> At Wed, 17 Jul 2013 08:03:38 +0000, Wang, Xingchao wrote=
:
> > > > > > > >>>>>
> > > > > > > >>>>>
> > > > > > > >>>>>
> > > > > > > >>>>>> -----Original Message-----
> > > > > > > >>>>>> From: Takashi Iwai [mailto:tiwai@suse.de]
> > > > > > > >>>>>> Sent: Wednesday, July 17, 2013 3:34 PM
> > > > > > > >>>>>> To: Wang, Xingchao
> > > > > > > >>>>>> Cc: Paulo Zanoni; alsa-devel@alsa-project.org; Daniel
> > > > > > > >>>>>> Vetter; daniel.vetter@ffwll.ch;
> > > > > > > >>>>>> intel-gfx@lists.freedesktop.org; Wang xingchao;
> > > > > > > >>>>>> Girdwood, Liam R; david.henningsson@canonical.com
> > > > > > > >>>>>> Subject: Re: [alsa-devel] [Intel-gfx] [PATCH 0/4 V7]
> > > > > > > >>>>>> Power-well API implementation for Haswell
> > > > > > > >>>>>>
> > > > > > > >>>>>> At Wed, 17 Jul 2013 02:52:41 +0000, Wang, Xingchao wro=
te:
> > > > > > > >>>>>>>
> > > > > > > >>>>>>> Hi Takashi/Paulo,
> > > > > > > >>>>>>>
> > > > > > > >>>>>>>>>> would you change it to "auto" and test again.
> > > > > > > >>>>>>>>>> Runtime power save should be enabled with "auto".
> > > > > > > >>>>>>>>>
> > > > > > > >>>>>>>>> Doesn't solve the problem. Should I open a bug
> > > > > > > >>>>>>>>> report
> > > > > > somewhere?
> > > > > > > >>>>>>>>> Having the power well enabled prevents some power
> > > > > > > >>>>>>>>> saving features from the graphics driver.
> > > > > > > >>>>>>>>
> > > > > > > >>>>>>>> Is the HD-audio power-saving itself working?  You
> > > > > > > >>>>>>>> can check it via watching
> > > > > > > >>>>>>>> /sys/class/hwC*/power_{on|off}_acct
> > > files.
> > > > > > > >>>>>>>>
> > > > > > > >>>>>>>> power_save option has to be adjusted appropriately.
> > > > > > > >>>>>>>> Note that many DEs change this value dynamically
> > > > > > > >>>>>>>> per AC-cable plug/unplug depending on the
> > > > > > > >>>>>>>> configuration, and often it's set to 0 (=3D no power
> > > > > > > >>>>>>>> save) when AC-cable is
> > > plugged.
> > > > > > > >>>>>>>>
> > > > > > > >>>>>>> [Wang, Xingchao] Paulo used a new Ultrabook board
> > > > > > > >>>>>>> with charger connected,
> > > > > > > >>>>>> and see the default parameter "auto=3Don".
> > > > > > > >>>>>>> In such scenario, power-well is always occupied by
> > > > > > > >>>>>>> Display audio controller. Moreover, in this board,
> > > > > > > >>>>>>> if no external monitors connected, It's
> > > > > > > >>>>>> using internal eDP and totally no audio support.
> > > > > > > >>>>>> Power-well usage in such case also blocks some eDP
> > > > > > > >>>>>> features as
> > > Paulo told me.
> > > > > > > >>>>>>>
> > > > > > > >>>>>>> So I think it's not a good idea to break the rule of
> > > > > > > >>>>>>> power policy when charger
> > > > > > > >>>>>> connected but it's necessary to add support in this
> > > > > > > >>>>>> particular
> > > case.
> > > > > > > >>>>>>> Takashi, do you think it's acceptable to let Display
> > > > > > > >>>>>>> audio controller/codec
> > > > > > > >>>>>> suspend in such case?
> > > > > > > >>>>>>
> > > > > > > >>>>>> Do you mean the driver enables the powersave forcibly?
> > > > > > > >>>>>
> > > > > > > >>>>> Yes. I mean call pm_runtime_allow() for the power-well
> > > > > > > >>>>> HD-A
> > > > > > controller.
> > > > > > > >>>>>
> > > > > > > >>>>>> Then, no, not in general.
> > > > > > > >>>>>>
> > > > > > > >>>>>> If the default parameter of autopm is the problem,
> > > > > > > >>>>>> this should be changed, instead of forcing the policy =
in the
> driver.
> > > > > > > >>>>>>
> > > > > > > >>>>>> OTOH, the audio codec's powersave policy is governed
> > > > > > > >>>>>> by the power_save option and it's set up dynamically
> > > > > > > >>>>>> by the desktop
> > > > > system.
> > > > > > > >>>>>> We shouldn't override it in the driver.
> > > > > > > >>>>>>
> > > > > > > >>>>>> If the power well *must* be off when only an eDP is us=
ed
> (e.g.
> > > > > > > >>>>>> otherwise the hardware doesn't work properly), then it=
's a
> > > > > > > >>>>>> different story.  Is it the case?   And what exactly w=
ould
> be
> > > the
> > > > > > > >>>>>> problem?
> > > > > > > >>>>> In the eDP only case, no audio is needed for the HD-A
> > > > > > > >>>>> controller, so it's
> > > > > > > >>>> wasting power in current design.
> > > > > > > >>>>> I think Paulo or Daniel could explain more details on t=
he
> impact.
> > > > > > > >>>>
> > > > > > > >>>> Consuming more power is the expected behavior.  What els=
e?
> > > > > > > >>>>
> > > > > > > >>>>
> > > > > > > >>>>>> If it's the case, controlling the power well based on
> > > > > > > >>>>>> the runtime PM is likely a bad design, as it relies
> > > > > > > >>>>>> on the parameter user
> > > > > > sets.
> > > > > > > >>>>>> (And remember that the power-saving of the audio can
> > > > > > > >>>>>> be disabled completely via Kconfig, too.)
> > > > > > > >>>>>  From audio controller's point of view, if it's asked
> > > > > > > >>>>> be active, it needs power
> > > > > > > >>>> and should request power-well from gfx side.
> > > > > > > >>>>> In above case, audio controller should not be active
> > > > > > > >>>>> but user set it be
> > > > > > > >>>> "active".
> > > > > > > >>>>
> > > > > > > >>>> By setting the autopm "on", user expects that no
> > > > > > > >>>> runtime PM
> > > > > happens.
> > > > > > > >>>> In other words, the audio controller must be kept
> > > > > > > >>>> active as long as this parameter is set.  And this is
> > > > > > > >>>> the parameter user controls, and not what the driver for=
cibly
> sets.
> > > > > > > >>>
> > > > > > > >>> Okay, become clear now. :) So I think the conflict for
> > > > > > > >>> Paulo becomes, in eDP caes, if audio is active
> > > > > > and requested power-well, some eDP feature was under impact?
> > > > > > > >>> Paulo, would you clarify this in more details?
> > > > > > > >>
> > > > > > > >> On our driver we try to disable the power well whenever
> > > > > > > >> possible, as soon as possible. We don't change our
> > > > > > > >> behavior based on power AC or other user-space modifiable
> > > > > > > >> behavior (except the i915.disable_power_well Kernel
> > > > > > > >> option). If the power well is not disabled we can't
> > > > > > > >> enable some features, like PSR (panel self refresh, and
> > > > > > > >> eDP feature) or PC8, which is another power-saving
> > > > > > > >> feature. This will also make our QA procedures a lot more
> > > > > > > >> complex since when we want to test specific features
> > > > > > > >> (e.g., PSR, PC8) we'll have to disconnect the AC adapter
> > > > > > > >> or run scripts. So the behavior/predictability of our
> > > > > > > >> driver will be based on the Audio driver
> > > > > > power management policies.
> > > > > > > >
> > > > > > > > So all missing feature are about the power saving?
> > > > > > > >
> > > > > > > >> I am not so experienced with general Linux Power
> > > > > > > >> Management code, so maybe the way the Audio driver is
> > > > > > > >> behaving is just the usual way, but I have to admit I was
> > > > > > > >> expecting the audio driver would only require the power
> > > > > > > >> well when it is actually needed, and release it as soon as=
 possible.
> > > > > > > >
> > > > > > > > It would behave so, if all setups are for power-saving.
> > > > > > > >
> > > > > > > > But, in your case, the runtime PM control attribute shows
> > > > > > > > "on"; it implies that the runtime PM is effectively
> > > > > > > > disabled, thus disabling power well is also impossible
> > > > > > > > (because it would require turning off the audio controller,=
 too).
> > > > > > >
> > > > > > > So, if the machine only has an eDP (which has no audio
> > > > > > > function in itself, right?) and never HDMI, DP output
> > > > > > > because there are no such physical ports, the audio controlle=
r has no
> function.
> > > > > > > Maybe we can, before doing anything else, ask the video
> > > > > > > driver first if this is the case, and if so, never create
> > > > > > > the sound card at all, and just leave things the way the vide=
o driver
> wants?
> > > > > >
> > > > > > Well, doesn't BIOS mark HDMI/DP audio pins as unused?  Then
> > > > > > the audio driver won't create any instances.  Of course, we
> > > > > > can optimize such a case, indeed.
> > > > >
> > > > > As I know, the eDP only case doesnot mean no HDMI/DP support.
> > > > > User would plug in HDMI/DP monitor at any time.
> > > > > So diable audio controller totoally is not a good idea. :(.
> > > > > Paulo, is that correct for you case?
> > > > >
> > > > > --xingchao
> > > > > >
> > > > > >
> > > > > > Takashi
> > >
> > > --
> > > Daniel Vetter
> > > Software Engineer, Intel Corporation
> > > +41 (0) 79 365 57 48 - http://blog.ffwll.ch
> >

--_002_46B810F6945F7C4788E11DCE57EC489011851134SHSMSX104ccrcor_
Content-Type: application/octet-stream;
	name="0001-ALSA-hda-Change-power-save-policy-for-power-well-reg.patch"
Content-Description: 0001-ALSA-hda-Change-power-save-policy-for-power-well-reg.patch
Content-Disposition: attachment;
	filename="0001-ALSA-hda-Change-power-save-policy-for-power-well-reg.patch";
	size=6902; creation-date="Wed, 24 Jul 2013 10:21:08 GMT";
	modification-date="Wed, 24 Jul 2013 09:51:48 GMT"
Content-Transfer-Encoding: base64

RnJvbSBiODMzNTVmZmQ2YmFiZWUwYTcxYzVjODkyYjE4NzJhNzYwMTY0M2UzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBXYW5nIFhpbmdjaGFvIDx4aW5nY2hhby53YW5nQGxpbnV4Lmlu
dGVsLmNvbT4KRGF0ZTogV2VkLCAyNCBKdWwgMjAxMyAxNzozODozMyArMDgwMApTdWJqZWN0OiBb
UEFUQ0ggUkZDXSBBTFNBOiBoZGEgLSBDaGFuZ2UgcG93ZXItc2F2ZSBwb2xpY3kgZm9yIHBvd2Vy
LXdlbGwKIHJlZ3Jlc3Npb24KClRoaXMgcGF0Y2ggaW50ZW5kZWQgdG8gZml4IHBvd2VyLXdlbGwg
cmVncmVzc2lvbiBvbiBIYXN3ZWxsLgoKT24gSGFycmlzIEJlYWNoKFVsdHJhYm9vayB3aXRoIGJh
dHRlcnkpLCB0aGVyZSdzIG9ubHkgZURQIHBhbmVsIGNvbm5lY3RlZCBieSBkZWZhdWx0LCBubyBI
RE1JL0RQLgpBbmQgZ2Z4IGRyaXZlciBuZWVkcyBlbmFibGUgc29tZSBIVyBmZWF0dXJlIGZvciBl
RFAsIHBvd2VyLXdlbGwgKm11c3QqIGJlCmRpc2FibGVkIGluIHRoaXMgc2NlbmFyaW8uCi0gV2l0
b3V0IGNoYXJnZXIgY29ubmVjdGVkLCBwb3dlci13ZWxsIGZlYXR1cmUgaXMgcGVyZmVjdAotIHdp
dGggY2hhcmdlciBjb25uZWN0ZWQsIGF1ZGlvIG5ldmVyIHJlbGVhc2UgcG93ZXItd2VsbC4KCkJh
c2ljYWxseSwgcG93ZXItd2VsbCBzaG91bGQgYmUgcmVsZWFzZSBpZiBhdWRpbyBkcml2ZXIgZG9l
c25vdCB1c2UgaXQsIHRoYXQncwp3aHkgd2UgZW5hYmxlZCBydW50aW1lIHBvd2VyLXNhdmUgZmVh
dHVyZS4KCkluIHNlY29uZCBjYXNlIGFib3ZlLCB3aXRoIGNoYXJnZXIgY29ubmVjdGVkLCB0aGUg
cGFyYW1ldGVyIHVuZGVyCiIvc3lzL2RldmljZXMvLi4vcG93ZXIvY29udHJvbCIgYmVjb21lICJv
biIgYWx3YXlzLgpJbiBhdWRpbyBkcml2ZXIgc2lkZSwgcG93ZXJfc2F2ZSB3YXMgc2V0IHRvICIw
Iiwgd2hpY2ggZGlzYWJsZSBwb3dlcl9kb3duIHRoZQpjb2RlY3MgYW5kIGNvbnRyb2xsZXIsIHRo
dXMgbmV2ZXIgcmVsZWFzZSBwb3dlci0+dXNhZ2VfY291bnQuCgpBbmQgdGhpcyBibG9ja3MgYXVk
aW8gZHJpdmVyIHJlbGVhc2UgcG93ZXItd2VsbC4KCkluIHRoZSBzZWNvbmQgY2FzZSwgaWYgYXVk
aW8gZHJpdmVyIGRldGVjdCBoZG1pIHBpbnMgYXJlIGZyZWUgYW5kIG5vIEFwcHMKb3BlbmVkIGRl
dmljZSwgaXQgd2lsbCBlYW5ibGUgcnVudGltZSBwb3dlci1zYXZlIGZlYXR1cmUgYXMgYW4gZXhj
ZXB0aW9uLgoKSSB0ZXN0IHRoaXMgcGF0Y2ggb24gSGFycmlzIGJlYWNoIHdpdGggY2hhcmdlciBj
b25uZWN0ZWQsIHRoZSBwb3dlci13ZWxsIGNvdWxkCmJlIHJlbGVhc2VkIGFzIGV4cGVjdGVkLgoK
U2lnbmVkLW9mZi1ieTogV2FuZyBYaW5nY2hhbyA8eGluZ2NoYW8ud2FuZ0BsaW51eC5pbnRlbC5j
b20+Ci0tLQogc291bmQvcGNpL2hkYS9oZGFfY29kZWMuaCAgfCAgICAxICsKIHNvdW5kL3BjaS9o
ZGEvaGRhX2ludGVsLmMgIHwgICA1NiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKwogc291bmQvcGNpL2hkYS9wYXRjaF9oZG1pLmMgfCAgIDMxICsrKysrKysrKysr
KysrKysrKysrKysrKwogMyBmaWxlcyBjaGFuZ2VkLCA4OCBpbnNlcnRpb25zKCspCgpkaWZmIC0t
Z2l0IGEvc291bmQvcGNpL2hkYS9oZGFfY29kZWMuaCBiL3NvdW5kL3BjaS9oZGEvaGRhX2NvZGVj
LmgKaW5kZXggNzAxYzJlMC4uN2EyMDMwZCAxMDA2NDQKLS0tIGEvc291bmQvcGNpL2hkYS9oZGFf
Y29kZWMuaAorKysgYi9zb3VuZC9wY2kvaGRhL2hkYV9jb2RlYy5oCkBAIC03MjYsNiArNzI2LDcg
QEAgc3RydWN0IGhkYV9jb2RlY19vcHMgewogCWludCAoKmNoZWNrX3Bvd2VyX3N0YXR1cykoc3Ry
dWN0IGhkYV9jb2RlYyAqY29kZWMsIGhkYV9uaWRfdCBuaWQpOwogI2VuZGlmCiAJdm9pZCAoKnJl
Ym9vdF9ub3RpZnkpKHN0cnVjdCBoZGFfY29kZWMgKmNvZGVjKTsKKwlib29sICgqY29kZWNfYnVz
eSkoc3RydWN0IGhkYV9jb2RlYyAqY29kZWMpOwogfTsKIAogLyogcmVjb3JkIGZvciBhbXAgaW5m
b3JtYXRpb24gY2FjaGUgKi8KZGlmZiAtLWdpdCBhL3NvdW5kL3BjaS9oZGEvaGRhX2ludGVsLmMg
Yi9zb3VuZC9wY2kvaGRhL2hkYV9pbnRlbC5jCmluZGV4IDg4NjBkZDUuLjY1YWZlMTEgMTAwNjQ0
Ci0tLSBhL3NvdW5kL3BjaS9oZGEvaGRhX2ludGVsLmMKKysrIGIvc291bmQvcGNpL2hkYS9oZGFf
aW50ZWwuYwpAQCAtNTQ0LDYgKzU0NCw3IEBAIHN0cnVjdCBhenggewogCiAjaWZkZWYgQ09ORklH
X1NORF9IREFfSTkxNQogCXN0cnVjdCB3b3JrX3N0cnVjdCBwcm9iZV93b3JrOworCXN0cnVjdCBk
ZWxheWVkX3dvcmsgcG93ZXJ3ZWxsX3dvcms7CiAjZW5kaWYKIAogCS8qIHJlYm9vdCBub3RpZmll
ciAoZm9yIG15c3RlcmlvdXMgaGFuZ3VwIHByb2JsZW0gYXQgcG93ZXItZG93bikgKi8KQEAgLTcz
OSw2ICs3NDAsNyBAQCBzdGF0aWMgaW5saW5lIHZvaWQgbWFya19ydW50aW1lX3djKHN0cnVjdCBh
enggKmNoaXAsIHN0cnVjdCBhenhfZGV2ICphenhfZGV2LAogCiBzdGF0aWMgaW50IGF6eF9hY3F1
aXJlX2lycShzdHJ1Y3QgYXp4ICpjaGlwLCBpbnQgZG9fZGlzY29ubmVjdCk7CiBzdGF0aWMgaW50
IGF6eF9zZW5kX2NtZChzdHJ1Y3QgaGRhX2J1cyAqYnVzLCB1bnNpZ25lZCBpbnQgdmFsKTsKK3N0
YXRpYyBpbnQgYXp4X3Bvd2VyX3NhdmVfdXBkYXRlKHN0cnVjdCBhenggKmNoaXApOwogLyoKICAq
IEludGVyZmFjZSBmb3IgSEQgY29kZWMKICAqLwpAQCAtMTk3OCw2ICsxOTgwLDcgQEAgc3RhdGlj
IGludCBhenhfcGNtX29wZW4oc3RydWN0IHNuZF9wY21fc3Vic3RyZWFtICpzdWJzdHJlYW0pCiAJ
c3RydWN0IGF6eF9wY20gKmFwY20gPSBzbmRfcGNtX3N1YnN0cmVhbV9jaGlwKHN1YnN0cmVhbSk7
CiAJc3RydWN0IGhkYV9wY21fc3RyZWFtICpoaW5mbyA9IGFwY20tPmhpbmZvW3N1YnN0cmVhbS0+
c3RyZWFtXTsKIAlzdHJ1Y3QgYXp4ICpjaGlwID0gYXBjbS0+Y2hpcDsKKwlzdHJ1Y3QgcGNpX2Rl
diAqcGNpID0gY2hpcC0+cGNpOwogCXN0cnVjdCBhenhfZGV2ICphenhfZGV2OwogCXN0cnVjdCBz
bmRfcGNtX3J1bnRpbWUgKnJ1bnRpbWUgPSBzdWJzdHJlYW0tPnJ1bnRpbWU7CiAJdW5zaWduZWQg
bG9uZyBmbGFnczsKQEAgLTIwNjQsOSArMjA2NywxMiBAQCBzdGF0aWMgaW50IGF6eF9wY21fY2xv
c2Uoc3RydWN0IHNuZF9wY21fc3Vic3RyZWFtICpzdWJzdHJlYW0pCiAJc3RydWN0IGF6eF9wY20g
KmFwY20gPSBzbmRfcGNtX3N1YnN0cmVhbV9jaGlwKHN1YnN0cmVhbSk7CiAJc3RydWN0IGhkYV9w
Y21fc3RyZWFtICpoaW5mbyA9IGFwY20tPmhpbmZvW3N1YnN0cmVhbS0+c3RyZWFtXTsKIAlzdHJ1
Y3QgYXp4ICpjaGlwID0gYXBjbS0+Y2hpcDsKKwlzdHJ1Y3QgcGNpX2RldiAqcGNpID0gY2hpcC0+
cGNpOwogCXN0cnVjdCBhenhfZGV2ICphenhfZGV2ID0gZ2V0X2F6eF9kZXYoc3Vic3RyZWFtKTsK
IAl1bnNpZ25lZCBsb25nIGZsYWdzOwogCisJaWYgKGNoaXAtPmRyaXZlcl9jYXBzICYgQVpYX0RD
QVBTX0k5MTVfUE9XRVJXRUxMKQorCQlhenhfcG93ZXJfc2F2ZV91cGRhdGUoY2hpcCk7CiAJbXV0
ZXhfbG9jaygmY2hpcC0+b3Blbl9tdXRleCk7CiAJc3Bpbl9sb2NrX2lycXNhdmUoJmNoaXAtPnJl
Z19sb2NrLCBmbGFncyk7CiAJYXp4X2Rldi0+c3Vic3RyZWFtID0gTlVMTDsKQEAgLTM0NDQsNiAr
MzQ1MCw1MiBAQCBzdGF0aWMgdm9pZCBhenhfcHJvYmVfd29yayhzdHJ1Y3Qgd29ya19zdHJ1Y3Qg
KndvcmspCiB7CiAJYXp4X3Byb2JlX2NvbnRpbnVlKGNvbnRhaW5lcl9vZih3b3JrLCBzdHJ1Y3Qg
YXp4LCBwcm9iZV93b3JrKSk7CiB9CisKK3N0YXRpYyBib29sIGNoZWNrX2F6eF9mcmVlKHN0cnVj
dCBhenggKmNoaXApCit7CisJc3RydWN0IGF6eF9kZXYgKmF6eF9kZXY7CisJaW50IGk7CisKKwlm
b3IgKGkgPSAwOyBpIDwgY2hpcC0+bnVtX3N0cmVhbXM7IGkrKykgeworCQlhenhfZGV2ID0gJmNo
aXAtPmF6eF9kZXZbaV07CisJCWlmIChhenhfZGV2LT5wcmVwYXJlZCkKKwkJCXJldHVybiB0cnVl
OworCX0KKwlyZXR1cm4gZmFsc2U7Cit9CisKK3N0YXRpYyBpbnQgYXp4X3Bvd2VyX3NhdmVfdXBk
YXRlKHN0cnVjdCBhenggKmNoaXApCit7CisJc3RydWN0IHBjaV9kZXYgKnBjaSA9IGNoaXAtPnBj
aTsKKwlzdHJ1Y3QgaGRhX2NvZGVjICpjb2RlYzsKKwlpbnQgdXNhZ2VfY291bnQ7CisJYm9vbCBj
b2RlY19idXN5OyAvKiBDaGVjayBpZiBwaW5zIGNvbm5lY3RpbmcgTW9uaXRvcnMgKi8KKworCWxp
c3RfZm9yX2VhY2hfZW50cnkoY29kZWMsICZjaGlwLT5idXMtPmNvZGVjX2xpc3QsIGxpc3QpIHsK
KwkJaWYgKGNvZGVjLT5wYXRjaF9vcHMuY29kZWNfYnVzeSkKKwkJCWNvZGVjX2J1c3kgPSBjb2Rl
Yy0+cGF0Y2hfb3BzLmNvZGVjX2J1c3koY29kZWMpOworCX0KKworCXVzYWdlX2NvdW50ID0gYXRv
bWljX3JlYWQoJnBjaS0+ZGV2LnBvd2VyLnVzYWdlX2NvdW50KTsKKwlpZiAodXNhZ2VfY291bnQg
PiAwICYmCisJCQkhY2hlY2tfYXp4X2ZyZWUoY2hpcCkgJiYKKwkJCSFjb2RlY19idXN5KSB7CisJ
CXBtX3J1bnRpbWVfYWxsb3coJnBjaS0+ZGV2KTsKKwkJcG93ZXJfc2F2ZSA9IDE7CisJfQorCisJ
cmV0dXJuIHVzYWdlX2NvdW50OworfQorCitzdGF0aWMgdm9pZCBhenhfcG93ZXJ3ZWxsX3dvcmso
c3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQoreworCXN0cnVjdCBhenggKmNoaXAgPSBjb250YWlu
ZXJfb2Yod29yaywgc3RydWN0IGF6eCwgcG93ZXJ3ZWxsX3dvcmsud29yayk7CisJaW50IHJlcGVh
dDsKKworCXJlcGVhdCA9IGF6eF9wb3dlcl9zYXZlX3VwZGF0ZShjaGlwKTsKKwlpZiAocmVwZWF0
ID4gMCkKKwkJc2NoZWR1bGVfZGVsYXllZF93b3JrKCZjaGlwLT5wb3dlcndlbGxfd29yaywgbXNl
Y3NfdG9famlmZmllcyg1MDAwKSk7Cit9CiAjZW5kaWYKIAogLyoKQEAgLTM1MjQsNiArMzU3Niw3
IEBAIHN0YXRpYyBpbnQgYXp4X2NyZWF0ZShzdHJ1Y3Qgc25kX2NhcmQgKmNhcmQsIHN0cnVjdCBw
Y2lfZGV2ICpwY2ksCiAjaWZkZWYgQ09ORklHX1NORF9IREFfSTkxNQogCS8qIGNvbnRpbnVlIHBy
b2JpbmcgaW4gd29yayBjb250ZXh0IGFzIG1heSB0cmlnZ2VyIHJlcXVlc3QgbW9kdWxlICovCiAJ
SU5JVF9XT1JLKCZjaGlwLT5wcm9iZV93b3JrLCBhenhfcHJvYmVfd29yayk7CisJSU5JVF9ERUxB
WUVEX1dPUksoJmNoaXAtPnBvd2Vyd2VsbF93b3JrLCBhenhfcG93ZXJ3ZWxsX3dvcmspOwogI2Vu
ZGlmCiAKIAkqcmNoaXAgPSBjaGlwOwpAQCAtMzg5MCw2ICszOTQzLDkgQEAgc3RhdGljIGludCBh
enhfcHJvYmVfY29udGludWUoc3RydWN0IGF6eCAqY2hpcCkKIAlpZiAoY2hpcC0+ZHJpdmVyX2Nh
cHMgJiBBWlhfRENBUFNfUE1fUlVOVElNRSkKIAkJcG1fcnVudGltZV9wdXRfbm9pZGxlKCZwY2kt
PmRldik7CiAKKwlpZiAoY2hpcC0+ZHJpdmVyX2NhcHMgJiBBWlhfRENBUFNfSTkxNV9QT1dFUldF
TEwpCisJCXNjaGVkdWxlX2RlbGF5ZWRfd29yaygmY2hpcC0+cG93ZXJ3ZWxsX3dvcmssIG1zZWNz
X3RvX2ppZmZpZXMoNTAwMCkpOworCiAJcmV0dXJuIDA7CiAKIG91dF9mcmVlOgpkaWZmIC0tZ2l0
IGEvc291bmQvcGNpL2hkYS9wYXRjaF9oZG1pLmMgYi9zb3VuZC9wY2kvaGRhL3BhdGNoX2hkbWku
YwppbmRleCAwMzBjYTg2Li5hNjkyMDc4IDEwMDY0NAotLS0gYS9zb3VuZC9wY2kvaGRhL3BhdGNo
X2hkbWkuYworKysgYi9zb3VuZC9wY2kvaGRhL3BhdGNoX2hkbWkuYwpAQCAtMTg4Miw2ICsxODgy
LDIyIEBAIHN0YXRpYyBpbnQgZ2VuZXJpY19oZG1pX3Jlc3VtZShzdHJ1Y3QgaGRhX2NvZGVjICpj
b2RlYykKIH0KICNlbmRpZgogCitib29sIGdlbmVyaWNfaGRtaV9idXN5KHN0cnVjdCBoZGFfY29k
ZWMgKmNvZGVjKQoreworCXN0cnVjdCBoZG1pX3NwZWMgKnNwZWMgPSBjb2RlYy0+c3BlYzsKKwlz
dHJ1Y3QgaGRtaV9lbGQgKmVsZDsKKwlpbnQgcGluX2lkeDsKKworCWZvciAocGluX2lkeCA9IDA7
IHBpbl9pZHggPCBzcGVjLT5udW1fcGluczsgcGluX2lkeCsrKSB7CisJCWVsZCA9ICZnZXRfcGlu
KHNwZWMsIHBpbl9pZHgpLT5zaW5rX2VsZDsKKwkJaWYgKGVsZC0+bW9uaXRvcl9wcmVzZW50IHx8
CisJCQkJZWxkLT5lbGRfdmFsaWQpCisJCQlyZXR1cm4gdHJ1ZTsKKwl9CisJc25kX3ByaW50ZGQo
IkhETUkgcGlucyBmcmVlIG5vd1xuIik7CisJcmV0dXJuIGZhbHNlOworfQorCiBzdGF0aWMgY29u
c3Qgc3RydWN0IGhkYV9jb2RlY19vcHMgZ2VuZXJpY19oZG1pX3BhdGNoX29wcyA9IHsKIAkuaW5p
dAkJCT0gZ2VuZXJpY19oZG1pX2luaXQsCiAJLmZyZWUJCQk9IGdlbmVyaWNfaGRtaV9mcmVlLApA
QCAtMTg5MSw4ICsxOTA3LDIzIEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgaGRhX2NvZGVjX29wcyBn
ZW5lcmljX2hkbWlfcGF0Y2hfb3BzID0gewogI2lmZGVmIENPTkZJR19QTQogCS5yZXN1bWUJCQk9
IGdlbmVyaWNfaGRtaV9yZXN1bWUsCiAjZW5kaWYKKwkuY29kZWNfYnVzeQkJPSBnZW5lcmljX2hk
bWlfYnVzeSwKIH07CiAKK2Jvb2wgaW50ZWxfaGFzd2VsbF9waW5zX2J1c3koc3RydWN0IGhkYV9j
b2RlYyAqY29kZWMpCit7CisJc3RydWN0IGhkbWlfc3BlYyAqc3BlYyA9IGNvZGVjLT5zcGVjOwor
CXN0cnVjdCBoZG1pX2VsZCAqZWxkOworCWludCBwaW5faWR4OworCisJZm9yIChwaW5faWR4ID0g
MDsgcGluX2lkeCA8IHNwZWMtPm51bV9waW5zOyBwaW5faWR4KyspIHsKKwkJZWxkID0gJmdldF9w
aW4oc3BlYywgcGluX2lkeCktPnNpbmtfZWxkOworCQlpZiAoZWxkLT5tb25pdG9yX3ByZXNlbnQg
fHwKKwkJCQllbGQtPmVsZF92YWxpZCkKKwkJCXJldHVybiB0cnVlOworCX0KKwlyZXR1cm4gZmFs
c2U7Cit9CiAKIHN0YXRpYyB2b2lkIGludGVsX2hhc3dlbGxfZml4dXBfY29ubmVjdF9saXN0KHN0
cnVjdCBoZGFfY29kZWMgKmNvZGVjLAogCQkJCQkgICAgIGhkYV9uaWRfdCBuaWQpCi0tIAoxLjcu
OS41Cgo=

--_002_46B810F6945F7C4788E11DCE57EC489011851134SHSMSX104ccrcor_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--_002_46B810F6945F7C4788E11DCE57EC489011851134SHSMSX104ccrcor_--

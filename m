From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH 0/3] Make HDMI ELD usable with hotplug
Date: Tue, 19 Feb 2013 06:55:36 +0100
Message-ID: <512313D8.901@canonical.com>
References: <1361193073-7199-1-git-send-email-david.henningsson@canonical.com>
 <s5h4nh9hhi6.wl%tiwai@suse.de> <512231B9.6000408@canonical.com>
 <20130218223942.GB3605@sci.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id B965926519E
 for <alsa-devel@alsa-project.org>; Tue, 19 Feb 2013 06:55:34 +0100 (CET)
In-Reply-To: <20130218223942.GB3605@sci.fi>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, fengguang.wu@intel.com, pierre-louis.bossart@linux.intel.com, Wang Xingchao <xingchao.wang@intel.com>
List-Id: alsa-devel@alsa-project.org

On 02/18/2013 11:39 PM, Ville Syrj=E4l=E4 wrote:
> On Mon, Feb 18, 2013 at 02:50:49PM +0100, David Henningsson wrote:
>> On 02/18/2013 02:35 PM, Takashi Iwai wrote:
>>> At Mon, 18 Feb 2013 14:11:10 +0100,
>>> David Henningsson wrote:
>>>>
>>>> I'm experimenting with using ELD information in PulseAudio and found
>>>> that it didn't work very well with hotplugging.
>>>> Neither the proc file nor the ELD kcontrol was cleared correctly after
>>>> unplug, and there was no way (except polling) to find out when ELD
>>>> has become available.
>>>
>>> Did you try Xingchao's patch for drm/i915?  It's queued in
>>> drm-intel-next:
>>>
>>>       commit 7b9f35a6dd72f89452c58bbdbaf063027bf857ec
>>>       Author: Wang Xingchao <xingchao.wang@intel.com>
>>>       Date:   Tue Jan 22 23:25:25 2013 +0800
>>>
>>>       drm/i915: HDMI/DP - ELD info refresh support for Haswell
>>
>> Thanks for the hint. I'm currently developing not on a Haswell machine,
>> but an (I think) Arrandale that I bought a few years ago. So I guess
>> this patch does not have any effect on my hw?
>
> While reviewing that patch I asked whether we need something like that
> on other platforms. Unfortunately I didn't get a real answer. The logic
> in the patch would seem to apply equally to all platforms, not just HSW.
> We also seem to be doing silly things like flipping the ELD valid bit
> in the register on and off a few times when we update the ELD. But I'm
> not all that familiar with the topic so take my ramblings with a pinch
> of salt.
>
> But in any case, if you're seeing a problem with the behaviour of i915
> you should definitely report it.

Looking at the HDA spec [1], e g "Figure 72: PD and ELDV unsolicited =

responses flow for digital display codecs" it looks like it's not valid =

to first send the PD bit and then ELDV a while later. So then I guess =

it's an issue that this actually seem to happen on the machine I use for =

testing this code.

 From the same figure, it also looks like ELDV can be flipped back and =

forth (due to mode changes) when PD is true; so making patches that deal =

with PD and ELDV independently seem to be the right thing nonetheless.


-- =

David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic

[1] =

http://www.intel.com/content/www/us/en/standards/high-definition-audio-spec=
ification.html

From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: Re: [PATCH 0/2] Generic HDMI codec: Add channel
	mapping control
Date: Fri, 9 Dec 2016 15:06:36 +0100
Message-ID: <fffbf15e-ac95-a203-357f-01044614372a@st.com>
References: <1481215067-19362-1-git-send-email-arnaud.pouliquen@st.com>
 <f4d0e685-51f0-5831-e087-67d2ba276422@sakamocchi.jp>
 <ca1cfca3-3f2a-3935-536d-5d92cc4d0a67@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by alsa0.perex.cz (Postfix) with ESMTP id E7A19267786
 for <alsa-devel@alsa-project.org>; Fri,  9 Dec 2016 15:06:50 +0100 (CET)
In-Reply-To: <ca1cfca3-3f2a-3935-536d-5d92cc4d0a67@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org
Cc: kernel@stlinux.com, Takashi Iwai <tiwai@suse.de>, lgirdwood@gmail.com, Jyri Sarha <jsarha@ti.com>, David Airlie <airlied@linux.ie>, broonie@kernel.org, Daniel Vetter <daniel.vetter@intel.com>
List-Id: alsa-devel@alsa-project.org

Hi,

On 12/08/2016 10:13 PM, Takashi Sakamoto wrote:
> On Dec 9 2016 05:52, Takashi Sakamoto wrote:
>> On Dec 9 2016 01:37, Arnaud Pouliquen wrote:
>>> Aim of this patch is to add  'Playback Channel Map' control to export
>>> audio capabilities in term of HDMI sink speakers allocation.
>>> This patch follow discussion initiates here:
>>> [RFC] ASOC: HDMI audio info frame speaker allocation
>>> http://www.spinics.net/lists/alsa-devel/msg57363.html
>>>
>>> The code is fully inspired from HDA driver.
>>> On hw_param, HDMI sink speaker capabilities are exported via TLV ops
>>> and  a CEA allocation is choson, based on ELD information and the
>>> number of
>>> channels requested by user.
>>>
>>> Mains differences with HDA implementation are:
>>>  - Control is read only
>>>  - Channel swap is not supported. Consequence is that unused channel in
>>>    the mid of CEA audio infoframe channel mapping are considered as
>>>    active.
>>>    example for channel allocation 0x02: FL, FR, 0, FC)
>>>     This configuration is only available for a 4 channels stream.
>>>   - Channel allocation table has been reordered and HDMI 2.0 is not
>>>     supported.
>>>
>>> Arnaud Pouliquen (2):
>>>   DRM: add help to get ELD speaker allocation
>>>   ASoC: hdmi-codec: add channel mapping control
>>>
>>>  include/drm/drm_edid.h        |  13 ++
>>>  sound/soc/codecs/hdmi-codec.c | 346
>>> +++++++++++++++++++++++++++++++++++++++++-
>>>  2 files changed, 358 insertions(+), 1 deletion(-)
>>
>> Please pay enough attention to development cycle for Linux kernel.
>>
>> We're mostly on the end of development for 4.9 cycle, and review process
>> for new feature might be delay for next cycle, till 4.9 release, two
>> weeks later.
> 
> Oops. I was stupid just after awakening...
> 
> Anyway, we're mostly on the end of development for 4.10 cycle, and the
> review process for new feature might be delay till 4.10-rc1 release, two
> weeks later. During the weeks. bug fixes are preferable to be applied.

Thank you for warning me. No problem for the delay, i fully understand
that focus is on bug fixes.
Notice that it is quite difficult for developers to find the best timing
to address this kind of patch, as integration process is not always
simple to follow... this probably come with experience.

So if i well understand your remark the best windows to integrate a
feature for the version N+1, is to propose patch from N-rc1 tag.
(expecting that patch-set is enough mature to be integrated in N+1...)

Regards
Arnaud

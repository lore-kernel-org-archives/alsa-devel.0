From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: Re: [RFC v2 1/3] ASoC: core: allow DAI PCM controls
 bound to PCM device
Date: Thu, 24 Nov 2016 10:52:59 +0100
Message-ID: <c20f7a0f-0860-3d3b-f518-6a33661cd11e@st.com>
References: <1479811996-2238-1-git-send-email-arnaud.pouliquen@st.com>
 <1479811996-2238-2-git-send-email-arnaud.pouliquen@st.com>
 <20161124045513.GS2698@localhost>
 <1f53b56a-719c-4711-59eb-ba11a42f3773@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 551AC2670CF
 for <alsa-devel@alsa-project.org>; Thu, 24 Nov 2016 10:53:03 +0100 (CET)
In-Reply-To: <1f53b56a-719c-4711-59eb-ba11a42f3773@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>, Vinod Koul <vinod.koul@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@kernel.org" <broonie@kernel.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hello Vinod

On 11/24/2016 06:14 AM, Takashi Sakamoto wrote:

>> The same problem (same control names IIUC) existis on codec and SoC's, now
>> that both have DSP, we can have DSP "Volume control"...
>>
>> Would this solve that as well..?
> 
> No. It's not the aim of this patchset and out of its scope.
> 
> However, in fact, we should seek good solution for the issue of
> 'conflict of identification information of control element set added by
> ALSA SoC part automatically'.
>
Solution only solves issue for DAIs that are statically linked to a PCM
device on probe,
In you case, link to PCM device is done during runtime through adpcm, right?
Have you an example of a PCM control that you need to link to the PCM
character device?

>>> Application should be able to address the control using the
>>> device field number, according to the PCM character device.
>>> This patch allows to link DAI PCM controls to the PCM device.
>>
>> why is that part required..? Is the problem being solved to address a
>> control uniquely or something else?
It treats a PCM control uniquely,
 what do you have in mind when you say "or something else"?
>>
>>> During DAI_link probe, PCM controls are added after device field is forced
>>> to the PCM device number.
>>>
>>> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
>>> ---
>>>  include/sound/soc-dai.h |  4 ++++
>>>  sound/soc/soc-core.c    | 37 +++++++++++++++++++++++++++++++++++++
>>>  2 files changed, 41 insertions(+)

Regards,

Arnaud

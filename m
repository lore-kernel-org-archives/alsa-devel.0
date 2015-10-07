From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: Re: [PATCH RFC V2 0/5] another generic audio hdmi
 codec proposal
Date: Wed, 7 Oct 2015 09:48:42 +0200
Message-ID: <5614CE5A.1080406@st.com>
References: <1443718221-5120-1-git-send-email-arnaud.pouliquen@st.com>
 <56127ADB.6080700@ti.com> <561392F7.90608@st.com>
 <20151006163311.03067bb5@OPI2>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 3E2652658CB
 for <alsa-devel@alsa-project.org>; Wed,  7 Oct 2015 09:48:52 +0200 (CEST)
In-Reply-To: <20151006163311.03067bb5@OPI2>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jean-Francois Moine <moinejf@free.fr>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, Benjamin Gaignard <benjamin.gaignard@linaro.org>, David Airlie <airlied@linux.ie>, "broonie@kernel.org" <broonie@kernel.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "peter.ujfalusi@ti.com" <peter.ujfalusi@ti.com>, Takashi Iwai <tiwai@suse.de>, "tony@atomide.com" <tony@atomide.com>, "tomi.valkeinen@ti.com" <tomi.valkeinen@ti.com>, Jyri Sarha <jsarha@ti.com>, "bcousson@baylibre.com" <bcousson@baylibre.com>
List-Id: alsa-devel@alsa-project.org


On 10/06/2015 04:33 PM, Jean-Francois Moine wrote:
> On Tue, 6 Oct 2015 11:23:03 +0200
> Arnaud Pouliquen <arnaud.pouliquen@st.com> wrote:
> 	[snip]
>> As API is defined in DRM, it seems more logical to match it with the one
>> defined for video. From my windows, i didn't see any blocking point to
>> connect codec callback with this API.
>> But anyway, this API is not freezed, it could be improved with your help.
>
> Arnaud, your implementation seems more heavy than Jyri's, and I don't
> feel the DRM bridge.
>
> For HDMI, the exchanges between DRM and ALSA are only:
> - DRM -> ALSA
>    - device connection with the audio constraints
>    - device disconnection
> - ALSA -> DRM
>    - start audio with the chosen audio parameters
>    - stop audio
>
> and, in the system, the HDMI devices are seen as DRM connectors (video
> view) and as ASoC CODECs (audio view).
>
> We just need a link between these entities.
> I don't think that the bridge offers this.
Not so heavy...
In fact another way to differentiate the twice approaches could be to
answer to this question:
Should ALSA bypasses or not the DRM core/API to access to DRM HDMI 
connector?

Concerning bridge usage, I tried to found a link to address DRM driver 
trough DRM API. Bridge seemed a good candidate. Perhaps the DRM encoder 
API could be an other option to study...

Ken ar wech all/ best Regards
Arnaud

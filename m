From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [RFC v2 6/6] ASoC: hdmi-codec: Use HDMI
 notifications to add jack support
Date: Fri, 8 Jan 2016 11:57:11 +0200
Message-ID: <568F87F7.3010409@ti.com>
References: <1451934551-21333-1-git-send-email-p.zabel@pengutronix.de>
 <1451935145-24861-1-git-send-email-p.zabel@pengutronix.de>
 <568E9BE1.6050209@ti.com> <1452242629.3347.12.camel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id C503226040E
 for <alsa-devel@alsa-project.org>; Fri,  8 Jan 2016 10:57:20 +0100 (CET)
In-Reply-To: <1452242629.3347.12.camel@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Jean-Francois Moine <moinejf@free.fr>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Arnaud Pouliquen <arnaud.pouliquen@st.com>, Koro Chen <koro.chen@mediatek.com>, Daniel Kurtz <djkurtz@chromium.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-mediatek@lists.infradead.org, kernel@pengutronix.de, Matthias Brugger <matthias.bgg@gmail.com>, Cawa Cheng <cawa.cheng@mediatek.com>
List-Id: alsa-devel@alsa-project.org

On 01/08/16 10:43, Philipp Zabel wrote:
> Hi Jyri,
>
> Am Donnerstag, den 07.01.2016, 19:09 +0200 schrieb Jyri Sarha:
>> On 01/04/16 21:19, Philipp Zabel wrote:
>>> Use HDMI connection / disconnection notifications to update an ALSA
>>> jack object. Also make a copy of the ELD block after every change.
>>>
>>
>> The jack part looks good to me AFAIU,
>
> If this is in principle an acceptable idea, this leaves the issue that
> the jack has an initial state and right now we can't query it but
> instead would have to wait for the first HDMI_(DIS)CONNECTED
> notification before it can be set. Would it make sense to add an
> is_connected callback to the hdmi_codec_ops or does this rather belong
> somewhere else?
>

To me it would feel best if the hdmi notification would send the current 
edid, eld, and connection state when the hdmi notification is 
registered. But then again, I may not see the full picture.

BTW, if we are going this way, the hdmi notification should be 
registered always in probe phase. I don't think the 
hdmi_codec_set_jack_detect() should be needed at all. Simple simple 
flags in struct hdmi_codec_pdata that tells if the jack detection is 
supported should do. Hmm, I am not sure if we need even that.

>> but I think we should just update
>> the local ELD copy with data given in the ELD notification. It then
>> depends on the implementation details whether the get_eld() callback is
>> needed at all or if it should be called once at the probe time.
>
> Thanks, that sounds reasonable.
>
>> Then it is a separate issue to check if the currently played stream is
>> still supported after an ELD update, and to decide what to do about it
>> if it is not.
> [...]
>
> Possibly the HDMI driver itself should just mute if the format is not
> supported, and userspace should be notified?
>

Another option would be simply aborting the playback. However having a 
mute control, that is forced to mute if the current stream is not 
supported, is an interesting idea. That would provide a way to notify 
the userspace without intrusively killing the stream.

Cheers,
Jyri

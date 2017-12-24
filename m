From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] ASoC: rt5645: Set card long_name for GPD
 win / pocket
Date: Sun, 24 Dec 2017 11:45:34 +0100
Message-ID: <6c40b0cc-f969-79e1-f431-cdd310173d17@redhat.com>
References: <20171211212640.10060-1-hdegoede@redhat.com>
 <s5hpo7cdsuv.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f66.google.com (mail-wm0-f66.google.com [74.125.82.66])
 by alsa0.perex.cz (Postfix) with ESMTP id EFCD026698E
 for <alsa-devel@alsa-project.org>; Sun, 24 Dec 2017 11:45:35 +0100 (CET)
Received: by mail-wm0-f66.google.com with SMTP id g130so30220531wme.0
 for <alsa-devel@alsa-project.org>; Sun, 24 Dec 2017 02:45:35 -0800 (PST)
In-Reply-To: <s5hpo7cdsuv.wl-tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: Oder Chiou <oder_chiou@realtek.com>, Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

Hi,

On 18-12-17 15:16, Takashi Iwai wrote:
> On Mon, 11 Dec 2017 22:26:40 +0100,
> Hans de Goede wrote:
>>
>> The GPD win and pocket devices both use the same codec setup and both
>> have too generic dmi strings making snd_soc_set_dmi_name() not work.
>>
>> As these devices have only a single speaker we want a separate ucm
>> file for them, which requires a unique long_name, use the existing
>> GPD quirk handling to also provide a unique long_name.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> 
> Since Mark already took this patch, could you provide the UCM profile
> for the corresponding update, too?

I've been trying to get the analog microphone input on these devices
to work, so that I can submit a complete UCM profile in one go.

But all my attempts have failed, I've send Bard Liao a mail about this,
with alsa-devel in the Cc. I hope Bard can help me to get the microphone
to work. If that fails / take to long I will submit a version with
just the monospeaker routing in a couple of weeks.

Regards,

Hans

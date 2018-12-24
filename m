From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 0/6] ASoC: rt5651: Various fixes and quirks
Date: Mon, 24 Dec 2018 15:15:00 +0100
Message-ID: <ed06b29d-5677-5044-2e0a-d7f3a50d2498@redhat.com>
References: <20180718205542.12364-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com
 [209.85.208.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 0B13D267A65
 for <alsa-devel@alsa-project.org>; Mon, 24 Dec 2018 15:15:02 +0100 (CET)
Received: by mail-ed1-f65.google.com with SMTP id f9so10126712eds.10
 for <alsa-devel@alsa-project.org>; Mon, 24 Dec 2018 06:15:02 -0800 (PST)
In-Reply-To: <20180718205542.12364-1-hdegoede@redhat.com>
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
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>
Cc: Tanu Kaskinen <tanuk@iki.fi>, alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Carlo Caione <carlo@endlessm.com>
List-Id: alsa-devel@alsa-project.org

Hi all,

On 18-07-18 22:55, Hans de Goede wrote:
<snip>

> Note that unfortunately my previous round of cleanup patches removed
> 1 input mapping (of the 3 mappings in total it removed) which is
> actually necessary. So this series re-introduces that 1 mapping. I did
> not notice this before because UCM input profile switching does not work
> reliably for some reason, something which I still need to investigate.

While doing some bytcr_rt5651 work this weekend (the x86 ASoC work I
do is a spare time project for me) I hit this again, so this time
I've spend some time getting to the bottom of this. The cause is a
pulseaudio bug, where pulseaudio uses a strncmp without first
checking the lengths of the 2 strings match, causing it to see
selecting the "InternalMic-IN1" UCM device as selecting both the
"InternalMic-IN1" and the "InternalMic-IN12" device.

A pull-req fixing this is here:
https://gitlab.freedesktop.org/pulseaudio/pulseaudio/merge_requests/40

Regards,

Hans

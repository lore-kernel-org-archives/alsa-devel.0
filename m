From: Eric Laurent <elaurent@google.com>
Subject: Re: Audio Miniconference 2013 schedule II - Edinburgh
	21st October
Date: Tue, 15 Oct 2013 09:00:40 -0700
Message-ID: <CAL-7xP9=TfwCuMtzfOLv9LMwkHqRt+BRzOwf2AOHBxpoenk3ZQ@mail.gmail.com>
References: <20131014161003.GC2443@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vb0-f47.google.com (mail-vb0-f47.google.com
 [209.85.212.47])
 by alsa0.perex.cz (Postfix) with ESMTP id A67152610B0
 for <alsa-devel@alsa-project.org>; Tue, 15 Oct 2013 18:00:42 +0200 (CEST)
Received: by mail-vb0-f47.google.com with SMTP id h10so5119103vbh.6
 for <alsa-devel@alsa-project.org>; Tue, 15 Oct 2013 09:00:40 -0700 (PDT)
In-Reply-To: <20131014161003.GC2443@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Colin Guthrie <colin@guthr.ie>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Arun Raghavan <arun.raghavan@collabora.co.uk>, Vinod Koul <vinod.koul@intel.com>, Liam Girdwood <liam.r.girdwood@intel.com>, Tanu Kaskinen <tanuk@iki.fi>, David Henningsson <david.henningsson@canonical.com>, "Bossart,
 Pierre-louis" <pierre-louis.bossart@intel.com>
List-Id: alsa-devel@alsa-project.org

Hi,

I can facilitate discussion on compress audio user space and tinycompress
with a presentation of what was done for Android K release.
Someone else should take the lead for the driver part.

I can also present user space changes for audio effect offloading.

Thanks.

Eric.



On Mon, Oct 14, 2013 at 9:10 AM, Mark Brown <broonie@kernel.org> wrote:

> Another go at the schedule for the mini-summit based on the feedback
> last time.  Same three major topics:
>
>  - Compressed audio review: tinycompress, integration into userspace,
>    driver upstreaming.
>
>  - UCM and other use case management status & review (Tanu).
>
>  - Effects offload to DSPs with dynamically instantiatable algorithms,
>    and general dynamic DSP firmware handling including DSP resource
>    management (Pierre).
>
> Plus a few things that only one or two people brought up:
>
>  - Process stuff (the list, bug tracking and so on).
>
>  - Some relatively specific hardware support topics:
>   - HDMI hotplug handling throughout the stack
>   - Mic status LED handling throughout the stack.
>
>  - Code cleanups:
>   - Moving away from the custom ALSA device registration infrastructure.
>   - General code modernisation.
>
>  - Performance, especially DAPM (Patrick)
>
>  - General routing control in userspace - UIs, automation (Daniel).
>
> Hopefully this caught everything that was missed last time.  It'd be
> good to have volunteers to lead the discussions in each area, I've
> marked those we got already.
>
> As previously mentioned it'd be good if anyone planning to attend could
> fill in the form at:
>
>
> https://docs.google.com/forms/d/105uav9tkwwkDU4P1T3IOWjfsa3kgtDbFAJOlHgBQR5k/viewform
>
> to help with planning & coordination.
>

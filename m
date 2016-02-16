From: Vaibhav Agarwal <vaibhav.agarwal@linaro.org>
Subject: Re: [RFC 2/4] alsa: add locked variant for
	snd_ctl_remove_id
Date: Tue, 16 Feb 2016 19:24:57 +0530
Message-ID: <CANQOkFHojJsE66HZExYTJgq7VTqx_yLWdkAQBHA4bJYz2ycM+g@mail.gmail.com>
References: <1455538772-24926-1-git-send-email-vaibhav.agarwal@linaro.org>
 <1455538772-24926-3-git-send-email-vaibhav.agarwal@linaro.org>
 <20160215140224.GK18988@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f171.google.com (mail-ob0-f171.google.com
 [209.85.214.171])
 by alsa0.perex.cz (Postfix) with ESMTP id 88D652606EB
 for <alsa-devel@alsa-project.org>; Tue, 16 Feb 2016 14:55:00 +0100 (CET)
Received: by mail-ob0-f171.google.com with SMTP id wb13so259595928obb.1
 for <alsa-devel@alsa-project.org>; Tue, 16 Feb 2016 05:55:00 -0800 (PST)
In-Reply-To: <20160215140224.GK18988@sirena.org.uk>
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
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org, mengdong.lin@linux.intel.com, vinod.koul@intel.com, Takashi Iwai <tiwai@suse.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>
List-Id: alsa-devel@alsa-project.org

+Takashi

On 15 February 2016 at 19:32, Mark Brown <broonie@kernel.org> wrote:
> On Mon, Feb 15, 2016 at 05:49:30PM +0530, Vaibhav Agarwal wrote:
>> While removing kcontrols due to dynamic dai_link/codec removal,
>> mutex/semaphore for soc-card/sound card is already acquired.
>> Thus, added lock already acquired variant for ctl_remove_id.
>
> Please use subject lines matching the style for the subsystem and
> remember to CC maintainers on patch submission.
 Sure, will follow the convention for subject lines as well.

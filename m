From: Vaibhav Agarwal <vaibhav.agarwal@linaro.org>
Subject: Re: [RFC 2/4] alsa: add locked variant for
	snd_ctl_remove_id
Date: Tue, 16 Feb 2016 19:45:38 +0530
Message-ID: <CANQOkFFJYuP7C1PXF03qC3x__6JKnQY7ED8OPzmLk+83LhKixA@mail.gmail.com>
References: <1455538772-24926-1-git-send-email-vaibhav.agarwal@linaro.org>
 <1455538772-24926-3-git-send-email-vaibhav.agarwal@linaro.org>
 <20160215140224.GK18988@sirena.org.uk>
 <CANQOkFHojJsE66HZExYTJgq7VTqx_yLWdkAQBHA4bJYz2ycM+g@mail.gmail.com>
 <s5hlh6k7nga.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f179.google.com (mail-ob0-f179.google.com
 [209.85.214.179])
 by alsa0.perex.cz (Postfix) with ESMTP id A290C2658A7
 for <alsa-devel@alsa-project.org>; Tue, 16 Feb 2016 15:15:39 +0100 (CET)
Received: by mail-ob0-f179.google.com with SMTP id xk3so259217482obc.2
 for <alsa-devel@alsa-project.org>; Tue, 16 Feb 2016 06:15:39 -0800 (PST)
In-Reply-To: <s5hlh6k7nga.wl-tiwai@suse.de>
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
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, mengdong.lin@linux.intel.com, vinod.koul@intel.com, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On 16 February 2016 at 19:43, Takashi Iwai <tiwai@suse.de> wrote:
> On Tue, 16 Feb 2016 14:54:57 +0100,
> Vaibhav Agarwal wrote:
>>
>> +Takashi
>>
>> On 15 February 2016 at 19:32, Mark Brown <broonie@kernel.org> wrote:
>> > On Mon, Feb 15, 2016 at 05:49:30PM +0530, Vaibhav Agarwal wrote:
>> >> While removing kcontrols due to dynamic dai_link/codec removal,
>> >> mutex/semaphore for soc-card/sound card is already acquired.
>> >> Thus, added lock already acquired variant for ctl_remove_id.
>> >
>> > Please use subject lines matching the style for the subsystem and
>> > remember to CC maintainers on patch submission.
>>  Sure, will follow the convention for subject lines as well.
>
> I prefer reducing snd_ctl_remove_id() as well.  Just wrap the call of
> the unlocked one with down/up_write().
Sure, will make the change in next patchset.
>
>
> Takashi

From: Felipe Tonello <eu@felipetonello.com>
Subject: Re: [PATCH 1/4] ALSA: Added jack detection kcontrol
	support
Date: Fri, 26 Jul 2013 16:13:40 -0700
Message-ID: <CAGrhNMwGdMwhd5L2gGxQ=N=8nFk4L5txYmhEtLBVcFj-Etphnw@mail.gmail.com>
References: <1374863133-6745-1-git-send-email-eu@felipetonello.com>
 <1374863133-6745-2-git-send-email-eu@felipetonello.com>
 <20130726185458.GX9858@sirena.org.uk>
 <CAGrhNMy7qZ8CbAjFX5Gv8OqYkit+Eqzr2zZTYXeQ-cNO22+pTQ@mail.gmail.com>
 <20130726224813.GB9858@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f179.google.com (mail-we0-f179.google.com
 [74.125.82.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 493F92658CC
 for <alsa-devel@alsa-project.org>; Sat, 27 Jul 2013 01:13:41 +0200 (CEST)
Received: by mail-we0-f179.google.com with SMTP id t57so2354935wes.38
 for <alsa-devel@alsa-project.org>; Fri, 26 Jul 2013 16:13:41 -0700 (PDT)
In-Reply-To: <20130726224813.GB9858@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Wang Xingchao <xingchao.wang@linux.intel.com>, linux-kernel@vger.kernel.org, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Mark,

On Fri, Jul 26, 2013 at 3:48 PM, Mark Brown <broonie@kernel.org> wrote:
> On Fri, Jul 26, 2013 at 12:10:27PM -0700, Felipe Tonello wrote:
>> On Fri, Jul 26, 2013 at 11:54 AM, Mark Brown <broonie@kernel.org> wrote:
>
>> > This isn't ideal for multi-function jacks like headsets - it will report
>> > a single boolean value for the jack regardless of what's plugged in
>> > meaning userpace can't do things like figure out if a headset or
>> > headphone is present.  It's probably OK for any realistic input button
>> > since you're not going to get an input button without other things being
>> > present.
>
>> The KControl for Jack is boolean anyway. You can check it with "amixer
>> contents". user-space can figure out based on the control name. At
>> least PulseAudio does that way.
>
> No, it can't do that for headset jacks - these will be created with a
> single jack reporting multiple states, there's a state for headphone and
> a state for microphone.  The system can generally distinguish between
> having a headset or just plain headphones inserted and act accordingly
> (for example, recording from the built in microphone on a phone when
> used with normal headpones).
>
>> > What I'd expect to happen here is that for multi function jacks we
>> > create a control per function if the controls are valid.

Ok, so the idea is just to change the control to type integer instead
of boolean, right?
Because as you say, the user will be able to check the type of jack
based on the status value, right?

>
>> Do you mean based on snd_jack_types?
>
> Yes.  If there's only one function supported the current code is fine
> but for multiple functions it's going to discard useful information.

So, what do you suggest to do that? I'm not sure if I understand what
you are saying.
When you mean function, do you mean the SND_JACK_BTN_n or the the jack
types, such as SND_JACK_HEADPHONE, and so on?

If a codec creates a jack type SND_JACK_HEADSET (= SND_JACK_HEADPHONE
| SND_JACK_MICROPHONE). It should be created two controls, name +
"Headphone Jack" and name + "Microphone Jack"? If so, what about the
status to report? How to know which control to report?

Felipe Tonello

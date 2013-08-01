From: Felipe Ferreri Tonello <eu@felipetonello.com>
Subject: Re: [PATCH 1/4] ALSA: Added jack detection kcontrol
	support
Date: Wed, 31 Jul 2013 20:48:27 -0700
Message-ID: <51F9DA8B.8050302@felipetonello.com>
References: <1374863133-6745-1-git-send-email-eu@felipetonello.com>
 <1374863133-6745-2-git-send-email-eu@felipetonello.com>
 <20130726185458.GX9858@sirena.org.uk>
 <CAGrhNMy7qZ8CbAjFX5Gv8OqYkit+Eqzr2zZTYXeQ-cNO22+pTQ@mail.gmail.com>
 <20130726224813.GB9858@sirena.org.uk>
 <CAGrhNMwGdMwhd5L2gGxQ=N=8nFk4L5txYmhEtLBVcFj-Etphnw@mail.gmail.com>
 <20130727122524.GH9858@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f54.google.com (mail-pb0-f54.google.com
 [209.85.160.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 68AF4261664
 for <alsa-devel@alsa-project.org>; Thu,  1 Aug 2013 05:48:32 +0200 (CEST)
Received: by mail-pb0-f54.google.com with SMTP id ro12so1574819pbb.27
 for <alsa-devel@alsa-project.org>; Wed, 31 Jul 2013 20:48:31 -0700 (PDT)
In-Reply-To: <20130727122524.GH9858@sirena.org.uk>
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

On 07/27/2013 05:25 AM, Mark Brown wrote:
> On Fri, Jul 26, 2013 at 04:13:40PM -0700, Felipe Tonello wrote:
>> On Fri, Jul 26, 2013 at 3:48 PM, Mark Brown <broonie@kernel.org> wrote:
>
>>>>> What I'd expect to happen here is that for multi function jacks we
>>>>> create a control per function if the controls are valid.
>
>> Ok, so the idea is just to change the control to type integer instead
>> of boolean, right?
>> Because as you say, the user will be able to check the type of jack
>> based on the status value, right?
>
> It might be more idiomatic and more compatible with userspace to create
> multiple controls for the jack, there was some discussion of this in the
> past I think but I can't remember the result.
>
>>> Yes.  If there's only one function supported the current code is fine
>>> but for multiple functions it's going to discard useful information.
>
>> So, what do you suggest to do that? I'm not sure if I understand what
>> you are saying.
>> When you mean function, do you mean the SND_JACK_BTN_n or the the jack
>> types, such as SND_JACK_HEADPHONE, and so on?
>
> The jack types, the buttons definitely sohuld be going up as input
> events.
>
>> If a codec creates a jack type SND_JACK_HEADSET (= SND_JACK_HEADPHONE
>> | SND_JACK_MICROPHONE). It should be created two controls, name +
>> "Headphone Jack" and name + "Microphone Jack"? If so, what about the
>> status to report? How to know which control to report?
>
> The drivers report a bitmask for status.
>

I did that but I'm not happy with the control name. Usually drivers add 
jacks like: "Headset" for a headset, "Headphone" for a headphone and so on.
I did the following: control name is jack name + (jack type) + Jack. If 
jack type == jack name, don't add (jack type) to the name.

Any suggestion how it should be?

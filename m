From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [alsa-devel] [PATCH] ALSA: hda - Fix Dock Headphone on Thinkpad
 X250 seen as a Line Out
Date: Wed, 24 Jun 2015 13:40:51 +0200
Message-ID: <558A9743.3000607@canonical.com>
References: <1435135593-6176-1-git-send-email-david.henningsson@canonical.com>	<s5hsi9hwker.wl-tiwai@suse.de>	<558A8F1D.1000606@canonical.com> <CAN8cciY3Fam7+9A6URg81FzRwyXPetuidSE2dJLF3=KMUMiLPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <CAN8cciY3Fam7+9A6URg81FzRwyXPetuidSE2dJLF3=KMUMiLPg@mail.gmail.com>
Sender: stable-owner@vger.kernel.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org



On 2015-06-24 13:23, Raymond Yau wrote:
>
>  >>>
>  >>> Thinkpad X250, when attached to a dock, has two headphone outs but
>  >>> no line out. Make sure we don't try to turn this into one headphone
>  >>> and one line out (since that disables the headphone amp on the dock).
>  >>>
>  >>> Alsa-info at
> http://www.alsa-project.org/db/?f=36f8764e1d782397928feec715d0ef90dfddd4c1
>  >>>
>  >>> Cc: stable@vger.kernel.org <mailto:stable@vger.kernel.org>
>  >>> Signed-off-by: David Henningsson <david.henningsson@canonical.com
> <mailto:david.henningsson@canonical.com>>
>  >>
>  >>
>  >> This is one of fixes I had in mind (and asked for testing in bugzilla
>  >> kernel.org <http://kernel.org> report).
>  >
>  >
>  > Sorry, I'm missing context. What report?
>
> https://bugzilla.kernel.org/show_bug.cgi?id=99721

Thanks.

> T440 support headset and thinkpad pro dock combo jack has headset icon
>
> If headset mic has higher priority than dock headset mic, it is strange
> that headset don't auto mute dock headset

So headphones should automute between each other if and only if both of 
them are combined headset jacks? Or what do you suggest?

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic

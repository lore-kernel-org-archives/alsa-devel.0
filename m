From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH 1/2] thinkpad-acpi: Try to use full software mute control
Date: Fri, 17 Oct 2014 17:09:18 -0700
Message-ID: <CALCETrWQN6coC9GCwDbj=RKB6Wsqa_zFzb-1PnN59En98pax5A@mail.gmail.com>
References: <cover.1413481880.git.luto@amacapital.net> <72f375b46a34702fc9f8be419fa83c219fbc28c5.1413481880.git.luto@amacapital.net>
 <20141016183130.GA15835@khazad-dum.debian.net> <CALCETrXz_x7E5aVvr7S1aTtGLbE8PKpVJFrBCZTEXZKjdi0F3w@mail.gmail.com>
 <20141016185455.GB15835@khazad-dum.debian.net> <CALCETrUsw07EXJQ+mYYQ5h3nmSqh=fbJLWvEGh--m=t_VVwJXQ@mail.gmail.com>
 <20141016195857.GA18264@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <20141016195857.GA18264@khazad-dum.debian.net>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, ibm-acpi-devel@lists.sourceforge.net, Len Brown <len.brown@intel.com>, David Henningsson <david.henningsson@canonical.com>, Takashi Iwai <tiwai@suse.de>, Grant Diffey <gdiffey@gmail.com>, ALSA development <alsa-devel@alsa-project.org>, platform-driver-x86@vger.kernel.org, Andy Lutomirski <luto@mit.edu>
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 16, 2014 at 12:58 PM, Henrique de Moraes Holschuh
<hmh@hmh.eng.br> wrote:
> On Thu, 16 Oct 2014, Andy Lutomirski wrote:
>> On Thu, Oct 16, 2014 at 11:54 AM, Henrique de Moraes Holschuh
>> <hmh@hmh.eng.br> wrote:
>> So the question is: are there IBM models (or models that don't send
>> KEY_MUTE, anyway) that nonetheless expose HAUM and SAUM?  If not, then
>> my patch should be okay.  If so, we'll need further filtering.
>
> No, these were introduced in the X61/T61.  Still, the standard paranoia
> applies, and you should check for HAUM/SAUM only on VENDOR_LENOVO, and
> assume they don't exist (because if they do, they are something else) for
> VENDOR_IBM.

Done in v3.

My X220 seems to be alive again for the time being -- I suspect that
there's a marginal connection somewhere.  It seems to be fully
functional with this match, and the mute light works as expected
(thanks, Takashi et al!).

--Andy

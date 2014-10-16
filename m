From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH 1/2] thinkpad-acpi: Try to use full software mute control
Date: Thu, 16 Oct 2014 16:58:57 -0300
Message-ID: <20141016195857.GA18264@khazad-dum.debian.net>
References: <cover.1413481880.git.luto@amacapital.net>
 <72f375b46a34702fc9f8be419fa83c219fbc28c5.1413481880.git.luto@amacapital.net>
 <20141016183130.GA15835@khazad-dum.debian.net>
 <CALCETrXz_x7E5aVvr7S1aTtGLbE8PKpVJFrBCZTEXZKjdi0F3w@mail.gmail.com>
 <20141016185455.GB15835@khazad-dum.debian.net>
 <CALCETrUsw07EXJQ+mYYQ5h3nmSqh=fbJLWvEGh--m=t_VVwJXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CALCETrUsw07EXJQ+mYYQ5h3nmSqh=fbJLWvEGh--m=t_VVwJXQ@mail.gmail.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Andy Lutomirski <luto@amacapital.net>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, ibm-acpi-devel@lists.sourceforge.net, Len Brown <len.brown@intel.com>, David Henningsson <david.henningsson@canonical.com>, Takashi Iwai <tiwai@suse.de>, Grant Diffey <gdiffey@gmail.com>, ALSA development <alsa-devel@alsa-project.org>, platform-driver-x86@vger.kernel.org, Andy Lutomirski <luto@mit.edu>
List-Id: alsa-devel@alsa-project.org

On Thu, 16 Oct 2014, Andy Lutomirski wrote:
> On Thu, Oct 16, 2014 at 11:54 AM, Henrique de Moraes Holschuh
> <hmh@hmh.eng.br> wrote:
> So the question is: are there IBM models (or models that don't send
> KEY_MUTE, anyway) that nonetheless expose HAUM and SAUM?  If not, then
> my patch should be okay.  If so, we'll need further filtering.

No, these were introduced in the X61/T61.  Still, the standard paranoia
applies, and you should check for HAUM/SAUM only on VENDOR_LENOVO, and
assume they don't exist (because if they do, they are something else) for
VENDOR_IBM.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

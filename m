From: Miro Hodak <mhodak127@gmail.com>
Subject: Re: HD-audio regression after commit
	34588709af61be1550b4e2bcee5c85d0ac4f34d4
Date: Thu, 17 Jan 2013 04:24:44 -0500
Message-ID: <CA+S_cwq7mDPkjPCVpRecO93UW2gpYo7BpMfFARu0PZCvNT-w4A@mail.gmail.com>
References: <CA+S_cwraM+wofw5Nz_d0ctOget5dY-0nr5pRHCzOJtLX+JM2TA@mail.gmail.com>
 <CAN8ccia1N-eseNR2dET=ghXuyK0E0gXaakehW3VAN8u1UxUQ8Q@mail.gmail.com>
 <20130114133122.52cadb99@gmail.com> <s5h7gngc4lt.wl%tiwai@suse.de>
 <20130114135947.1f0bbbf4@gmail.com> <s5h1udndihf.wl%tiwai@suse.de>
 <20130114172354.1f47f49b@gmail.com>
 <CAN8cciaoAt75sRUtLM6Ov4VGBQ1pFgPwO-EZT88q6d1gm-JggQ@mail.gmail.com>
 <20130115095325.7aa2dfdd@gmail.com>
 <CAN8cciYrMSBhpp-9QjHdE8aVMHh_JwHswwfPfjtGY6OB_E4NcQ@mail.gmail.com>
 <20130116094941.0e1170b2@gmail.com> <s5hwqvd33va.wl%tiwai@suse.de>
 <20130116133952.18449985@gmail.com> <s5hbocpp9tn.wl%tiwai@suse.de>
 <20130116140412.01c73523@gmail.com> <s5h8v7tp8s8.wl%tiwai@suse.de>
 <20130116145509.434c0bb9@gmail.com> <s5h1udlp5to.wl%tiwai@suse.de>
 <CAN8ccib5gpbsyLPmfoaC4edwYjird8ViZbKKiTbo-iP4DsjsOA@mail.gmail.com>
 <s5hehhk2uee.wl%tiwai@suse.de>
 <CAN8cciZEWPdKcX2J=16ry9UVoXZwasF7GfN9O4JGwJPx+0Y8zQ@mail.gmail.com>
 <s5h8v7s2tja.wl%tiwai@suse.de>
 <CA+S_cwowFrLAWSRiQvPX5AZwuyo9DdA4qS7Xn3bMYy=AzzpHdg@mail.gmail.com>
 <s5hvcaw18qf.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f180.google.com (mail-ie0-f180.google.com
 [209.85.223.180])
 by alsa0.perex.cz (Postfix) with ESMTP id D03032615D5
 for <alsa-devel@alsa-project.org>; Thu, 17 Jan 2013 10:24:45 +0100 (CET)
Received: by mail-ie0-f180.google.com with SMTP id c10so4463551ieb.11
 for <alsa-devel@alsa-project.org>; Thu, 17 Jan 2013 01:24:44 -0800 (PST)
In-Reply-To: <s5hvcaw18qf.wl%tiwai@suse.de>
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
Cc: Raymond Yau <superquad.vortex2@gmail.com>, basinilya@gmail.com, =?ISO-8859-1?Q?Manolo_D=EDaz?= <diaz.manolo@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 17, 2013 at 4:04 AM, Takashi Iwai <tiwai@suse.de> wrote:

>
> Yes, the plan is to merge the stuff to 3.9 kernel.
>
> But currently I'm not sure whether we can merge the whole patches.
> It's a fairly big change, and we need a bit more test coverage for
> codecs like Conexant, Cirrus and VIA.
> But, judging from your test result, we can merge the Analog codec
> patch, at least.
>
>
> thanks,
>
> Takashi
>

Meging the Analog codec soon will be certainly appreciated if it makes
sense for you.

Out of curiosity, with Indendent HP on, how can one send sound from, say,
vlc, to HP? Tried to google, but could not find the answer.

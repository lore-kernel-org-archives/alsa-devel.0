From: Curtis Malainey <cujomalainey@google.com>
Subject: Re: Merging the new firmware files for CA0132 into
	alsa-firmware
Date: Tue, 28 May 2019 09:46:25 -0700
Message-ID: <CAOReqxiVuVKSbKa8f_f_ZPewSVT+ib6iOW-jZsQJAaoyU7CxqA@mail.gmail.com>
References: <s5hblzmvdcq.wl-tiwai@suse.de>
 <9668d632-c5c9-5114-39cb-0e8a105a547c@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com
 [IPv6:2a00:1450:4864:20::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 32179F8072E
 for <alsa-devel@alsa-project.org>; Tue, 28 May 2019 18:46:40 +0200 (CEST)
Received: by mail-lj1-x244.google.com with SMTP id h19so9978495ljj.4
 for <alsa-devel@alsa-project.org>; Tue, 28 May 2019 09:46:40 -0700 (PDT)
In-Reply-To: <9668d632-c5c9-5114-39cb-0e8a105a547c@perex.cz>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>, Connor McAdams <conmanx360@gmail.com>, ALSA development <alsa-devel@alsa-project.org>, Pierre-louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Tue, May 28, 2019 at 9:39 AM Jaroslav Kysela <perex@perex.cz> wrote:
>
> Dne 28. 05. 19 v 16:54 Takashi Iwai napsal(a):
> > Hi,
> >
> > it seems that Connor's previous attempt to put a couple of ca0132
> > firmware files into linux-firmware tree didn't go through,
> > unfortunately.  And now I'm thinking of taking them into alsa-firmware
> > package as a stop-gap.  We already distribute other ca0132 firmware
> > files, so the addition shouldn't be a big problem.
> >
> > Jaroslav, what do you think?
>
> No problem. The same situation is for the SoC SOF firmware files (drivers are
> in kernel, firmware files are missing). Perhaps, we can release those files
> quickly in alsa-firmware and then migrate them slowly to linux-firmware.
>
>                                         Jaroslav
>
I have some firmware I need to add for the RT5677, should I also just
add this to alsa-firmware instead of straight into linux-firmware?
> --
> Jaroslav Kysela <perex@perex.cz>
> Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

From: Curtis Malainey <cujomalainey@google.com>
Subject: Re: Cannot build broadwell on for-5.3
Date: Tue, 28 May 2019 09:21:16 -0700
Message-ID: <CAOReqxgVdnkfst3Nabr6pFRrmeOmxVquPNjUHx4XtxQ3KY=afg@mail.gmail.com>
References: <CAOReqxjQAya8GQ4bOSBfTBHwXd38c33pOMc35rrSj4O4jMaMSQ@mail.gmail.com>
 <s5hwoii1rd3.wl-tiwai@suse.de>
 <6eb7cc4d-aa95-74b9-e849-22559737f47a@linux.intel.com>
 <CAOReqxjUk_6Fvc=CRnCWu7c=QvObxhwA_psWLz5gLO_v5Fc5Pg@mail.gmail.com>
 <CABXOdTePNR=O0EhUgFNVCUvCbqaKtpdnZw=NtFLc6aNtAWUpKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com
 [IPv6:2a00:1450:4864:20::141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 28760F8072E
 for <alsa-devel@alsa-project.org>; Tue, 28 May 2019 18:21:33 +0200 (CEST)
Received: by mail-lf1-x141.google.com with SMTP id b11so8658358lfa.5
 for <alsa-devel@alsa-project.org>; Tue, 28 May 2019 09:21:33 -0700 (PDT)
In-Reply-To: <CABXOdTePNR=O0EhUgFNVCUvCbqaKtpdnZw=NtFLc6aNtAWUpKg@mail.gmail.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Guenter Roeck <groeck@google.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Dylan Reid <dgreid@google.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Mon, May 27, 2019 at 10:24 AM Guenter Roeck <groeck@google.com> wrote:
>
> FWIW, the Linux kernel still officially supports our version of gcc
> (4.9.4, I believe). "Your version of gcc is too old" is not a good
> argument to make.
>
> Guenter
>
IIRC, we are running modified 4.9.2, stock 4.9.2 works fine but for
some reason ours doesn't. It was not a "this is broken and that is
that" it was more a "oh, this is the issue, I am going to take this
offline now." I am in contact with the author who broke us who happens
to be another googler and he is looking into what is going on. The
short term fix is to revert 392bef709659abea614abfe53cf228e7a59876a4
on whatever branch you are working on.

Curtis

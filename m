From: Simon Derr <ddrsimon@gmail.com>
Subject: Re: snd-hda-intel : issues with mic boost on ALC3236
Date: Thu, 21 May 2015 16:00:02 +0200
Message-ID: <CAP1KSYezQVk7e-zs6OaAPF-HGUCM-jHc8kv4=qT13dvcjh2P_w@mail.gmail.com>
References: <CAP1KSYf_wsief6OCx8hMta5Bq0zN8meCzfxkyjt2ab8hXettMg@mail.gmail.com>
 <s5h618e92w5.wl-tiwai@suse.de>
 <CAP1KSYfB8Gk6kQG0XdJdj7+92WHN5cVHjdzJgA5VFq5gZ3SvXA@mail.gmail.com>
 <s5hy4la6vgn.wl-tiwai@suse.de>
 <6FAB7C47BCF00940BB0999A99BE3547A17A0F7BA@RTITMBSV09.realtek.com.tw>
 <CAP1KSYcsp5JsAJJjHetvAaLr3J4Syhe7t0TuhEm-quTjSc2OiQ@mail.gmail.com>
 <CAP1KSYcYSn53Q1ivK9Kxi7G03P71vNWSzdPA6Nagscd=x=iuTw@mail.gmail.com>
 <s5hbni4kbxb.wl-tiwai@suse.de>
 <CAP1KSYfwo+O0vo3raRFn8VzB1szWT+CQjYictkwkUuv_ZxLLnQ@mail.gmail.com>
 <CAP1KSYfpP+Q8=xEteLXh6fia2=tSUe2+WYb_pgDkoead_hD3uQ@mail.gmail.com>
 <s5hiobp131c.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f174.google.com (mail-wi0-f174.google.com
 [209.85.212.174])
 by alsa0.perex.cz (Postfix) with ESMTP id 83ABE261483
 for <alsa-devel@alsa-project.org>; Thu, 21 May 2015 16:00:23 +0200 (CEST)
Received: by wibt6 with SMTP id t6so15015792wib.0
 for <alsa-devel@alsa-project.org>; Thu, 21 May 2015 07:00:23 -0700 (PDT)
In-Reply-To: <s5hiobp131c.wl-tiwai@suse.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, May 19, 2015 at 8:42 AM, Takashi Iwai <tiwai@suse.de> wrote:

> Maybe the pin setup for Dell multi headset doesn't match with yours.
> There are a few other headset quirks, but they aren't exposed as
> selectable via model option.  You need to patch the kernel.
>
> For example, below is to use ALC269_FIXUP_HEADSET_MODE_NO_HP_MIC for
> your device.  Does it work better?

Hello Takashi,

Unfortunately, I cannot test your patch.
I got rid of that laptop, there were just too many issues with it.
Thanks anyway,

  Simon

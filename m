From: Catalin Iacob <iacobcatalin@gmail.com>
Subject: Re: [PATCH] ALSA: hda_intel: add position_fix quirk
	for Asus K53E
Date: Mon, 10 Sep 2012 22:48:18 +0200
Message-ID: <CAHg_5gpaN9P08eo8Np6b2vAwmvtxPkrbGUz5tWFr=TjndscZeA@mail.gmail.com>
References: <1347226871-2552-1-git-send-email-iacobcatalin@gmail.com>
 <s5hy5kitgxq.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f51.google.com (mail-ee0-f51.google.com [74.125.83.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 3E306260744
 for <alsa-devel@alsa-project.org>; Mon, 10 Sep 2012 22:48:39 +0200 (CEST)
Received: by eeke50 with SMTP id e50so1257703eek.38
 for <alsa-devel@alsa-project.org>; Mon, 10 Sep 2012 13:48:39 -0700 (PDT)
In-Reply-To: <s5hy5kitgxq.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Seth Heasley <seth.heasley@intel.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 10, 2012 at 10:34 AM, Takashi Iwai <tiwai@suse.de> wrote:
> What sound backend are you using?  PulseAudio?
PulseAudio yes.

> Also, setting bdl_pos_adj=0 option makes any difference?
No, the artifacts are still present.

The artifacts appear only with some applications, for example VLC and
Skype have them but KDE's startup sound and music played in Amarok
don't. The artifacts also go away after around 10 - 30 seconds of
playback and happen again for some tens of seconds after restarting
the application.

The alsa-info output is available at [1] for the working case and [2]
for the broken case.

[1] http://www.alsa-project.org/db/?f=005f377cccf46c8093c4a640ace396313ffd8102
[2] http://www.alsa-project.org/db/?f=b274a421ab04dab698b5d4d585dc7dbef06f7764

Does this help? Thanks,
Catalin

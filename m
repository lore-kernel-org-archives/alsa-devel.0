From: Miro Hodak <mhodak127@gmail.com>
Subject: Re: HD-audio regression after commit
	34588709af61be1550b4e2bcee5c85d0ac4f34d4
Date: Tue, 22 Jan 2013 03:14:10 -0500
Message-ID: <CA+S_cwpfjzF1mgabs-maKB4A=Q0tH81OxfJg+a1qjVo=Vyh0Mw@mail.gmail.com>
References: <CA+S_cwraM+wofw5Nz_d0ctOget5dY-0nr5pRHCzOJtLX+JM2TA@mail.gmail.com>
 <s5hlibs154t.wl%tiwai@suse.de>
 <CA+S_cwoLe=2tUr=EyFM0TxvbBaB12DCE2yDPwf3OzoRcO8jQug@mail.gmail.com>
 <CAN8cciama4q0EOiUsjp-KyyzehcvjwmdPdBQ9vsitbnR8g1PgA@mail.gmail.com>
 <CA+S_cwrmHguxk6WBxjAJTOaV8xV-4PH0gkpibFKs1P8bRxAsAg@mail.gmail.com>
 <s5hfw1zomf2.wl%tiwai@suse.de> <20130117191224.44794728@gmail.com>
 <s5hfw1z1s6a.wl%tiwai@suse.de> <20130117214043.5a1574ee@gmail.com>
 <s5h7gnb0y5z.wl%tiwai@suse.de>
 <CA+S_cwqE6AgcVjp+wtPuJA_AcJqUvL0Ocoq_QA5JVWQVYCsYSg@mail.gmail.com>
 <20130118090839.4a0725f8@gmail.com>
 <CA+S_cwoKMERXHR14t4WK0Him=bjcRQQPJH+tX6BHyeBUv9tntg@mail.gmail.com>
 <s5hy5fqztge.wl%tiwai@suse.de> <20130118133753.3eabbb18@gmail.com>
 <s5hr4limwj2.wl%tiwai@suse.de>
 <CAN8ccibdPa+wOD99cY1sxfK0MSbUeL0MA6emiPCb93u3KMmrSg@mail.gmail.com>
 <s5hbocmmrtu.wl%tiwai@suse.de> <20130118174823.4795313b@gmail.com>
 <s5hmww6l96r.wl%tiwai@suse.de> <20130118185115.442a3d97@gmail.com>
 <20130118192047.403f52d0@gmail.com> <s5hr4liz5xi.wl%tiwai@suse.de>
 <CA+S_cwrH6mjunDsn2w76Vpyk7XovOKpH0k_KoU_8SXjmisLAYw@mail.gmail.com>
 <s5hhamdzau9.wl%tiwai@suse.de>
 <CA+S_cwqzWHf92zXj3gFHHB+SAr_7o=Z+70FMh39nKoxzvBXZRA@mail.gmail.com>
 <s5h8v7nymn7.wl%tiwai@suse.de>
 <CA+S_cwrxC3=_H-yzr166ZJQ1GqHZMUVqX3WFB6L_wcOOjC23BA@mail.gmail.com>
 <CAN8cciY0wv4Nn9SAMzDxDUSRtp4ab_sdQyOch+p27i64SakmaQ@mail.gmail.com>
 <CA+S_cwpvUJE3wqwgFGwFK2PLhdQAdQmEVNAfva2_DOW9XdWcAg@mail.gmail.com>
 <s5h38xuigw4.wl%tiwai@suse.de>
 <CA+S_cwpQE-jdmcy5c3Qm_JVdNkDsAfuTq-u-BxGF-qJVtrJfTA@mail.gmail.com>
 <CA+S_cwre+fJVdHhQv8gFUHXErMyZOkuMUYUVs2ZEXU0kVTH+CA@mail.gmail.com>
 <s5hfw1u2so6.wl%tiwai@suse.de> <s5ha9s13dg0.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ia0-f178.google.com (mail-ia0-f178.google.com
 [209.85.210.178])
 by alsa0.perex.cz (Postfix) with ESMTP id 01A5D265016
 for <alsa-devel@alsa-project.org>; Tue, 22 Jan 2013 09:14:13 +0100 (CET)
Received: by mail-ia0-f178.google.com with SMTP id y26so3167881iab.9
 for <alsa-devel@alsa-project.org>; Tue, 22 Jan 2013 00:14:11 -0800 (PST)
In-Reply-To: <s5ha9s13dg0.wl%tiwai@suse.de>
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

On Tue, Jan 22, 2013 at 2:05 AM, Takashi Iwai <tiwai@suse.de> wrote:

> At Mon, 21 Jan 2013 21:21:45 +0100,
> Takashi Iwai wrote:
>


> The patch is below, already merged in test/hda-gen-parser branch (and
> test/hda-migrate and master branch, too), as usual.
>
>
> Takashi
>
> ---
> From: Takashi Iwai <tiwai@suse.de>
> Subject: [PATCH] ALSA: hda - Disable HP auto-mute during independent HP
> mode
>
> Both the HP auto-mute and the independent HP mode conflict with each
> other.  Make HP auto-mute disabled (only for the affected HP jack)
> during the driver is in HP independent mode.
>
> How is this supposed to work? I upgraded my kernel, and with Independent
HP on Auto-Mute can still be switched on or off in alsamixer.

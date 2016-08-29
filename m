From: Akshay Bhat <akshay.bhat@timesys.com>
Subject: Re: [PATCH] ALSA: usb-audio: Add sample rate inquiry quirk for B850V3 CP2114
Date: Mon, 29 Aug 2016 10:10:03 -0400
Message-ID: <CACrMeVBgQS4je7ny_r83Xi-7yX-AzR2YVT_gHyp5U7m2LpFoyA@mail.gmail.com>
References: <1471025327-3529-1-git-send-email-akshay.bhat@timesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1471025327-3529-1-git-send-email-akshay.bhat@timesys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz
Cc: tiwai@suse.com, gtmkramer@xs4all.nl, denk@post.com, guillaume@eulerian.com, vdronov@redhat.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Ken Lin <ken.lin@advantech.com.tw>, Akshay Bhat <akshay.bhat@timesys.com>
List-Id: alsa-devel@alsa-project.org

Hi,

On Fri, Aug 12, 2016 at 2:08 PM, Akshay Bhat <akshay.bhat@timesys.com> wrote:
> From: Ken Lin <ken.lin@advantech.com.tw>
>
> Avoid getting sample rate on B850V3 CP2114 as it is unsupported and
> causes noisy "current rate is different from the runtime rate" messages
> when playback starts.
>
> Signed-off-by: Ken Lin <ken.lin@advantech.com.tw>
> Signed-off-by: Akshay Bhat <akshay.bhat@timesys.com>
> ---

Any feedback on the patch? If not can it be applied? Thanks.

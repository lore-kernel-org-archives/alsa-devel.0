From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [pulseaudio-discuss] [PATCH 2/4] alsa-mixer: Add
	Phantom Jack support
Date: Fri, 29 Jun 2012 08:27:15 +0800
Message-ID: <CAN8cciY9YvKNg3Jp-K_QB9OsKDQPgoos4rG3SLaWjCHKDbBBiQ@mail.gmail.com>
References: <1340893627-15097-1-git-send-email-david.henningsson@canonical.com>
	<1340893627-15097-2-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f179.google.com (mail-wi0-f179.google.com
	[209.85.212.179])
	by alsa0.perex.cz (Postfix) with ESMTP id AF18910B9F9
	for <alsa-devel@alsa-project.org>;
	Fri, 29 Jun 2012 02:27:16 +0200 (CEST)
Received: by wibhq4 with SMTP id hq4so505500wib.2
	for <alsa-devel@alsa-project.org>; Thu, 28 Jun 2012 17:27:16 -0700 (PDT)
In-Reply-To: <1340893627-15097-2-git-send-email-david.henningsson@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: General PulseAudio Discussion <pulseaudio-discuss@lists.freedesktop.org>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2012/6/28 David Henningsson <david.henningsson@canonical.com>:
> For kernel 3.6, "phantom jack" kctls have been added. They serve as
> a marker that a particular port exist. They were made so we can detect
> that there actually are speakers and internal mic on a laptop, even if
> there are no other indications (volume controls etc).
>
> Signed-off-by: David Henningsson <david.henningsson@canonical.com>
> ---

It seem that there will be numerous phantom ports created

e.g. two internal mic phantom ports, spdif and spdif in, cd on the
intel d975 desktop

./hda-emu codecs/stac9274d-intel-d975


CTRL: add: Front Headphone Jack:0
JACK created Front Headphone, type 1
JACK report Front Headphone, status 0
CTRL: add: Front Mic Jack:0
JACK created Front Mic, type 2
JACK report Front Mic, status 0
CTRL: add: Rear Mic Jack:0
JACK created Rear Mic, type 2
JACK report Rear Mic, status 0
CTRL: add: Internal Mic Phantom Jack:0
CTL Notify: Internal Mic Phantom Jack:0, mask=1
CTRL: add: Internal Mic Phantom Jack:1
CTL Notify: Internal Mic Phantom Jack:1, mask=1
CTRL: add: Line Jack:0
JACK created Line, type 32
JACK report Line, status 0
CTRL: add: CD Phantom Jack:0
CTL Notify: CD Phantom Jack:0, mask=1
CTRL: add: SPDIF Phantom Jack:0
CTL Notify: SPDIF Phantom Jack:0, mask=1
CTRL: add: SPDIF In Phantom Jack:0
CTL Notify: SPDIF In Phantom Jack:0, mask=1

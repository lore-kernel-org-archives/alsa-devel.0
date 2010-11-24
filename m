From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: [PATCHES] Integrate minimal systemd support in
	alsa-utils
Date: Wed, 24 Nov 2010 12:04:19 +0100
Message-ID: <AANLkTimVfV3W5_s_ndZgfyrbbFQiMdzbmceL_=m1i4oT@mail.gmail.com>
References: <20101123021657.GA17275@tango.0pointer.de>
	<s5h4ob8r2dz.wl%tiwai@suse.de>
	<AANLkTikbP_yRSDWD1DL0EKza=EpRdnDHLpUMhoXVnDiE@mail.gmail.com>
	<s5h1v6bp9dv.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 0A5DC245DA
	for <alsa-devel@alsa-project.org>; Wed, 24 Nov 2010 12:05:07 +0100 (CET)
Received: by gyg8 with SMTP id 8so923895gyg.38
	for <alsa-devel@alsa-project.org>; Wed, 24 Nov 2010 03:05:07 -0800 (PST)
In-Reply-To: <s5h1v6bp9dv.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, jkysela@redhat.com, Lennart Poettering <mznyfn@0pointer.de>
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 24, 2010 at 06:40, Takashi Iwai <tiwai@suse.de> wrote:
> At Tue, 23 Nov 2010 18:05:00 +0100, Kay Sievers wrote:

>> All the naming rules for the snd/ subdir can be removed on all recent
>> systems, only the GROUP="audio" is needed.
>>
>> No rules files should be installed in /etc, all files from packages
>> belong into /lib.
>
> OK.

Just noticed, that we have the GROUP="audio" stuff already in the main
udev package. I think 40-alsa.rules can just go.

Thanks,
Kay

From: pl bossart <bossart.nospam@gmail.com>
Subject: Re: [PATCH] ALSA: HDA: Add jack detection for HDMI
Date: Tue, 17 May 2011 12:09:47 -0500
Message-ID: <BANLkTi=H8sqtf-5TvsKjQF8RA1bxBAfEWA@mail.gmail.com>
References: <4DD27C43.3050509@canonical.com>
	<74CDBE0F657A3D45AFBB94109FB122FF04986AAA0D@HQMAIL01.nvidia.com>
	<s5haael5mzb.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) by alsa0.perex.cz (Postfix) with ESMTP id 0B061245AA
	for <alsa-devel@alsa-project.org>;
	Tue, 17 May 2011 19:09:47 +0200 (CEST)
Received: by ewy6 with SMTP id 6so220882ewy.38
	for <alsa-devel@alsa-project.org>; Tue, 17 May 2011 10:09:47 -0700 (PDT)
In-Reply-To: <s5haael5mzb.wl%tiwai@suse.de>
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
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Stephen Warren <swarren@nvidia.com>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

>> a) Is it possible to report more information alongside the plug events,
>> such as ELD/EDID content? Or, is the idea that the kernel sends a plug
>> event, and then user-space retrieves that information via some other
>> API? I don't think there's an API to retrieve ELD information at present
>> though right? Although certainly it'd make sense for that to be a
>> completely separate patch.
>
> A simple approach would be adding a control element containing
> byte-array of ELD/EDID.

Are there any examples of such controls? Or are we talking about a new
kind of control?
We could really use this ELD information in PulseAudio now that the
passthrough mode is in git master; for now the codecs supported by the
receiver are hard-coded, not a very reliable solution...
-Pierre

From: Daniel Chen <seven.steps@gmail.com>
Subject: Re: [PATCH] alsactl init: Add db entry for Compaq
	nx6110 quirk
Date: Mon, 13 Sep 2010 07:56:55 -0400
Message-ID: <AANLkTi=VCj8So4HC5J32V1xjQyr7Lf9N1fMF0RY1dAhQ@mail.gmail.com>
References: <AANLkTi=Vq5b_hOSgYC7U4VuhYPyUSE36H9NEsHPMSDjT@mail.gmail.com>
	<s5hr5gymbav.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id 8202224371
	for <alsa-devel@alsa-project.org>;
	Mon, 13 Sep 2010 13:56:55 +0200 (CEST)
Received: by wyb32 with SMTP id 32so5991747wyb.38
	for <alsa-devel@alsa-project.org>; Mon, 13 Sep 2010 04:56:55 -0700 (PDT)
In-Reply-To: <s5hr5gymbav.wl%tiwai@suse.de>
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
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 13, 2010 at 2:01 AM, Takashi Iwai <tiwai@suse.de> wrote:
> Actually such a device should be in ad1981_jacks_whitelist[] in
> ac97_patch.c...

Right, its SSID (0x103c099c) is already listed in
ad1981_jacks_whitelist[].  Is there somewhere else we should be
checking, too?

Best,
-Dan

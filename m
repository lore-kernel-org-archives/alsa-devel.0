From: Daniel Drake <dsd@laptop.org>
Subject: Re: [PATCH] ALSA: hda - Add CX20582 and OLPC XO-1.5
 support
Date: Thu, 16 Jul 2009 14:59:56 +0100
Message-ID: <1247752796.2197.21.camel@polyethylene>
References: <20090716134657.C13969D405C@zog.reactivated.net>
	<s5hskgwn38s.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f222.google.com (mail-ew0-f222.google.com
	[209.85.219.222])
	by alsa0.perex.cz (Postfix) with ESMTP id 5429610388E
	for <alsa-devel@alsa-project.org>;
	Thu, 16 Jul 2009 16:00:02 +0200 (CEST)
Received: by ewy22 with SMTP id 22so147612ewy.32
	for <alsa-devel@alsa-project.org>; Thu, 16 Jul 2009 07:00:01 -0700 (PDT)
In-Reply-To: <s5hskgwn38s.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, devel@lists.laptop.org
List-Id: alsa-devel@alsa-project.org

On Thu, 2009-07-16 at 15:53 +0200, Takashi Iwai wrote:
> At Thu, 16 Jul 2009 14:46:57 +0100 (BST),
> Daniel Drake wrote:
> > 
> > This adds support for the Conexant CX20582 codec, based on code from
> > http://www.linuxant.com/alsa-driver/alsa-driver-linuxant-1.0.19ppch12-1.noarch.rpm.zip
> > 
> > This is the codec to be shipped in the OLPC XO-1.5, so this patch also
> > includes an XO-specific profile. Resultant configuration:
> > http://dev.laptop.org/~dsd/20090713/codec0.txt
> > http://dev.laptop.org/~dsd/20090713/codec0.svg
> > 
> > As the Linuxant code is structured differently to the other codecs,
> > I was unable to cleanly reimplement everything in the generic and Dell
> > profiles as more info is needed (e.g. codec graphs). I simplified those
> > profiles so that hopefully it will not break anyone's audio. If it does,
> > it may be worth returning -ENODEV from patch_cx5066 on non-OLPC systems,
> > and then fixing snd_hda_codec_configure() to fall back on the generic
> > parser, at least until support for other systems is figured out.
> 
> The patch looks OK.  Could you give your sign-off?

Sorry, forgot.

Signed-off-by: Daniel Drake <dsd@laptop.org>

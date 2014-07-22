From: Daniel Drake <drake@endlessm.com>
Subject: Re: [PATCH] ALSA: hda - Add mic fixup for Gigabyte
	BXBT-2807
Date: Tue, 22 Jul 2014 11:29:51 +0100
Message-ID: <CAD8Lp47W+vpKUNmzryg6dJGXENd_KuBq0o3yYNv9dcuQ9KjAWg@mail.gmail.com>
References: <1406023109-30864-1-git-send-email-drake@endlessm.com>
 <s5hegxdn0wv.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f41.google.com (mail-wg0-f41.google.com [74.125.82.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 14E812654E4
 for <alsa-devel@alsa-project.org>; Tue, 22 Jul 2014 12:29:52 +0200 (CEST)
Received: by mail-wg0-f41.google.com with SMTP id z12so7794555wgg.0
 for <alsa-devel@alsa-project.org>; Tue, 22 Jul 2014 03:29:51 -0700 (PDT)
In-Reply-To: <s5hegxdn0wv.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 22, 2014 at 11:27 AM, Takashi Iwai <tiwai@suse.de> wrote:
> The overwritten value looks like the jack-detectable.  Is it really
> so?  Many headset jacks don't give the jack detection in the mic pin
> but relies on the headphone pin jack detection or use vendor-specific
> way.

"hda-jack-sense-test -a" correctly shows the mic as present when the
headset is connected, and shows "Not present" when nothing is
connected, or when speakers are connected. Is this enough to confirm
that jack sense is working?

Thank
Daniel

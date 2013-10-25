From: Andre Heider <a.heider@gmail.com>
Subject: Re: [PATCH v3 0/5] ALSA: hda - hdmi: ATI/AMD
 multi-channel and HBR support
Date: Fri, 25 Oct 2013 20:25:52 +0200
Message-ID: <20131025182551.GA89926@deflower.internal>
References: <1382638238-25055-1-git-send-email-anssi.hannula@iki.fi>
 <s5hli1imfsi.wl%tiwai@suse.de>
 <20131025165452.GA89428@deflower.internal>
 <526AA924.5070508@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ea0-f177.google.com (mail-ea0-f177.google.com
 [209.85.215.177])
 by alsa0.perex.cz (Postfix) with ESMTP id 2BB7B2616E4
 for <alsa-devel@alsa-project.org>; Fri, 25 Oct 2013 20:25:58 +0200 (CEST)
Received: by mail-ea0-f177.google.com with SMTP id f15so852455eak.8
 for <alsa-devel@alsa-project.org>; Fri, 25 Oct 2013 11:25:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <526AA924.5070508@iki.fi>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Anssi Hannula <anssi.hannula@iki.fi>
Cc: Takashi Iwai <tiwai@suse.de>, Olivier Langlois <olivier@trillion01.com>, alsa-devel@alsa-project.org, Peter =?iso-8859-1?Q?Fr=FChberger?= <fritsch@xbmc.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 25, 2013 at 08:23:48PM +0300, Anssi Hannula wrote:
> 25.10.2013 19:54, Andre Heider kirjoitti:
> > cat /proc/asound/card0/eld\#0.0
> > 	monitor_present		1
> > 	eld_valid		0
> 
> However, this should have eld_valid=1 and contain more info. To get a
> hint on whether it is a bug in audio or video driver, could you give a
> log with CONFIG_SND_DEBUG ?
> 
> AFAICS the sound git master tree should have the necessary support in
> the radeon video driver to allow the audio driver to generate a valid
> ELD with your card.

I'm away from that box now, but will give that a try next week.

Regards,
Andre

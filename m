From: Eldad Zack <eldad@fogrefinery.com>
Subject: Re: [PATCH 07/10] ALSA: usb-audio: UAC2: try to find
 and switch to valid clock
Date: Tue, 2 Apr 2013 22:20:36 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1304022218280.1104@xoschi>
References: <1364745152-1762-1-git-send-email-eldad@fogrefinery.com>
 <1364745152-1762-8-git-send-email-eldad@fogrefinery.com>
 <s5hvc858glk.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f48.google.com (mail-bk0-f48.google.com
 [209.85.214.48])
 by alsa0.perex.cz (Postfix) with ESMTP id 18FC4265253
 for <alsa-devel@alsa-project.org>; Tue,  2 Apr 2013 22:20:41 +0200 (CEST)
Received: by mail-bk0-f48.google.com with SMTP id jf3so424066bkc.35
 for <alsa-devel@alsa-project.org>; Tue, 02 Apr 2013 13:20:41 -0700 (PDT)
In-Reply-To: <s5hvc858glk.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Daniel Mack <zonque@gmail.com>, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org


On Tue, 2 Apr 2013, Takashi Iwai wrote:

> At Sun, 31 Mar 2013 17:52:29 +0200,
> Eldad Zack wrote:
> > 
> > If a selector is available on a device, it may be pointing to a
> > clock source which is currently invalid.
> > If there is a valid clock source which can be selected, switch
> > to it.
> > 
> > Signed-off-by: Eldad Zack <eldad@fogrefinery.com>
> > ---
> >  sound/usb/clock.c | 65 +++++++++++++++++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 63 insertions(+), 2 deletions(-)
> > 
> > diff --git a/sound/usb/clock.c b/sound/usb/clock.c
> > index 08fa345..6b79e25 100644
> > --- a/sound/usb/clock.c
> > +++ b/sound/usb/clock.c
> > @@ -99,6 +99,40 @@ static int uac_clock_selector_get_val(struct snd_usb_audio *chip, int selector_i

> > +	buf = uac_clock_selector_get_val(chip, selector_id);
> > +	if (buf != pin) {
> 
> uac_clock_selector_get_val() returns an int with a negative value,
> so it's safer to compare it as an int.

Right, and I need to return the error code, too. Thanks!

Cheers,
Eldad

From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: snd_mixer_selem_get_playback_volume return value
	outside allowed range
Date: Tue, 22 Jun 2010 09:41:17 +0800
Message-ID: <AANLkTinnNh_oU3jQ5PqDoHDMICTLKdJw05hPddJKrAiY@mail.gmail.com>
References: <AANLkTikQ5cUjiAtVWhLaR348-eF3xzPFoBkfmEdefJU8@mail.gmail.com>
	<4C1A2A9C.3000902@ladisch.de>
	<AANLkTimF2iotSHsjFQFtHYo89yuXZRcYvHNvJm79g4Dw@mail.gmail.com>
	<hvhu14$cov$2@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 1658B103885
	for <alsa-devel@alsa-project.org>;
	Tue, 22 Jun 2010 03:41:19 +0200 (CEST)
Received: by vws20 with SMTP id 20so1423838vws.38
	for <alsa-devel@alsa-project.org>; Mon, 21 Jun 2010 18:41:17 -0700 (PDT)
In-Reply-To: <hvhu14$cov$2@dough.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2010/6/19 Colin Guthrie <gmane@colin.guthr.ie>

> 'Twas brillig, and Raymond Yau at 19/06/10 03:39 did gyre and gimble:
> > 2010/6/17 Clemens Ladisch <clemens@ladisch.de>
> >
> >> Raymond Yau wrote:
> >>> Should snd_mixer_selem_get_playback_volume() perform range check ?
> >>
> >> No, it's the responsibility of the control implementation to return
> >> valid values (and to check that values that are being set are valid).
> >>
> >>
> >> Regards,
> >> Clemens
> >> _
>


It is OK to clamp the volume so that the volume bar would not distort the
layout

but the display percentage under the volume bar is clamp to 100% and this
will mislead the user that alsamixer hangs since pressing up and down arrow
cannot change 100% to 101% or 100% to 90% ( displayed percentage remain at
100% for a very long time)

        value = ((volumes[0] - min) * 100 + (max - min) / 2) / (max - min);
        if (!(control->flags & HAS_VOLUME_1)) {
            sprintf(buf, "%d", value);
            display_string_in_field(values_y, frame_left - 2, buf, 8,
ALIGN_CENTER);
        } else {
            mvwprintw(mixer_widget.window, values_y, frame_left - 2, "%3d",
value);
            if (control->flags & IS_ACTIVE)
                wattrset(mixer_widget.window, attr_ctl_frame);
            waddstr(mixer_widget.window, "<>");
            if (control->flags & IS_ACTIVE)
                wattrset(mixer_widget.window, attr_mixer_active);
            value = ((volumes[1] - min) * 100 + (max - min) / 2) / (max -
min);
            wprintw(mixer_widget.window, "%-3d", value);
        }

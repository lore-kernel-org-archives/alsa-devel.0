From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: hda_codec_ops hotplug events
Date: Thu, 16 Dec 2010 14:53:43 +0800
Message-ID: <AANLkTi=7NUmj9Ju3YeBL7N7Z2+zYTN-tqtaVT8wdvXuP@mail.gmail.com>
References: <AANLkTikH=yugqEBKgMH8j=si63cby9X37gwq069Q5VDC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 4148524456
	for <alsa-devel@alsa-project.org>; Thu, 16 Dec 2010 07:53:44 +0100 (CET)
Received: by eyg24 with SMTP id 24so1612062eyg.24
	for <alsa-devel@alsa-project.org>; Wed, 15 Dec 2010 22:53:43 -0800 (PST)
In-Reply-To: <AANLkTikH=yugqEBKgMH8j=si63cby9X37gwq069Q5VDC@mail.gmail.com>
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

2010/12/15 James Courtier-Dutton <james.dutton@gmail.com>

> static struct hda_codec_ops intel_hdmi_patch_ops = {
>        .init                   = intel_hdmi_init,
>        .free                   = intel_hdmi_free,
>        .build_pcms             = intel_hdmi_build_pcms,
>        .build_controls         = intel_hdmi_build_controls,
>        .unsol_event            = hdmi_unsol_event,
> };
>
> What calls .unsol_event ?
>
> It need something to cause this function to be executed.
> I cannot seem to find out what calls this.
>

In hda_codec.


static void process_unsol_events(struct work_struct *work)
{
.....
        if (codec && codec->patch_ops.unsol_event)
            codec->patch_ops.unsol_event(codec, res);

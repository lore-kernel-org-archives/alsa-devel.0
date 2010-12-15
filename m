From: James Courtier-Dutton <james.dutton@gmail.com>
Subject: hda_codec_ops hotplug events
Date: Wed, 15 Dec 2010 15:52:59 +0000
Message-ID: <AANLkTikH=yugqEBKgMH8j=si63cby9X37gwq069Q5VDC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qw0-f51.google.com (mail-qw0-f51.google.com
	[209.85.216.51]) by alsa0.perex.cz (Postfix) with ESMTP id EEC652451D
	for <alsa-devel@alsa-project.org>; Wed, 15 Dec 2010 16:52:59 +0100 (CET)
Received: by qwj8 with SMTP id 8so2084231qwj.38
	for <alsa-devel@alsa-project.org>; Wed, 15 Dec 2010 07:52:59 -0800 (PST)
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

static struct hda_codec_ops intel_hdmi_patch_ops = {
        .init                   = intel_hdmi_init,
        .free                   = intel_hdmi_free,
        .build_pcms             = intel_hdmi_build_pcms,
        .build_controls         = intel_hdmi_build_controls,
        .unsol_event            = hdmi_unsol_event,
};

What calls .unsol_event ?

It need something to cause this function to be executed.
I cannot seem to find out what calls this.

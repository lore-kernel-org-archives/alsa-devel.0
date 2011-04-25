From: pl bossart <bossart.nospam@gmail.com>
Subject: soc-dsp questions
Date: Mon, 25 Apr 2011 17:01:12 -0500
Message-ID: <BANLkTi=jmoZOvxe=29Et=C6YYHrFZ58evw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 83007245D4
	for <alsa-devel@alsa-project.org>;
	Tue, 26 Apr 2011 00:01:13 +0200 (CEST)
Received: by eyg5 with SMTP id 5so14454eyg.38
	for <alsa-devel@alsa-project.org>; Mon, 25 Apr 2011 15:01:13 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

To prepare next week's ALSA-Asoc meeting, I reviewed Liam's
dsp-upstream code, and I am a bit unclear on the 'no_host_mode'
supported by some DAIs. Apparently these are regular ALSA PCM
substreams, except that there are no data exchanges to/from the host.
- If these substreams are known, an application can in theory
open/close them. How would it know that no data is to be written/read?
I would think additional changes are required in alsa-lib?
- is this really important that such PCM devices be known in
userspace? Or are they declared only so that ALSA controls are enabled
for these streams?
- along the same lines, how useful is the .pointer routine for such
devices? Since no data will be provided by the host, is this really
needed? I see it's only meaningful for the low-power playback mode,
but I am unsure if the information provided would actually be used by
anyone?
- what is the meaning of the SND_SOC_DAI_LINK_OPT_HOST definition? It
doesn't seem to be updated depending on which back-end is used, so it
this really needed?
Thanks
-Pierre

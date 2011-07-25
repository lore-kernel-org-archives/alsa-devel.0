From: pl bossart <bossart.nospam@gmail.com>
Subject: HDAudio period/buffer sizes
Date: Mon, 25 Jul 2011 18:47:38 -0500
Message-ID: <CABGFaBtLnbeHHYc4=oO=skmpiAZ3dpqWbavN8JYM-NLuVGovUg@mail.gmail.com>
Reply-To: pierre-louis.bossart@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id CBB2D243EF
	for <alsa-devel@alsa-project.org>;
	Tue, 26 Jul 2011 01:47:38 +0200 (CEST)
Received: by wwj26 with SMTP id 26so3484494wwj.20
	for <alsa-devel@alsa-project.org>; Mon, 25 Jul 2011 16:47:38 -0700 (PDT)
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
List-Id: alsa-devel@alsa-project.org

When I look at the HDAudio spec, I see that the BDL entries need to be
aligned on a 128-byte boundary, but the buffer length can be any value.
When I look at the HDAudio driver (azx_pcm_open in hda_codec.c), I see
that we enforce a 128-byte granularity on the period/buffer sizes, but
this was added in a patch that fixed alignment issues (5f1545bc)

Any technical reason why the driver is more demanding than the spec? Or
is this a confusion between alignment and buffer size? I can understand
that rounding to multiple of 128 bytes would be more efficient in terms
of data access, but it also prevents applications from getting an
interrupt when they want (eg it's impossible to use 20ms periods with a
44.1kHz sampling rate, you'll get 19.59 or 20.31ms).

Thanks,
-Pierre

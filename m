From: Dan Carpenter <error27@gmail.com>
Subject: bug report: aloop: potential signedness bug in
	loopback_prepare()
Date: Sat, 9 Oct 2010 13:42:18 +0200
Message-ID: <20101009114218.GQ11681@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id 6B2B924405
	for <alsa-devel@alsa-project.org>;
	Sat,  9 Oct 2010 13:42:38 +0200 (CEST)
Received: by wyb32 with SMTP id 32so659974wyb.38
	for <alsa-devel@alsa-project.org>; Sat, 09 Oct 2010 04:42:36 -0700 (PDT)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Jaroslav,

sound/drivers/aloop.c +287 loopback_prepare(10)
	warn: bogus compare against zero: 'bps'
   282          unsigned int bps, salign;
   283
   284          salign = (snd_pcm_format_width(runtime->format) *
   285							runtime->channels) / 8;
   286          bps = salign * runtime->rate;
   287          if (bps <= 0 || salign <= 0)
                    ^^^^^^^^^^^^^^^^^^^^^^^

	Both "bps" and "salign" are unsigned and are never less than
	zero.  Should this just be checking for == 0?  Or was the check
	supposed to catch integer overflows?

   288                  return -EINVAL;
   289

regards,
dan carpenter

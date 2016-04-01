From: Anatol Pomozov <anatol.pomozov@gmail.com>
Subject: Re: [PATCH] a52: Make compatible with ffmpeg 3.0
Date: Fri, 1 Apr 2016 11:47:38 -0700
Message-ID: <CAOMFOmWD2gm3XH-MzDdLrrNuaOy0rqevzn7Az24y6Uj2xedfow@mail.gmail.com>
References: <1455587362-7366-1-git-send-email-anatol.pomozov@gmail.com>
 <s5hr3gb4or2.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ig0-f171.google.com (mail-ig0-f171.google.com
 [209.85.213.171])
 by alsa0.perex.cz (Postfix) with ESMTP id 03629265173
 for <alsa-devel@alsa-project.org>; Fri,  1 Apr 2016 20:47:40 +0200 (CEST)
Received: by mail-ig0-f171.google.com with SMTP id ma7so3029755igc.0
 for <alsa-devel@alsa-project.org>; Fri, 01 Apr 2016 11:47:39 -0700 (PDT)
In-Reply-To: <s5hr3gb4or2.wl-tiwai@suse.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, David Henningsson <david.henningsson@canonical.com>, Anton Khirnov <anton@khirnov.net>
List-Id: alsa-devel@alsa-project.org

Thank you.

I also see a number of "deprecated API" message that makes sense to
look at as well:




rate_lavcrate.c:70:3: warning: 'av_resample_close' is deprecated
[-Wdeprecated-declarations]
   av_resample_close(rate->context);
   ^
In file included from rate_lavcrate.c:22:0:
/usr/include/libavcodec/avcodec.h:4854:6: note: declared here
 void av_resample_close(struct AVResampleContext *c);
      ^
rate_lavcrate.c: In function 'pcm_src_init':
rate_lavcrate.c:96:3: warning: 'av_resample_init' is deprecated
[-Wdeprecated-declarations]
   rate->context = av_resample_init(info->out.rate, info->in.rate,
   ^
In file included from rate_lavcrate.c:22:0:
/usr/include/libavcodec/avcodec.h:4824:27: note: declared here
 struct AVResampleContext *av_resample_init(int out_rate, int in_rate,
int filter_length, int log2_phase_count, int linear, double cutoff);
                           ^
rate_lavcrate.c: In function 'pcm_src_convert_s16':
rate_lavcrate.c:186:3: warning: 'av_resample' is deprecated
[-Wdeprecated-declarations]
   ret = av_resample(rate->context, rate->out[i],
   ^
In file included from rate_lavcrate.c:22:0:
/usr/include/libavcodec/avcodec.h:4836:5: note: declared here
 int av_resample(struct AVResampleContext *c, short *dst, short *src,
int *consumed, int src_size, int dst_size, int update_ctx);
     ^
rate_lavcrate.c:194:2: warning: 'av_resample_compensate' is deprecated
[-Wdeprecated-declarations]
  av_resample_compensate(rate->context,
  ^
In file included from rate_lavcrate.c:22:0:
/usr/include/libavcodec/avcodec.h:4852:6: note: declared here
 void av_resample_compensate(struct AVResampleContext *c, int
sample_delta, int compensation_distance);
      ^

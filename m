From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: pcm_rate API  question
Date: Mon, 30 Sep 2013 10:59:35 +0200
Message-ID: <52493D77.40601@ladisch.de>
References: <1380283173.50500.YahooMailNeo@web171404.mail.ir2.yahoo.com>
 <52457C3F.5090003@ladisch.de>
 <1380295697.44147.YahooMailNeo@web171405.mail.ir2.yahoo.com>
 <1380362320.63959.YahooMailNeo@web171406.mail.ir2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 681DE2608D6
 for <alsa-devel@alsa-project.org>; Mon, 30 Sep 2013 10:59:38 +0200 (CEST)
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
 by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id DB48420B02
 for <alsa-devel@alsa-project.org>; Mon, 30 Sep 2013 04:59:35 -0400 (EDT)
Received: from [10.1.2.65] (unknown [94.101.37.4])
 by mail.messagingengine.com (Postfix) with ESMTPA id 7A664C00E87
 for <alsa-devel@alsa-project.org>; Mon, 30 Sep 2013 04:59:35 -0400 (EDT)
In-Reply-To: <1380362320.63959.YahooMailNeo@web171406.mail.ir2.yahoo.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Rob Sykes wrote:
>> Typically there is some buffering/delay within a resampler -- how
>> does the pcm_rate API allow for this?

The API itself does not allow for this.  Your code must generate
dst_frames samples.

At startup, prefix the output with zero samples.  For example,
rate_samplerate.c in the alsa-plugins package does this:

    src_short_to_float_array(src, rate->src_buf, src_frames * rate->channels);
    src_process(rate->state, &rate->data);
    if (rate->data.output_frames_gen < dst_frames)
            ofs = dst_frames - rate->data.output_frames_gen;
    else
            ofs = 0;
    src_float_to_short_array(rate->dst_buf, dst + ofs * rate->channels,
                             rate->data.output_frames_gen * rate->channels);

> If, as you say above, the buffer sizes

the period sizes

> define the conversion ratio, then this seems to imply that alsa is
> unable to perform accurate rate conversion for one of the most common
> uses!

The conversion indeed is not accurate, unless you are using a period
size of an integer multiple of 441 frames.  In your example, the
application probably used a buffer of 0.5 s and four periods per buffer;
it should either double the buffer size or halve the number of periods.


Regards,
Clemens

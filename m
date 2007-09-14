From: "Krzysztof Helt" <krzysztof.h1@gmail.com>
Subject: Ensoniq SoundScape VIVO90
Date: Fri, 14 Sep 2007 10:12:37 +0200
Message-ID: <8c74410a0709140112s444692bcib146298c05fa1918@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.224])
	by alsa0.perex.cz (Postfix) with ESMTP id 6D4682446E
	for <alsa-devel@alsa-project.org>;
	Fri, 14 Sep 2007 10:12:39 +0200 (CEST)
Received: by nz-out-0506.google.com with SMTP id m22so606103nzf
	for <alsa-devel@alsa-project.org>; Fri, 14 Sep 2007 01:12:38 -0700 (PDT)
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
To: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

I acquired Ensoniq VIVO90 card. I tried sscape driver but it does not
work. I quickly looked at the oss driver in the kernel and it works
completely different (uses different pnp resources for codec and mpu).

I want to ask if somebody tested this driver and if so what was the
Ensoniq card model. If it worked only for non-pnp models I would
integrate at least for VIVO cards.

BTW. I found the old post which describes difference between VIVO and
VIVO90. It is below the email.

Regards,
Krzysztof

Hannu Savolainen (ha...@voxware.pp.fi, ha...@4front-tech.com) wrote:

Temat: Re: Ensoniq VIVO vs. VIVO 90

Bill Plenderleith <nospam!plend...@nortel.ca> writes:
>Are VIVO & VIVO 90 different products?
>Can anyone summarize the diffences?

The only difference is that in VIVO90 the wave table
output signal goes through the codec/mixer chip
(AD1845). In the original VIVO it's summed to the
output of AD1845. This difference is'n really
anything important.

Best regards,

Hannu

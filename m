From: sylvain.bertrand@gmail.com
Subject: Re: Fwd:  right way to enumerate pcm devices
Date: Thu, 14 Feb 2019 13:12:00 +0000
Message-ID: <20190214131200.GA384@freedom>
References: <20190212123333.GB6441@freedom> <s5hr2cd3z9b.wl-tiwai@suse.de>
 <20190212203324.GA1399@freedom> <s5hpnrwciie.wl-tiwai@suse.de>
 <20190213141328.GA358@freedom> <20190213222518.GA974@freedom>
 <20190213224313.GA1152@freedom>
 <CA+Owze4OqfSystQ5ZNaF6sO+L-L-FceN5XBPJkqyYf7zjkp+GQ@mail.gmail.com>
 <CA+Owze4HXg8x-KvLd0prwTiCZhvFvdB1VhV87-KsOxc3Bar_=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 0D6812675CD
 for <alsa-devel@alsa-project.org>; Thu, 14 Feb 2019 14:12:56 +0100 (CET)
Received: by mail-wr1-f46.google.com with SMTP id q1so6411091wrp.7
 for <alsa-devel@alsa-project.org>; Thu, 14 Feb 2019 05:12:56 -0800 (PST)
Received: from localhost (78.205.93.92.rev.sfr.net. [92.93.205.78])
 by smtp.gmail.com with ESMTPSA id e27sm4233397wra.67.2019.02.14.05.12.55
 for <alsa-devel@alsa-project.org>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 14 Feb 2019 05:12:55 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CA+Owze4HXg8x-KvLd0prwTiCZhvFvdB1VhV87-KsOxc3Bar_=w@mail.gmail.com>
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

Huho!

My bad, I was stuck into my usb mic use case. But for playback, ofc, the last
hardwarly mixed buffer will have to be dmixed from multiple source buffers.

regards,

-- 
Sylvain

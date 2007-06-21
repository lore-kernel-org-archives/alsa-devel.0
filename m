From: "Paul Kavan" <pkavan@gmail.com>
Subject: Re: at91 SoC Modifications
Date: Thu, 21 Jun 2007 14:10:54 -0500
Message-ID: <61c0054e0706211210s40158268oea170946cf62a9f@mail.gmail.com>
References: <61c0054e0706201421x3725f809g80822d32d78d216e@mail.gmail.com>
	<61c0054e0706210747gc83f1dx2a6ee8bc5cf346f9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mu-out-0910.google.com (mu-out-0910.google.com [209.85.134.188])
	by alsa0.perex.cz (Postfix) with ESMTP id 8FA15103855
	for <alsa-devel@alsa-project.org>;
	Thu, 21 Jun 2007 21:10:55 +0200 (CEST)
Received: by mu-out-0910.google.com with SMTP id w8so591066mue
	for <alsa-devel@alsa-project.org>; Thu, 21 Jun 2007 12:10:54 -0700 (PDT)
In-Reply-To: <61c0054e0706210747gc83f1dx2a6ee8bc5cf346f9@mail.gmail.com>
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
To: alsa-devel@alsa-project.org, Frank Mandarino <fmandarino@endrelia.com>, Liam Girdwood <lg@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

If possible, I am more confused now then I was this morning--and that is
after a lot of exploration and probing of the device.

The playback side of everything seems to work well for .raw files. I have
some that I made with my old ssc polling driver. The sound fine using aplay
with either the bare bones or the default alsa.conf file. However, I cannot
use arecord at all. I am not sure why, but something is preventing the sync
line from working during record. The sync line has a .3V,pp square that
rides around 3V DC. The frequency is that of the bit clock ~256.4K. Now,
when I playback a sample, the RF0 and RD0 look like they should.

I have RF0 and TF0 tied together and assume TF0 generates the sync. Also, I
have TK0 and RK0 tied together and assume TK0 generates the clock. Could
this be the problem.

Oh...and playback with PCM A (DSP_A) works fine, but no recording still. I
get the same type of signal on RF0 as before with PCM A fmt. Does anyone
have a sense if this is a ssc configuration problem or an alsa problem?

Thanks.

Paul
-- 
***************************************
Paul David Kavan
Project Engineer
GRH Electronics, Inc.
402-734-4900
pkavan@gmail.com
***************************************

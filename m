From: Krzysztof Helt <krzysztof.h1@gmail.com>
Subject: Re: [PATCH] New Aztech Sound Galaxy driver.
Date: Sat, 8 Sep 2007 15:20:34 +0200
Message-ID: <20070908152034.0bb316b4.krzysztof.h1@gmail.com>
References: <46E1DD43.6060403@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hu-out-0506.google.com (hu-out-0506.google.com [72.14.214.227])
	by alsa0.perex.cz (Postfix) with ESMTP id C256A1038C5
	for <alsa-devel@alsa-project.org>;
	Sat,  8 Sep 2007 15:13:58 +0200 (CEST)
Received: by hu-out-0506.google.com with SMTP id 16so277787hue
	for <alsa-devel@alsa-project.org>; Sat, 08 Sep 2007 06:13:58 -0700 (PDT)
In-Reply-To: <46E1DD43.6060403@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rene Herman <rene.herman@gmail.com>
Cc: ALSA devel <alsa-devel@alsa-project.org>, Ram Kromberg <ramkromberg@mail.com>
List-Id: alsa-devel@alsa-project.org

On Sat, 08 Sep 2007 01:22:43 +0200
Rene Herman <rene.herman@gmail.com> wrote:

> Except the ones with a CS4248-KL codec, all cards experience a 
> "cs4231_mce_down - auto calibration time out (1)" upon loading which does 
> not seem to have any further consequences. Both this and the previous point 
> may be cause for debugging cs4231_lib. Later...
> 

This is an issue I spotted in the ad1848-lib yesterday. The cs4231-lib seems little better in this respect. The driver waits for the busy bit to be set than wait until it is cleared. The
first waiting is wrong because if you have a card set to no calibration (or fast calibration) code you may experience that bit is already cleared and it won't be set any more. Then the
message is complete misleading. IMO, a correct solution is to wait some time. An auto-calibration takes about 348 sample periods for AD1848, so at 48KHz (fastest) it is about 7ms. Just
wait that in the msleep then wait for bit to be cleared (it could be already). The code is shorter and does not rely on CPU speed (like the current ad1848-lib because it has no delay
inside the loop). The 7ms may need to be changed for CS4231 (it may be faster or slower).

> 
> Krzysztof -- you won't be surprised to learn that this driver doesn't do 
> auto-probing. It needs all parameters passed in; normally:
>

I think we agreed that we did not agree on this issue. It is your driver so have it your way. It is nice to have some diversity.

> You have an EEPROM if you have "X24C00" chip sitting on a spot marked "UX2" 
> on the board, close to a crystal (silver shiny thing). If that spot is 
> empty, you have an EEPROM-less variant.
> 

I have not received the card yet. I'll test it when I have the hardware. I am afraid it is one of cards you have already tested.

Great work - new features like waiting by cpu_relax() + jiffies and ioport_map/ioport_unmap I haven't seen in the ISA drivers.

The only thing I do not understand is that there are 4 possible addresses for the SB port base, but user can supply only the first 2.

I got your email how to set up full-duplex but it conflicts with MPU irq settings for the SC-6000 card. Another difference.

Regards,
Krzysztof

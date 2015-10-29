From: Caleb Crome <caleb@crome.org>
Subject: Re: fsl_ssi.c: Getting channel slips with fsl_ssi.c in
 TDM (network) mode.
Date: Thu, 29 Oct 2015 07:55:59 -0700
Message-ID: <CAG5mAdw220n3K8vfRAgixxeYa=rBp5YbOrn_8ecwH+KN0JOnnA@mail.gmail.com>
References: <CAG5mAdxM_p2TWKhZne7AVGnhVfhVWA3gFe3pu6QQ8djb7TtjEA@mail.gmail.com>
 <5625EF02.30602@invoxia.com>
 <CAG5mAdw1Sj25hPWsFKqwQzgKft1_YWkN=7WNkW=kXGiF9P=kUA@mail.gmail.com>
 <56273F75.2040702@invoxia.com>
 <CAG5mAdxDmh3XDZSSHb8Oa7s-rosdVvTZPqu2zyDC42rMcqxxHA@mail.gmail.com>
 <CAG5mAdwC00qbu9zMHKjx5JZX_2CobBo81+jtpsWGPHPQ0jKX0A@mail.gmail.com>
 <20151027071344.GC25728@pengutronix.de> <20151027201101.GA9527@Asurada-CZ80>
 <CAG5mAdz=TKSmXBOqKfSj0FYfk3c6syBa87OazyGRRF0NU4snXA@mail.gmail.com>
 <20151029045350.GA3374@Asurada-CZ80>
 <CAG5mAdwQd3ep7ZSNHDEni6caKeFPyvXhM0g=BjqPFA_gDSU1DQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f169.google.com (mail-wi0-f169.google.com
 [209.85.212.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 489AB260662
 for <alsa-devel@alsa-project.org>; Thu, 29 Oct 2015 15:56:19 +0100 (CET)
Received: by wijp11 with SMTP id p11so289634005wij.0
 for <alsa-devel@alsa-project.org>; Thu, 29 Oct 2015 07:56:18 -0700 (PDT)
In-Reply-To: <CAG5mAdwQd3ep7ZSNHDEni6caKeFPyvXhM0g=BjqPFA_gDSU1DQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Markus Pargmann <mpa@pengutronix.de>, "arnaud.mouiche@invoxia.com" <arnaud.mouiche@invoxia.com>, Roberto Fichera <kernel@tekno-soft.it>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 29, 2015 at 6:44 AM, Caleb Crome <caleb@crome.org> wrote:
> On Wed, Oct 28, 2015 at 9:53 PM, Nicolin Chen <nicoleotsuka@gmail.com> wrote:
>>
>> I am actually thinking about setting a watermark to a larger number.
>> I forgot how the SDMA script handles this number. But if this burst
>> size means the overall data count per transaction, it might indicate
>> that each FIFO only gets half of the burst size due to dual FIFOs.
>>
>> Therefore, if setting watermark to 8, each FIFO has 7 (15 - 8) space
>> left, the largest safe burst size could be 14 (7 * 2) actually.
>
> Oh, does this depend on the data size?  I'm using 16-bit data, so I
> guess the bursts are measured in 2 byte units?  Does this mean that
> the burst size should be dynamically adjusted depending on word size
> (I guess done in hw_params)?
>
>> Nicolin

Okay, so wm=8 and maxburst=14 definitely does not work at all,.  wm=8,
maxburst=8 works okay, but still not perfect.

I just discovered some new information:

With wm=8 and maxburst=8 (which is my best setting so far), I just
captured a problem at the very start of playing a file, and restarted
enough times to capture it starting wrong:

Instead of the playback starting with

(hex numbers:  my ramp file has first nibble as channel, second nibble as frame)

frame 0:  00, 10, 20, 30, 40, 50, 60, 70, 80, 90, a0, b0, c0, d0, e0, f0
frame 1:  01, 11, 21, 31, 41, 51, 61, 71, 81, 91, a1, b1, c1, d1, e1, f1

It started with:

frame 0:  00, 00, 10, 20, 30, 40, 50, 60, 70, 80, 90, a0, b0, c0, d0, e0
frame 1:  f0, 01, 11, 21, 31, 41, 51, 61, 71, 81, 91, a1, b1, c1, d1, e1

So, the transfer started wrong right out of the gate -- with an extra
sample inserted at the beginning. Again, my setup is:
1) use scope to capture the TDM bus.  Trigger on first data change
2) aplay myramp.wav
3) If okay, ctrl-c and goto 2.
4) The capture below shows everything off by 1 sample.

The capture is here:
https://drive.google.com/open?id=0B-KUa9Yf1o7iOXFtWXk2ZXdoUXc

This test definitely reveals that there is a startup issue.  Now for
the $64,000 question: what to do with this knowledge?  I'm quite
unfamiliar with how the DMA works at all.

I'll start poking around the DMA I guess.

Thanks,
  -Caleb

From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: About iMX6SL sign extension of SSI Receive
 Configuration Register (SSIx_SRCR)
Date: Mon, 9 Mar 2015 19:33:03 -0700
Message-ID: <20150310023302.GA1384@Asurada-GSX>
References: <54FD634E.8040007@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f41.google.com (mail-pa0-f41.google.com
 [209.85.220.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 2A920261551
 for <alsa-devel@alsa-project.org>; Tue, 10 Mar 2015 03:33:09 +0100 (CET)
Received: by pablj1 with SMTP id lj1so68233068pab.10
 for <alsa-devel@alsa-project.org>; Mon, 09 Mar 2015 19:33:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <54FD634E.8040007@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Xuebing Wang <xbing6@gmail.com>
Cc: alsa-devel@alsa-project.org, niranjan Patil <Niranjan.Patil@infocus.com>, markus.lindroth@limesaudio.com, richard Jiang <Richard.Jiang@infocus.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 09, 2015 at 05:09:34PM +0800, Xuebing Wang wrote:
 
> After I receive data (in the format of S16_LE) from SSI/I2S, I got data like
> 0x7FFF or 0x77d2. Are they supposed to be 0xFFFF or 0xF7d2?
> 
> After setting bit 10 (RXEXT) of SSIx_SRCR, I still get 0x7FFF or 0x77d2.

I don't have much detail information on it. But what I see a sign
extension should only happen during some procedures like converting
a 16-bit signed number to a 32-bit signed number. For example, the
original number is 0x8000 (16-bit), then the result should be a 32-
bit 0xFFFF8000.

However, you are still using 16-bit format and the sample data you
provided looks like positive numbers.

You might need to read a 32-bit result from the Receive FIFO so as
to get a 32-bit sign extended data.

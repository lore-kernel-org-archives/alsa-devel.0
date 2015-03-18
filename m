From: Shawn Embedded <programassem@gmail.com>
Subject: Re: Support two wm8962 codec in i.mx6 board.
Date: Wed, 18 Mar 2015 13:10:49 +0800
Message-ID: <CAOaGyfXwK_KdBXMyz8QPtg5aqc55-PkQxa_YBfy+C8Odqwtz_g@mail.gmail.com>
References: <CAOaGyfUHS90nKcSxpQZm7X3Lgwtb_9V4xLzyObhd5v=diGHJLw@mail.gmail.com>
 <20150317005503.GA5480@Asurada-GSX>
 <CAOaGyfUBoQLpa0YZjKEtZXmhRL_p=zGq3XEJ9oZHbHrVr1SQ8w@mail.gmail.com>
 <20150317180006.GA5336@Asurada>
 <CAOaGyfUk6LLkZhLXpLVE_akGTD3Ekk0TX_u1Gzw5y3oidBMQOg@mail.gmail.com>
 <20150318013301.GA6432@Asurada-GSX>
 <CAOaGyfUWROtRSfYf5JLbSWqJMUbqmEpyDE6SuELkcvZ2SHidJw@mail.gmail.com>
 <20150318045832.GA5380@Asurada>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f41.google.com (mail-oi0-f41.google.com
 [209.85.218.41])
 by alsa0.perex.cz (Postfix) with ESMTP id BE398260418
 for <alsa-devel@alsa-project.org>; Wed, 18 Mar 2015 06:10:50 +0100 (CET)
Received: by oibu204 with SMTP id u204so27433228oib.0
 for <alsa-devel@alsa-project.org>; Tue, 17 Mar 2015 22:10:49 -0700 (PDT)
In-Reply-To: <20150318045832.GA5380@Asurada>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 18, 2015 at 12:58 PM, Nicolin Chen <nicoleotsuka@gmail.com> wrote:
> On Wed, Mar 18, 2015 at 12:48:24PM +0800, Shawn Embedded wrote:
>
>> >> Since the two codecs share the same clock source, clko, and we donot
>> >> know when mxc_wm8962_init() and wm8962_clk_enable() will be called by
>> >> using the function pointer exactly, do you think it's necessary to
>> >> make NULL to init, make wm8962_clk_enable_do_nothing to clock_enable,
>> >> and manually calling mxc_wm8962_init() and wm8962_clk_enable() in the
>> >> xxx_board_init() function instead?
>> >
>> > I don't think you need to change this part.
>>
>>    If donot change it, what will happen to the working codec if the
>> clock_enable is called caused by stopping the other codec? the working
>> codec will not be affected?
>
> Before stopping, the other one has been opened once. So the reference
> count is 2 when the second clock_enable(); the clock_disable() that
> you worry about only decreases the count.

   yes, right.

>
>>    But let me paste a snippet of code here, for two codecs on board,
>> do'not you think it's necessary to setup 2 structure imx_priv to track
>> the two codecs respectively?
>
> You can try whatever you think it's right. A better solution should be
> to modify the driver to get rid of that hard code. So there's no need
> to add any of structure in the imx-wm8962.c but only to register an
> extra platform driver in board level file.

   Ok, I understand.
   Maybe I'll patch it later.
   Thanks a lot for your big help.


Best Regards,
Shawn

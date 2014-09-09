From: Fabio Estevam <festevam@gmail.com>
Subject: Re: Board with SGTL5000 + DM365. How to get it work?
Date: Tue, 9 Sep 2014 15:09:57 -0300
Message-ID: <CAOMZO5BsZuvk_UhYRztf5c9kN9_O_Cmq5zaJjMrFiWUyVFuHnA@mail.gmail.com>
References: <CAN8RqkD86yc8cjsvmK=W=k01FVuxVsDmncHgGs85TZQd6AMHqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f51.google.com (mail-la0-f51.google.com
 [209.85.215.51])
 by alsa0.perex.cz (Postfix) with ESMTP id AC5552652C6
 for <alsa-devel@alsa-project.org>; Tue,  9 Sep 2014 20:09:57 +0200 (CEST)
Received: by mail-la0-f51.google.com with SMTP id gi9so7612888lab.10
 for <alsa-devel@alsa-project.org>; Tue, 09 Sep 2014 11:09:57 -0700 (PDT)
In-Reply-To: <CAN8RqkD86yc8cjsvmK=W=k01FVuxVsDmncHgGs85TZQd6AMHqg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andrew Kuksov <ak@niirt.ru>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 9, 2014 at 10:42 AM, Andrew Kuksov <ak@niirt.ru> wrote:
> Hi. I have board with SGTl5000 codec connected to DM365 via McBSP
> (FSR/CLKR/DX/DR), I2C and CLKOUT1.
>
> DM365-EVM has TVL320AIC3101 connected to DM365 like SGTL5000 on my board.
> I try to patch DM365-EVM code but something went wrong.
>
> There is what I do:
>
> 1. arch/arm/mach-davinci/board-dm365-evm.c

Why don't you convert this board to devicetree and then use
simple-audio-codec binding?

An example of simple-audio-codec with sgtl5000 can be found here:
http://www.spinics.net/lists/devicetree/msg44466.html

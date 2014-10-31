From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH] usb-audio: Add mixer control for
 Digidesign Mbox 1 clock source
Date: Fri, 31 Oct 2014 14:13:51 +0900
Message-ID: <54531A8F.1040401@sakamocchi.jp>
References: <5452EC80.8060005@gmail.com> <54530212.7000804@sakamocchi.jp>
 <545309D8.1020600@gmail.com> <5453100A.8070602@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 41D63265466
 for <alsa-devel@alsa-project.org>; Fri, 31 Oct 2014 06:13:54 +0100 (CET)
In-Reply-To: <5453100A.8070602@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Damien Zammit <damien.zammit@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Oct 31 2014 13:28, Takashi Sakamoto wrote:
> 2.please use 'const char *const' for immutable arrays for immutable
> strings:
>  > +       static const char *texts[2] = {"Internal",
>  > +                                      "S/PDIF"
>  > +       };
>  > +

Oops. I mistook to use immutable as 'may not be changed'. It should be 
'mutable'...


Regards

Takashi Sakamoto
o-takashi@sakamocchi.jp

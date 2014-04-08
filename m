From: Tomas Black <tomas.black@gmail.com>
Subject: Re: 2.1 audio not working in Kubuntu 13.10
Date: Tue, 8 Apr 2014 18:20:15 -0300
Message-ID: <CAL8wzGRodjLPznk8VTtMDgpuq4XcMSfgw6t66VDhsxNbkTyhFw@mail.gmail.com>
References: <CAL8wzGRtAVhL2dioHRL-7rtZjSCRduBfWpdpZHTxEnp22i=ftA@mail.gmail.com>
 <CAN8cciYEA3zo3KzqCrZwOZi+COc6itBpAnsD+8OiegXiBT9ryQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f45.google.com (mail-pa0-f45.google.com
 [209.85.220.45])
 by alsa0.perex.cz (Postfix) with ESMTP id 42C63266561
 for <alsa-devel@alsa-project.org>; Tue,  8 Apr 2014 23:20:37 +0200 (CEST)
Received: by mail-pa0-f45.google.com with SMTP id kl14so1570888pab.18
 for <alsa-devel@alsa-project.org>; Tue, 08 Apr 2014 14:20:35 -0700 (PDT)
In-Reply-To: <CAN8cciYEA3zo3KzqCrZwOZi+COc6itBpAnsD+8OiegXiBT9ryQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello Raymond,


thanks for your answer.

I checked the Dell thread and the Realtek datasheet. I see it's possible to
connect to external 5.1 (or 2.1) sound system.

However I want to make it work with the *internal *2 speakers + *internal *
subwoofer.

I've read tons of links and similar threas, it seems it is not possible
under linux :-(

Regards,


Tomas Black


On Sun, Apr 6, 2014 at 10:15 PM, Raymond Yau <superquad.vortex2@gmail.com>wrote:

>
>
>
> 2014-04-03 2:44 GMT+08:00 Tomas Black <tomas.black@gmail.com>:
>
> Dear friends,
>>
>>
>> I have a Dell L702X laptop which comes with a 2.1 sound configuration - 2
>> speakers + subwoofer from JBL. Sound is suberb in Windows, but  I can't
>> get
>> the subwoofer to work in Linux!
>>
>
>
> http://www.realtek.com/products/productsView.aspx?Langid=1&PFid=37&Level=5&Conn=4&ProdID=252
>
> Take a look at datasheet,
>
> ALC655 is a 5.1 codec and a MONO out
>
> either the subwoofer is at the MONO node 0x17  or the right or left
> channels of the other unconnected stereo nodes
>
> try hdajackretask to change the pin default of node 0x17 to [Fixed]
> Speaker at Int
>
>
> http://en.community.dell.com/support-forums/laptop/f/3517/t/19440542.aspx
>
> seem support 5.1 using two headphone jacks and mic jack
>
>

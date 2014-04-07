From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: 2.1 audio not working in Kubuntu 13.10
Date: Mon, 7 Apr 2014 09:15:11 +0800
Message-ID: <CAN8cciYEA3zo3KzqCrZwOZi+COc6itBpAnsD+8OiegXiBT9ryQ@mail.gmail.com>
References: <CAL8wzGRtAVhL2dioHRL-7rtZjSCRduBfWpdpZHTxEnp22i=ftA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qg0-f47.google.com (mail-qg0-f47.google.com
 [209.85.192.47])
 by alsa0.perex.cz (Postfix) with ESMTP id 994EE26087C
 for <alsa-devel@alsa-project.org>; Mon,  7 Apr 2014 03:15:12 +0200 (CEST)
Received: by mail-qg0-f47.google.com with SMTP id i50so114043qgf.20
 for <alsa-devel@alsa-project.org>; Sun, 06 Apr 2014 18:15:11 -0700 (PDT)
In-Reply-To: <CAL8wzGRtAVhL2dioHRL-7rtZjSCRduBfWpdpZHTxEnp22i=ftA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tomas Black <tomas.black@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2014-04-03 2:44 GMT+08:00 Tomas Black <tomas.black@gmail.com>:

> Dear friends,
>
>
> I have a Dell L702X laptop which comes with a 2.1 sound configuration - 2
> speakers + subwoofer from JBL. Sound is suberb in Windows, but  I can't get
> the subwoofer to work in Linux!
>

http://www.realtek.com/products/productsView.aspx?Langid=1&PFid=37&Level=5&Conn=4&ProdID=252

Take a look at datasheet,

ALC655 is a 5.1 codec and a MONO out

either the subwoofer is at the MONO node 0x17  or the right or left
channels of the other unconnected stereo nodes

try hdajackretask to change the pin default of node 0x17 to [Fixed] Speaker
at Int


http://en.community.dell.com/support-forums/laptop/f/3517/t/19440542.aspx

seem support 5.1 using two headphone jacks and mic jack

From: Michael Trimarchi <michael@amarulasolutions.com>
Subject: Re: HIFACE family driver
Date: Wed, 14 Nov 2012 12:40:44 +0100
Message-ID: <50A3833C.8030101@amarulasolutions.com>
References: <50A3750A.70401@amarulasolutions.com>
 <CACckToWXMza5tMB0w+qAseXjiRijsFzidLET7jDZynSguatxew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 9533D26168F
 for <alsa-devel@alsa-project.org>; Wed, 14 Nov 2012 12:41:13 +0100 (CET)
Received: by mail-bk0-f51.google.com with SMTP id ik5so134632bkc.38
 for <alsa-devel@alsa-project.org>; Wed, 14 Nov 2012 03:41:13 -0800 (PST)
In-Reply-To: <CACckToWXMza5tMB0w+qAseXjiRijsFzidLET7jDZynSguatxew@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Grant Diffey <gdiffey@gmail.com>
Cc: ALSA development <alsa-devel@alsa-project.org>, Clemens Ladisch <clemens@ladisch.de>, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi

On 11/14/2012 12:15 PM, Grant Diffey wrote:
> On Wed, Nov 14, 2012 at 9:40 PM, Michael Trimarchi <michael@amarulasolutions.com <mailto:michael@amarulasolutions.com>> wrote:
> 
>     Hi all,
> 
>     I have written in my spare time an alsa driver for HIFACE devices family. Now I'm not an alsa expert and I would like to know if you think that it's useful to include it in mainline
> 
>     https://github.com/panicking/snd-usb-asyncaudio
> 
>     The list of usb devices supported
> 
>     https://github.com/panicking/snd-usb-asyncaudio/blob/master/chip.c
> 
>     The main difference is that I need to use bulk message to talk to the usb dongle and ofcourse there are a lot of improvement that we can do on it. I have already tested on several kernel version and it's already included in some linux distribution. Wait for some feedback ;)
> 
>     Michael
> 
> 
> Michael,
> 
> Your driver has been discussed briefly on list already: http://mailman.alsa-project.org/pipermail/alsa-devel/2012-November/056791.html
>  
> adding Daniel and Clemens as cc's

Ok, so the idea is to send patches on the mailing list. I can send one hiface for free if someone want help me on the submission. Sounds good?

Michael


> 
> Grant

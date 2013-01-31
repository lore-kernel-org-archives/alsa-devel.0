From: Jonas Petersen <jnsptrsn1@gmail.com>
Subject: Re: M-Audio Audiophile 192 (ice1724)'s broken spdif
 capture
Date: Thu, 31 Jan 2013 02:19:39 +0100
Message-ID: <5109C6AB.8050407@gmail.com>
References: <CAF+J8LeejgAx6vs0Ee8svWpmGYyk3-7SK+mE1ev-bWXYy-7v6Q@mail.gmail.com>
 <51042EE5.5070900@perex.cz>
 <7adcf466397b198e2e079e35b47686bc.squirrel@mail.insite.cz>
 <CAF+J8LduUEPqaguteL0oyiACXa4jVXGTVVTCm4Tw=jMxRTmLWA@mail.gmail.com>
 <510644E5.1040505@perex.cz> <5106747A.5070803@ivitera.com>
 <5106ECE1.7040608@gmail.com> <510799FE.3020904@ivitera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f52.google.com (mail-bk0-f52.google.com
 [209.85.214.52])
 by alsa0.perex.cz (Postfix) with ESMTP id E0C37265115
 for <alsa-devel@alsa-project.org>; Thu, 31 Jan 2013 02:19:42 +0100 (CET)
Received: by mail-bk0-f52.google.com with SMTP id jk13so1097673bkc.39
 for <alsa-devel@alsa-project.org>; Wed, 30 Jan 2013 17:19:42 -0800 (PST)
In-Reply-To: <510799FE.3020904@ivitera.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pavel Hofman <pavel.hofman@ivitera.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Am 29.01.2013 10:44, schrieb Pavel Hofman:
> On 28.1.2013 22:25, Jonas Petersen wrote:
>>> Jonas, please could you check if ak4114 pins XTL0/1 (10, 11) are
>>> connected to logical high? They should be :)
>> Physically they're both on ground. I don't know what active state that
>> chip has though.
> Let 's wait until we get the ak4114 register dump file :)

Can't wait. :) I did a quick test in Windows 7. This driver is able to 
detect the sample rate. If I set the clock source to "spdif in" at the 
control pannel, then I can see the rate changing when I switch to 
another rate on the spdif source.

- Jonas

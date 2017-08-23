From: "Keith A. Milner" <maillist@superlative.org>
Subject: Re: Attempting to understand odd snd-usb-audio code
	and behavior
Date: Wed, 23 Aug 2017 12:25:03 +0100
Message-ID: <1954362.aJMGcWAYHc@kamdesktop>
References: <2006820.TBXnYHJvYE@kamdesktop>
 <ac221250-a87f-0875-1172-846530607635@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f52.google.com (mail-wm0-f52.google.com [74.125.82.52])
 by alsa0.perex.cz (Postfix) with ESMTP id ABC6526735E
 for <alsa-devel@alsa-project.org>; Wed, 23 Aug 2017 13:25:06 +0200 (CEST)
Received: by mail-wm0-f52.google.com with SMTP id r187so13334942wma.0
 for <alsa-devel@alsa-project.org>; Wed, 23 Aug 2017 04:25:06 -0700 (PDT)
Received: from kamdesktop.localnet
 (2.7.2.6.c.3.7.d.6.2.e.2.5.5.4.1.d.a.9.2.a.0.e.b.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:be0a:29ad:1455:2e26:d73c:6272])
 by smtp.gmail.com with ESMTPSA id 65sm1323519wmf.0.2017.08.23.04.25.04
 for <alsa-devel@alsa-project.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 23 Aug 2017 04:25:04 -0700 (PDT)
In-Reply-To: <ac221250-a87f-0875-1172-846530607635@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wednesday 23 Aug 2017 12:23:00 Clemens Ladisch wrote:
> Keith A. Milner wrote:
> > 
> > It seems to open and close the PCMs
> 
> That happens due to requests from user space, probably PulseAudio.
> 
> > kernel: [ 1987.452947] usb 1-1: Unable to change format on ep #8e: already
> > in use
> So this is a Roland device?  Playback-synchronized-to-capture is a very
> special case; at the moment, nobody understands this code completely.
> 
> But the problem for this device might be that it requires some
> vendor-specific messages to enable it in the first place.

That's very useful, thank you. I forgot about pulseaudio!

So the error messages are due to a userspace app trying to open playback and 
capture at the same time? Or is it just a generic driver/card issue when 
trying to open the interface?

I have the ability to sniff the USB whilst running on Windows. For this 
specific device I may try that.

Regards,

Keith

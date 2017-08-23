From: "Keith A. Milner" <maillist@superlative.org>
Subject: Re: Attempting to understand odd snd-usb-audio code
	and behavior
Date: Wed, 23 Aug 2017 23:43:49 +0100
Message-ID: <2465148.6KUvh8QIGJ@kamdesktop>
References: <2006820.TBXnYHJvYE@kamdesktop> <1954362.aJMGcWAYHc@kamdesktop>
 <f5769b3d-0bb1-cd15-90a6-3983cb28f8ff@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr0-f173.google.com (mail-wr0-f173.google.com
 [209.85.128.173])
 by alsa0.perex.cz (Postfix) with ESMTP id A6C0F266A7C
 for <alsa-devel@alsa-project.org>; Thu, 24 Aug 2017 00:43:52 +0200 (CEST)
Received: by mail-wr0-f173.google.com with SMTP id f8so4645438wrf.3
 for <alsa-devel@alsa-project.org>; Wed, 23 Aug 2017 15:43:52 -0700 (PDT)
Received: from kamdesktop.localnet
 (e.5.5.f.4.0.b.1.0.d.6.9.3.d.9.8.d.a.9.2.a.0.e.b.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:be0a:29ad:89d3:96d0:1b04:f55e])
 by smtp.gmail.com with ESMTPSA id b96sm5016967wrd.94.2017.08.23.15.43.50
 for <alsa-devel@alsa-project.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 23 Aug 2017 15:43:50 -0700 (PDT)
In-Reply-To: <f5769b3d-0bb1-cd15-90a6-3983cb28f8ff@ladisch.de>
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

On Wednesday 23 Aug 2017 14:52:43 Clemens Ladisch wrote:
> Keith A. Milner wrote:
> >>> kernel: [ 1987.452947] usb 1-1: Unable to change format on ep #8e:
> >>> already in use> 
> > So the error messages are due to a userspace app trying to open playback
> > and capture at the same time?
> 
> For this device, playback requires a running capture stream to determine
> the rate of packets.  This error happens when the application tries to
> open the capture stream after the playback stream.  (If the format does
> not actually need to change, the error message is misleading.)
> 
> Your actual problem is that the device does not send any capture packets.

Thank you for the clarification. Hopefully I will find some time to explore 
this further.

Cheers,

Keith

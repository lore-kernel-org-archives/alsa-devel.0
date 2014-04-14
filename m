From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: snd-usb-audio issues??
Date: Mon, 14 Apr 2014 15:26:45 +0200
Message-ID: <534BE215.4010209@ladisch.de>
References: <CAA0fz9ZctzKNpcMCqR==rDdnGAk6yLf2Or_z=zi4XG7-QcHBmQ@mail.gmail.com>	<534BD57F.6000006@ladisch.de>	<CAA0fz9Y=EhoWBr5qMRabqf6acG-3yRCqtQcbOo9Xnn3yT3f4Vw@mail.gmail.com>	<534BDA85.5000007@ladisch.de>
 <CAA0fz9aX8kVCC-B6teSuz9B2HyiFwL4QwoBCSZt+mwXXQpuc7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 0BAFA264FF6
 for <alsa-devel@alsa-project.org>; Mon, 14 Apr 2014 15:26:46 +0200 (CEST)
In-Reply-To: <CAA0fz9aX8kVCC-B6teSuz9B2HyiFwL4QwoBCSZt+mwXXQpuc7A@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Richard Storer <rstorer@ntlworld.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Richard Storer wrote:
>         bTerminalID             4
>         wTerminalType      0x0603 Line Connector

>         bDescriptorSubtype      6 (FEATURE_UNIT)
>         bUnitID                 5
>         bSourceID               4
>         bmaControls( 0)      0x02
>           Volume Control

That single capture mixer control controls the line input.
(I don't know why it's labelled as "Mic", or how the device
switches between mic and line signal levels.)


Regards,
Clemens

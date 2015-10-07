From: "Keith A. Milner" <maillist@superlative.org>
Subject: Re: Zoom R16/24 playback slient
Date: Wed, 07 Oct 2015 11:05:20 +0100
Message-ID: <1925874.fS1mSi4kq9@kamdesktop>
References: <alpine.DEB.2.02.1509292156390.6263@lnxricardw1.se.axis.com>
 <5613756A.9080209@laiskiainen.org>
 <alpine.DEB.2.02.1510060933160.19610@lnxricardw1.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f181.google.com (mail-wi0-f181.google.com
 [209.85.212.181])
 by alsa0.perex.cz (Postfix) with ESMTP id CFBAA265AFC
 for <alsa-devel@alsa-project.org>; Wed,  7 Oct 2015 12:05:22 +0200 (CEST)
Received: by wicgb1 with SMTP id gb1so203487820wic.1
 for <alsa-devel@alsa-project.org>; Wed, 07 Oct 2015 03:05:22 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.02.1510060933160.19610@lnxricardw1.se.axis.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, Ricard Wanderlof <ricard.wanderlof@axis.com>, Panu Matilainen <pmatilai@laiskiainen.org>
List-Id: alsa-devel@alsa-project.org

On Tuesday 06 Oct 2015 10:16:05 Ricard Wanderlof wrote:

> What doesn't make sense to me here is that certain subtypes seem to be
> reused for different purposes even with the same descriptor type, for
> instance descriptor type 24 has subtype 02 being used to specify terminal
> type and also the data format. Perhaps the length is also a part of the
> type specifier?
> 

My reading of it is that the meaning of the CS_INTERFACE subtype is context 
specific, so it depends where in the descriptor it appears.

Cheers,

Keith

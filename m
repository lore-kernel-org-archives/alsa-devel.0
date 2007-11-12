From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: Re: No sound from usb on Motorola C350 cellphone
Date: Mon, 12 Nov 2007 18:50:12 +0500
Message-ID: <47385A14.4000301@gmail.com>
References: <7c5010d60711120528u16bef715ua48f440c49d962d1@mail.gmail.com>
	<7c5010d60711120534l13376fc9gc71228ca84322ddc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.171])
	by alsa0.perex.cz (Postfix) with ESMTP id 811F32460E
	for <alsa-devel@alsa-project.org>; Mon, 12 Nov 2007 14:50:30 +0100 (CET)
Received: by ug-out-1314.google.com with SMTP id h2so731408ugf
	for <alsa-devel@alsa-project.org>; Mon, 12 Nov 2007 05:50:29 -0800 (PST)
In-Reply-To: <7c5010d60711120534l13376fc9gc71228ca84322ddc@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Giovanni Maruzzelli <gmaruzz.lists@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Giovanni Maruzzelli wrote:
> Maybe there is a way to not using soundcards, that would be *so* much
> better: I found that Motorola c350 phones after receiving an AT+MODE=8
> command via USB, make available an usb sound device.

Confirmed with my Motorola C350 cellphone. It appears to accept S16_LE, MU_LAW 
and A_LAW formats, 8 kHz sample rate, but actually records no data and plays no 
sounds (even if a cal is in progress).

One question: what playback and recording functionality is available on this 
cellphone under Windows?

-- 
Alexander E. Patrakov

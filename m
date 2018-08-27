From: George Anchev <studio@anchev.net>
Subject: Re: alsa-sink.c: ALSA woke us up to write new data to
 the device, but there was actually nothing to write
Date: Mon, 27 Aug 2018 17:09:02 +0300
Message-ID: <20180827170902.18ca83f5@localhost>
References: <20180827014812.268229b3@localhost> <s5hbm9o7zy3.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx.kolabnow.com (mx.kolabnow.com [95.128.36.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 81ECC2676C9
 for <alsa-devel@alsa-project.org>; Mon, 27 Aug 2018 16:09:06 +0200 (CEST)
Received: from localhost (unknown [127.0.0.1])
 by ext-mx-out002.mykolab.com (Postfix) with ESMTP id BB683218
 for <alsa-devel@alsa-project.org>; Mon, 27 Aug 2018 16:09:05 +0200 (CEST)
Received: from mx.kolabnow.com ([127.0.0.1])
 by localhost (ext-mx-out002.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UX5CieTWKA1u for <alsa-devel@alsa-project.org>;
 Mon, 27 Aug 2018 16:09:04 +0200 (CEST)
Received: from int-mx002.mykolab.com (unknown [10.9.13.2])
 by ext-mx-out002.mykolab.com (Postfix) with ESMTPS id BBBA91AC
 for <alsa-devel@alsa-project.org>; Mon, 27 Aug 2018 16:09:04 +0200 (CEST)
Received: from ext-subm001.mykolab.com (unknown [10.9.6.1])
 by int-mx002.mykolab.com (Postfix) with ESMTPS id ABB972400
 for <alsa-devel@alsa-project.org>; Mon, 27 Aug 2018 16:09:04 +0200 (CEST)
In-Reply-To: <s5hbm9o7zy3.wl-tiwai@suse.de>
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

On Mon, 27 Aug 2018 14:32:04 +0200 Takashi Iwai wrote:

> It's grumbling PulseAudio about the wakeup timing
> isn't strictly synced with the reported avail size.

Is that not a problem? (considering it appears in red
in the log)

> In most case, you can ignore it unless you actually
> have the audible problem.

I have been doing this since Leap 42.1 (perhaps even
before since 13.2) but I thought it may be time to
report it.

--
George

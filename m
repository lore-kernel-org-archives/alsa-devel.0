From: Henrik Eriksson <henrik.eriksson@axis.com>
Subject: Re: dsnoop, hwpointer and avail
Date: Mon, 13 Nov 2017 11:12:43 +0100
Message-ID: <20171113101243.GC5483@lnxhenriken2.se.axis.com>
References: <20171110122943.GB5483@lnxhenriken2.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
 by alsa0.perex.cz (Postfix) with ESMTP id 6520B26698E
 for <alsa-devel@alsa-project.org>; Mon, 13 Nov 2017 11:12:45 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by bastet.se.axis.com (Postfix) with ESMTP id 6B3441811A
 for <alsa-devel@alsa-project.org>; Mon, 13 Nov 2017 11:12:45 +0100 (CET)
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
 by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id HUJLgpYiZXQR for <alsa-devel@alsa-project.org>;
 Mon, 13 Nov 2017 11:12:43 +0100 (CET)
Received: from boulder03.se.axis.com (boulder03.se.axis.com [10.0.8.17])
 by bastet.se.axis.com (Postfix) with ESMTPS id B045F18107
 for <alsa-devel@alsa-project.org>; Mon, 13 Nov 2017 11:12:43 +0100 (CET)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9632A1E078
 for <alsa-devel@alsa-project.org>; Mon, 13 Nov 2017 11:12:43 +0100 (CET)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8A2301E079
 for <alsa-devel@alsa-project.org>; Mon, 13 Nov 2017 11:12:43 +0100 (CET)
Received: from thoth.se.axis.com (unknown [10.0.2.173])
 by boulder03.se.axis.com (Postfix) with ESMTP
 for <alsa-devel@alsa-project.org>; Mon, 13 Nov 2017 11:12:43 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20171110122943.GB5483@lnxhenriken2.se.axis.com>
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

Hello

On Fri,=A0Nov=A010,=A02017=A0at=A013:29:43=A0+0100, Henrik Eriksson wrote:
> Is there any documentation/rationale for how pcm_dsnoop works in
> snd_pcm_{dsnoop_}status?  I am particularly wondering about the ordering
> of the snd_pcm_dsnoop_sync_ptr and the snd_pcm_status call on the slave
> pcm.
> =

> I see occasional spikes (>1000 frames) of difference between the slave
> pcm hwpointer after the snd_pcm_status call on it and the pointers in
> the dsnoop pcm, and a correspondingly bad avail count.  I suspect the
> mismatches are due to process scheduling (the slave pcm status is
> delayed because the application process not running and the hardware
> progresses during that delay).  Does this seem plausible?  If so, could
> the code be simplified to reduce the the number of systemcalls needed?
> The status of the slave pcm seems to provide much of the information
> used to sync the pointers.  Or is there some other way to get a tighter
> coupling between the dsnoop status htstamp and avail count?

Or, rather, in snd_pcm_dnsoop_status() would it not make more sense to
use the dsnoop->update_tstamp as tstamp in the returned status, at least
when the state is SNDRV_PCM_STATE_RUNNING?  The returned status->avail
count originates from snd_pcm_dsnoop_sync_ptr() and it seems sensible to
me that the tstamp would match that.

For background, this is on a machine with not mmap'ed status and control
(in pcm_hw.c) and using slowptr in dsnoop.

Regards,
/henrik

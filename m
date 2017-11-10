From: Henrik Eriksson <henrik.eriksson@axis.com>
Subject: dsnoop, hwpointer and avail
Date: Fri, 10 Nov 2017 13:29:43 +0100
Message-ID: <20171110122943.GB5483@lnxhenriken2.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
 by alsa0.perex.cz (Postfix) with ESMTP id 951FB266A73
 for <alsa-devel@alsa-project.org>; Fri, 10 Nov 2017 13:29:45 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by bastet.se.axis.com (Postfix) with ESMTP id D897918519
 for <alsa-devel@alsa-project.org>; Fri, 10 Nov 2017 13:29:44 +0100 (CET)
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
 by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 2rcth4_oowTO for <alsa-devel@alsa-project.org>;
 Fri, 10 Nov 2017 13:29:44 +0100 (CET)
Received: from boulder03.se.axis.com (boulder03.se.axis.com [10.0.8.17])
 by bastet.se.axis.com (Postfix) with ESMTPS id 21E0D184F0
 for <alsa-devel@alsa-project.org>; Fri, 10 Nov 2017 13:29:44 +0100 (CET)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EFE1D1E084
 for <alsa-devel@alsa-project.org>; Fri, 10 Nov 2017 13:29:43 +0100 (CET)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D02EE1E083
 for <alsa-devel@alsa-project.org>; Fri, 10 Nov 2017 13:29:43 +0100 (CET)
Received: from thoth.se.axis.com (unknown [10.0.2.173])
 by boulder03.se.axis.com (Postfix) with ESMTP
 for <alsa-devel@alsa-project.org>; Fri, 10 Nov 2017 13:29:43 +0100 (CET)
Content-Disposition: inline
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

Is there any documentation/rationale for how pcm_dsnoop works in
snd_pcm_{dsnoop_}status?  I am particularly wondering about the ordering
of the snd_pcm_dsnoop_sync_ptr and the snd_pcm_status call on the slave
pcm.

I see occasional spikes (>1000 frames) of difference between the slave
pcm hwpointer after the snd_pcm_status call on it and the pointers in
the dsnoop pcm, and a correspondingly bad avail count.  I suspect the
mismatches are due to process scheduling (the slave pcm status is
delayed because the application process not running and the hardware
progresses during that delay).  Does this seem plausible?  If so, could
the code be simplified to reduce the the number of systemcalls needed?
The status of the slave pcm seems to provide much of the information
used to sync the pointers.  Or is there some other way to get a tighter
coupling between the dsnoop status htstamp and avail count?

Regards,
/henrik

From: Johan Hellman <johan.hellman@axis.com>
Subject: Timestamps using I/O Plugin
Date: Fri, 31 May 2013 11:22:59 +0200
Message-ID: <9A8CA64355151747A180E7910F873F1802B9DFC0B1@xmail3.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ra.se.axis.com (ra.se.axis.com [195.60.68.13])
 by alsa0.perex.cz (Postfix) with ESMTP id 549742619E3
 for <alsa-devel@alsa-project.org>; Fri, 31 May 2013 11:22:38 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by ra.se.axis.com (Postfix) with ESMTP id E39E334965D
 for <alsa-devel@alsa-project.org>; Fri, 31 May 2013 11:22:37 +0200 (CEST)
Received: from ra.se.axis.com ([127.0.0.1])
 by localhost (ra.se.axis.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id E7BFsFWX79l1 for <alsa-devel@alsa-project.org>;
 Fri, 31 May 2013 11:22:36 +0200 (CEST)
Received: from boulder.localdomain (boulder.se.axis.com [10.0.2.104])
 by ra.se.axis.com (Postfix) with ESMTP id 87E0734966B
 for <alsa-devel@alsa-project.org>; Fri, 31 May 2013 11:22:16 +0200 (CEST)
Received: from boulder.localdomain (localhost [127.0.0.1])
 by postfix.imss71 (Postfix) with ESMTP id DC65111C4
 for <alsa-devel@alsa-project.org>; Fri, 31 May 2013 11:20:43 +0200 (CEST)
Received: from seth.se.axis.com (seth.se.axis.com [10.0.2.172])
 by boulder.localdomain (Postfix) with ESMTP id D09D3A85
 for <alsa-devel@alsa-project.org>; Fri, 31 May 2013 11:20:43 +0200 (CEST)
Received: from xmail3.se.axis.com (xmail3.se.axis.com [10.0.5.75])
 by seth.se.axis.com (Postfix) with ESMTP id CF0043E06D
 for <alsa-devel@alsa-project.org>; Fri, 31 May 2013 11:20:43 +0200 (CEST)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I was excited when I found that it was possible to write user space drivers for ALSA, but I can't get my head around how timestamping works when using a I/O plugin instance.

I better start explaining what we want to do.
Basically we just want to transfer raw audio between the HOST running ALSA and one or more small(tiny) network connected MCUs with audio codecs. We need to synchronize the different network sources with the local HW sources (on the ALSA HOST).

Starting looking into how timestamps is handled by ALSA  I could not find how it was possible to set the timestamp, there seems to be some differences compared to using a normal kernel driver!?
If I understand it correctly timestamp can be obtained by calling snd_pcm_status() but the ioplugs implementation of the .status() newer fills in the ->tstamp only the ->trigger_tstamp, so how can I set the timestamp of the data my plugin delivers to ALSA? Additionally snd_pcm_htimestamp() only seams to return the current monotonic clock at the point the function was called for an ioplug instance!?

I saw that there are plugins for pulseaudio and jack doing what we whant to achieve but because of the footprint of the MCU we can't use PA/Jack  on these MCU:s. But how have they solved this issue or isn't it  an issue for their usecase?
/JohanHellman

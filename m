From: Johan Hellman <johan.hellman@axis.com>
Subject: Re: Timestamps using I/O Plugin
Date: Thu, 6 Jun 2013 09:01:12 +0200
Message-ID: <9A8CA64355151747A180E7910F873F1802B88CAF20@xmail3.se.axis.com>
References: <9A8CA64355151747A180E7910F873F1802B9DFC0B1@xmail3.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from anubis.se.axis.com (anubis.se.axis.com [195.60.68.12])
 by alsa0.perex.cz (Postfix) with ESMTP id 8355A265535
 for <alsa-devel@alsa-project.org>; Thu,  6 Jun 2013 09:01:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by anubis.se.axis.com (Postfix) with ESMTP id 2D91A19E04
 for <alsa-devel@alsa-project.org>; Thu,  6 Jun 2013 09:01:15 +0200 (CEST)
Received: from anubis.se.axis.com ([127.0.0.1])
 by localhost (anubis.se.axis.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id yewNxs0TcDoY for <alsa-devel@alsa-project.org>;
 Thu,  6 Jun 2013 09:01:14 +0200 (CEST)
Received: from boulder.localdomain (boulder.se.axis.com [10.0.2.104])
 by anubis.se.axis.com (Postfix) with ESMTP id 0902419DE6
 for <alsa-devel@alsa-project.org>; Thu,  6 Jun 2013 09:01:13 +0200 (CEST)
Received: from boulder.localdomain (localhost [127.0.0.1])
 by postfix.imss71 (Postfix) with ESMTP id BC1E284D
 for <alsa-devel@alsa-project.org>; Thu,  6 Jun 2013 09:01:13 +0200 (CEST)
Received: from seth.se.axis.com (seth.se.axis.com [10.0.2.172])
 by boulder.localdomain (Postfix) with ESMTP id AD8C4818
 for <alsa-devel@alsa-project.org>; Thu,  6 Jun 2013 09:01:13 +0200 (CEST)
Received: from xmail3.se.axis.com (xmail3.se.axis.com [10.0.5.75])
 by seth.se.axis.com (Postfix) with ESMTP id AC09C3E06D
 for <alsa-devel@alsa-project.org>; Thu,  6 Jun 2013 09:01:13 +0200 (CEST)
In-Reply-To: <9A8CA64355151747A180E7910F873F1802B9DFC0B1@xmail3.se.axis.com>
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

After spending more time investigating how I would set monotonic timestamps from a new I/O plugin so that the app using ALSA lib could synchronize different audio streams I cant find that its possible!? 

Can someone please confirm that it is not possible to set monotonic timestamps using the I/O plugin SDK!?

The new plugin would know the relationship between audio streams timestamp information and the systems monotonic clock. If it was possible to override the snd_pcm_htimestamp() then the timestamp could be fetched from the I/O plugin, and snd_pcm_status()->snd_pcm_ioplug_status() could call that overridden function to fill in tstamp into the status object.  If not implemented in the I/O plugin call snd_pcm_generic_real_htimestamp() as today.  Would this be an acceptable way forward? 

/JohanHellman
________________________________________
From: alsa-devel-bounces@alsa-project.org [alsa-devel-bounces@alsa-project.org] On Behalf Of Johan Hellman [johanhn@axis.com]
Sent: Friday, May 31, 2013 11:22 AM
To: alsa-devel@alsa-project.org
Subject: [alsa-devel] Timestamps using I/O Plugin

I was excited when I found that it was possible to write user space drivers for ALSA, but I can't get my head around how timestamping works when using a I/O plugin instance.

I better start explaining what we want to do.
Basically we just want to transfer raw audio between the HOST running ALSA and one or more small(tiny) network connected MCUs with audio codecs. We need to synchronize the different network sources with the local HW sources (on the ALSA HOST).

Starting looking into how timestamps is handled by ALSA  I could not find how it was possible to set the timestamp, there seems to be some differences compared to using a normal kernel driver!?
If I understand it correctly timestamp can be obtained by calling snd_pcm_status() but the ioplugs implementation of the .status() newer fills in the ->tstamp only the ->trigger_tstamp, so how can I set the timestamp of the data my plugin delivers to ALSA? Additionally snd_pcm_htimestamp() only seams to return the current monotonic clock at the point the function was called for an ioplug instance!?

I saw that there are plugins for pulseaudio and jack doing what we whant to achieve but because of the footprint of the MCU we can't use PA/Jack  on these MCU:s. But how have they solved this issue or isn't it  an issue for their usecase?
/JohanHellman




_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

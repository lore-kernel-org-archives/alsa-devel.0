From: Johan Hellman <johan.hellman@axis.com>
Subject: Re: Timestamps using I/O Plugin
Date: Mon, 10 Jun 2013 10:19:31 +0200
Message-ID: <9A8CA64355151747A180E7910F873F1802B88CAF26@xmail3.se.axis.com>
References: <9A8CA64355151747A180E7910F873F1802B9DFC0B1@xmail3.se.axis.com>
 <9A8CA64355151747A180E7910F873F1802B88CAF20@xmail3.se.axis.com>,
 <s5hobbjsith.wl%tiwai@suse.de>,
 <9A8CA64355151747A180E7910F873F1802B88CAF21@xmail3.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from anubis.se.axis.com (anubis.se.axis.com [195.60.68.12])
 by alsa0.perex.cz (Postfix) with ESMTP id 69908260862
 for <alsa-devel@alsa-project.org>; Mon, 10 Jun 2013 10:20:07 +0200 (CEST)
In-Reply-To: <9A8CA64355151747A180E7910F873F1802B88CAF21@xmail3.se.axis.com>
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
To: Johan Hellman <johanhn@axis.com>, Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>If it was possible to override the snd_pcm_htimestamp() then the timestamp could be fetched from the I/O plugin, and snd_pcm_status()->snd_pcm_ioplug_status() could call that overridden function to fill in tstamp into the status object.  If not implemented in the I/O plugin call >snd_pcm_generic_real_htimestamp() as today.  Would this be an acceptable way forward?

Would this be an acceptable way to let a ioplugin support setting timestamps related to the monotonic system clock? The ioplugin implementation would handle the relationship between the systems monotonic clock and the audio streams clock source, making a network source transparent to alsa but the applications could synchronize different streams.

/JohanHellman

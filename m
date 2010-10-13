From: Daniel Mack <daniel@caiaq.de>
Subject: Re: Need expert's advice - Fast Track Ultra (8R)
 dropping samples
Date: Wed, 13 Oct 2010 14:48:13 +0200
Message-ID: <20101013124813.GL7159@buzzloop.caiaq.de>
References: <4CAC89EA.8080207@ladisch.de> <4CACA471.2000504@showlabor.de>
	<4CAD6AA2.4050205@ladisch.de>
	<20101007081010.GZ7159@buzzloop.caiaq.de>
	<4CADB077.3060907@showlabor.de> <4CAEB9AC.1060208@ladisch.de>
	<20101012071831.GA7159@buzzloop.caiaq.de>
	<4CB419D0.70808@showlabor.de>
	<20101012102600.GB7159@buzzloop.caiaq.de>
	<4CB56401.60508@showlabor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id F17892457A
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Oct 2010 14:48:18 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4CB56401.60508@showlabor.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Felix Homann <linuxaudio@showlabor.de>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 13, 2010 at 09:47:13AM +0200, Felix Homann wrote:
> Am 12.10.2010 12:26, schrieb Daniel Mack:
> >If that doesn't work, try debugging the value returned by
> >urb.c:snd_usb_audio_next_packet_size(). For your device, you should end
> >up in the "subs->stream->implicit_feedback" branch.
> 
> I've tested your patch. Unfortunately I don't get any sound.
> snd_usb_audio_next_packet_size() returns from the
> "subs->stream->implicit_feedback" branch. But the return value is
> always 0. ('frames' is returned, not the  0 from the if
> (WARN_ONCE...) statement).

Hmm, ok. That means that the capture stream doesn't see any data.

> Any ideas how to proceed?

Sure :) Can you check whether the capture URBs are started when the
playback stream is kicked off? It should be, and the 'retire' callbacks
should increase the substream's frame counter. Due to the special case I
added, the frames should now always be parsed for this very purpose,
even if the record stream is not in use. You should trace why this
doesn't happen. And once the capture stream sees data,
snd_usb_audio_next_packet_size() will return more reasonable values, and
the playback should also start.

Let me know what you find :)

Daniel

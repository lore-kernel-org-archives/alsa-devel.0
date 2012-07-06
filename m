From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: then there was "overrun" occue every time once
 trigger the audio recording
Date: Fri, 06 Jul 2012 10:23:40 +0200
Message-ID: <4FF6A08C.7070907@ladisch.de>
References: <DBBC59900F0EF340B9938F193FB1A3453625BABA@SC-VEXCH4.marvell.com>
	<4FF69109.4060705@ladisch.de>
	<DBBC59900F0EF340B9938F193FB1A3453625BC85@SC-VEXCH4.marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 9B47B24418
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Jul 2012 10:23:43 +0200 (CEST)
In-Reply-To: <DBBC59900F0EF340B9938F193FB1A3453625BC85@SC-VEXCH4.marvell.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Zhen Fu <fuzh@marvell.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

(please configure your mailer to wrap lines; and please don't top-post!)

Zhen Fu wrote:
> When ALSA send AUDIO_STREAM_CMDID_TRIGGER command to ZSP, ZSP firmware
> do config something and then send AUDIO_STREAM_CMDID_DATARXTXREQ
> command to ALSA, then the ALSA send write/read pointer to ZSP, the ZSP
> through write/read pointer to fetch/transfer data, after process the
> ZSP send AUDIO_STREAM_CMDID_DATARXTX command to ALSA, then the ALSA
> change write/read pointer.

This is not exactly how the driver actually works.

> mmp_zsp_pcm_pointer(struct snd_pcm_substream *substream)
> 	...
> 	x = bytes_to_frames(runtime, x);
> 	if (x == prtd->zsp_buf.buf_len/4)
> 		x = 0;

This assumes that there are four bytes per frame.
If you move the if before the bytes_to_frames, you can use
"if (x == prtd->zsp_buf.buf_len)" which is correct for any frame size.

> 	case AUDIO_STREAM_CMDID_DATARXTX:
> 			snd_pcm_period_elapsed(substream);

Please note that this call must be at the end of each period,
i.e., this code is correct only if each DATARXTX command
transfers exactly one period.

> 	case AUDIO_STREAM_CMDID_DATARXTXREQ:
> 		len1 = get_zsp_buf_avail(&prtd->zsp_buf);
> 		len2 = get_fw_avail(p_zsp_req, substream->stream);
> 		len3 = get_buf_avail(&prtd->zsp_buf, substream->stream);
> 		tsize = ((len1 < len2) ? len1 : len2);
> 		if ((tsize == len1) && (len1 == len3) && (tsize >= \
> 			2 * prtd->zsp_buf.zsp_period_bytes)) {
> 			tsize -= prtd->zsp_buf.zsp_period_bytes;
> 		}

This doesn't look as if tsize is always the same as the period size.
And what do the get_fw_avail and get_buf_avail functions do?

> 		if ((prtd->zsp_buf.zsp_offset + tsize) >= \
> 				(prtd->zsp_buf.buf_len))
> 				prtd->zsp_buf.zsp_offset = 0;
> 		else
> 			prtd->zsp_buf.zsp_offset += \
> 					tsize;

The pointer callback can be called at any time, so you should ensure
that zsp_offset has the correct value at all times, i.e., it should
be updated only after the bytes have actually be transferred, in the
AUDIO_STREAM_CMDID_DATARXTX handler.

That handler should look something like this:

	case AUDIO_STREAM_CMDID_DATARXTX:
		/* determine how many bytes have been transferred */
		tsize = ...;

		spin_lock_irqsave(...);
		mydevice->zsp_offset += tsize;
		if (mydevice->zsp_offset >= buffer_bytes)
			mydevice->zsp_offset -= buffer_bytes;
		spin_lock_irqrestore(...);

		mydevice->period_offset += tsize;
		if (mydevice->period_offset >= period_bytes) {
			mydevice->period_offset -= period_bytes;
			snd_pcm_period_elapsed();
		}

The last check works correctly only if transfers are never
larger than one period.

If the DATARXTX handler and the period callback can be executed
concurrently (which is likely), you need to add locking to both
of them to protect zsp_offset.


Regards,
Clemens

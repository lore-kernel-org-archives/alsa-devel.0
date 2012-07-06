From: Zhen Fu <fuzh@marvell.com>
Subject: Re: then there was "overrun" occue every time once
 trigger the audio recording
Date: Fri, 6 Jul 2012 00:51:27 -0700
Message-ID: <DBBC59900F0EF340B9938F193FB1A3453625BC85@SC-VEXCH4.marvell.com>
References: <DBBC59900F0EF340B9938F193FB1A3453625BABA@SC-VEXCH4.marvell.com>
	<4FF69109.4060705@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog101.obsmtp.com (na3sys009aog101.obsmtp.com
	[74.125.149.67])
	by alsa0.perex.cz (Postfix) with ESMTP id 95C72103F67
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Jul 2012 10:03:08 +0200 (CEST)
In-Reply-To: <4FF69109.4060705@ladisch.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Zhen Fu <fuzh@marvell.com>
List-Id: alsa-devel@alsa-project.org

Ok, I got it.

I use marvell pxa2128 chip include ZSP core that connection codec, my aim to let zsp complete independence alsa work. 
When ALSA send AUDIO_STREAM_CMDID_TRIGGER command to ZSP, ZSP firmware do config something and then send AUDIO_STREAM_CMDID_DATARXTXREQ command to ALSA, then the ALSA send write/read pointer to ZSP, the ZSP through write/read pointer to fetch/transfer data, after process the ZSP send AUDIO_STREAM_CMDID_DATARXTX command to ALSA, then the ALSA change write/read pointer. My driver code below:

static snd_pcm_uframes_t
mmp_zsp_pcm_pointer(struct snd_pcm_substream *substream)
{
	struct snd_pcm_runtime *runtime = substream->runtime;
	struct pxa910_runtime_data *prtd = runtime->private_data;
	snd_pcm_uframes_t x;

	x = prtd->zsp_buf.zsp_offset;
	x = bytes_to_frames(runtime, x);
	if (x == prtd->zsp_buf.buf_len/4)
		x = 0;

	return x;
}

static void zsp_msg_handler(struct work_struct *work) {
	......
	.....
	case AUDIO_STREAM_CMDID_DATARXTXREQ:
		p_zsp_req = (cmd_audio_stream_datarxtxreq_t *)\
				&zsp_data_received;
		len1 = get_zsp_buf_avail(&prtd->zsp_buf);
		len2 = get_fw_avail(p_zsp_req, substream->stream);
		len3 = get_buf_avail(&prtd->zsp_buf, substream->stream);
		tsize = ((len1 < len2) ? len1 : len2);
		if ((tsize == len1) && (len1 == len3) && (tsize >= \
			2 * prtd->zsp_buf.zsp_period_bytes)) {
			tsize -= prtd->zsp_buf.zsp_period_bytes;
		}
		cmd_strm_tx.command_id = AUDIO_STREAM_CMDID_DATARXTX;
		cmd_strm_tx.stream_id = prtd->stream_id;
		cmd_strm_tx.addr = prtd->zsp_buf.buf_phys +	\
				prtd->zsp_buf.zsp_offset;
		cmd_strm_tx.size = tsize;
		kzmq_write(prtd->zmq_deliver, (void *)&cmd_strm_tx,
					   sizeof(cmd_audio_stream_datarxtx_t));
		if ((prtd->zsp_buf.zsp_offset + tsize) >= \
				(prtd->zsp_buf.buf_len))
				prtd->zsp_buf.zsp_offset = 0;
		else
			prtd->zsp_buf.zsp_offset += \
					tsize;
		break;
	case AUDIO_STREAM_CMDID_DATARXTX:
			snd_pcm_period_elapsed(substream);
			break;

}   

When I use arecord command occue "overrun", I don't know I explain problem clear or not. Thanks a lot.
--
Best Regards,
Zhen Fu

-----Original Message-----
From: alsa-devel-bounces@alsa-project.org [mailto:alsa-devel-bounces@alsa-project.org] On Behalf Of Clemens Ladisch
Sent: Friday, July 06, 2012 3:17 PM
To: alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] then there was "overrun" occue every time once trigger the audio recording

(please configure your mailer to wrap lines)

Zhen Fu wrote:
> When I use arecord command, then there was "overrun" occue every time
> once trigger the audio recording.  I have no clue of alsa driver when
> and how handler xrun. In other words, how to understand function
> snd_pcm_update_hw_ptr0 in pcm_lib.c.

It behaves pretty much the same for playback and capture, so I refer
the honourable gentleman to the reply I gave some moments ago.

If you want a more specific answer, it might be a good idea not to
keep the hardware and your driver source code a secret.


Regards,
Clemens
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

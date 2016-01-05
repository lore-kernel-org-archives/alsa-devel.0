From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [RFC v2 1/6] drm/mediatek: hdmi: Add audio
 interface to the hdmi-codec driver
Date: Tue, 05 Jan 2016 15:56:36 +0100
Message-ID: <1452005796.3391.67.camel@pengutronix.de>
References: <1451934551-21333-1-git-send-email-p.zabel@pengutronix.de>
 <1451934551-21333-2-git-send-email-p.zabel@pengutronix.de>
 <20160104222920.GQ19062@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.4.pengutronix.de (metis.ext.4.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 92C1E2610C5
 for <alsa-devel@alsa-project.org>; Tue,  5 Jan 2016 15:56:42 +0100 (CET)
In-Reply-To: <20160104222920.GQ19062@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Jean-Francois Moine <moinejf@free.fr>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Arnaud Pouliquen <arnaud.pouliquen@st.com>, Koro Chen <koro.chen@mediatek.com>, Jyri Sarha <jsarha@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-mediatek@lists.infradead.org, Daniel Kurtz <djkurtz@chromium.org>, kernel@pengutronix.de, Matthias Brugger <matthias.bgg@gmail.com>, Cawa Cheng <cawa.cheng@mediatek.com>
List-Id: alsa-devel@alsa-project.org

Hi Russell,

Am Montag, den 04.01.2016, 22:29 +0000 schrieb Russell King - ARM Linux:
> On Mon, Jan 04, 2016 at 08:09:06PM +0100, Philipp Zabel wrote:
> > Add the interface needed by Jyri's generic hdmi-codec driver [1] to start
> > or stop audio playback and to retrieve ELD (EDID like data) to limit the
> > supported audio formats to the HDMI sink capabilities.
> 
> Some of this makes me rather suspicious.

Thanks for being suspicious, then.

> > +	switch (params->sample_rate) {
> > +	case 32000:
> > +		hdmi_params.aud_hdmi_fs = HDMI_AUDIO_SAMPLE_FREQUENCY_32000;
> > +		hdmi_params.iec_frame_fs = HDMI_IEC_32K;
> > +		/* channel status byte 3: fs and clock accuracy */
> > +		hdmi_params.hdmi_l_channel_state[3] = 0x3;
> > +		break;
> > +	case 44100:
> > +		hdmi_params.aud_hdmi_fs = HDMI_AUDIO_SAMPLE_FREQUENCY_44100;
> > +		hdmi_params.iec_frame_fs = HDMI_IEC_44K;
> > +		/* channel status byte 3: fs and clock accuracy */
> > +		hdmi_params.hdmi_l_channel_state[3] = 0;
> > +		break;
> > +	case 48000:
> > +		hdmi_params.aud_hdmi_fs = HDMI_AUDIO_SAMPLE_FREQUENCY_48000;
> > +		hdmi_params.iec_frame_fs = HDMI_IEC_48K;
> > +		/* channel status byte 3: fs and clock accuracy */
> > +		hdmi_params.hdmi_l_channel_state[3] = 0x2;
> > +		break;
> > +	case 88200:
> > +		hdmi_params.aud_hdmi_fs = HDMI_AUDIO_SAMPLE_FREQUENCY_88200;
> > +		hdmi_params.iec_frame_fs = HDMI_IEC_88K;
> > +		/* channel status byte 3: fs and clock accuracy */
> > +		hdmi_params.hdmi_l_channel_state[3] = 0x8;
> > +		break;
> > +	case 96000:
> > +		hdmi_params.aud_hdmi_fs = HDMI_AUDIO_SAMPLE_FREQUENCY_96000;
> > +		hdmi_params.iec_frame_fs = HDMI_IEC_96K;
> > +		/* channel status byte 3: fs and clock accuracy */
> > +		hdmi_params.hdmi_l_channel_state[3] = 0xa;
> > +		break;
> > +	case 176400:
> > +		hdmi_params.aud_hdmi_fs = HDMI_AUDIO_SAMPLE_FREQUENCY_176400;
> > +		hdmi_params.iec_frame_fs = HDMI_IEC_176K;
> > +		/* channel status byte 3: fs and clock accuracy */
> > +		hdmi_params.hdmi_l_channel_state[3] = 0xc;
> > +		break;
> > +	case 192000:
> > +		hdmi_params.aud_hdmi_fs = HDMI_AUDIO_SAMPLE_FREQUENCY_192000;
> > +		hdmi_params.iec_frame_fs = HDMI_IEC_192K;
> > +		/* channel status byte 3: fs and clock accuracy */
> > +		hdmi_params.hdmi_l_channel_state[3] = 0xe;
> 
> For exmaple, all the above.  The HDMI standards say that the audio info
> frame "shall" always set the sample frequency to "refer to stream" for
> L-PCM and IEC61937 compressed audio.  The above looks like it violates
> the HDMI specification as I'm willing to bet that hdmi_params.aud_hdmi_fs
> gets passed over into the audio info frame.
>
> Many of the fields in the audio info frame are supposed to be set as
> "refer to stream".  I'd suggest ensuring that you're compliant with
> these.

The audio inforame is generated using

        struct hdmi_audio_infoframe frame;
        hdmi_audio_infoframe_init(&frame);
        frame.coding_type = HDMI_AUDIO_CODING_TYPE_STREAM;
        frame.sample_frequency = HDMI_AUDIO_SAMPLE_FREQUENCY_STREAM;
        frame.sample_size = HDMI_AUDIO_SAMPLE_SIZE_STREAM;
        frame.channels =
            mtk_hdmi_aud_get_chnl_count(
            hdmi->aud_param.aud_input_chan_type);
        hdmi_audio_infoframe_pack(&frame, buffer, sizeof(buffer));

later. aud_hdmi_fs/iec_frame_fs are used to select the values written to
the N/CTS register. Instead of those I could just pass the sample_rate
down to the lower layers.

> The second thing is that "hdmi_params.hdmi_l_channel_state" looks like
> it's the IEC958 bytes.  These must be correct for some of the higher
> end HDMI receivers (eg, Yamaha RX-V677) to correctly process the audio.

I think you are right. These values are written to 24-byte register sets
"L_STATUS" and "R_STATUS" (padded with zeroes) as well as to the 5-byte
register set "I2S_C_STA" for the first five bytes.

> > +		break;
> > +	default:
> > +		dev_err(hdmi->dev, "rate[%d] not supported!\n",
> > +			params->sample_rate);
> > +		return -EINVAL;
> > +	}
> > +
> > +	switch (daifmt->fmt) {
> > +	case HDMI_I2S:
> > +		hdmi_params.aud_codec = HDMI_AUDIO_CODING_TYPE_PCM;
> > +		hdmi_params.aud_sampe_size = HDMI_AUDIO_SAMPLE_SIZE_16;
> > +		hdmi_params.aud_input_type = HDMI_AUD_INPUT_I2S;
> > +		hdmi_params.aud_i2s_fmt = HDMI_I2S_MODE_I2S_24BIT;
> > +		hdmi_params.aud_mclk = HDMI_AUD_MCLK_128FS;
> > +		break;
> > +	default:
> > +		dev_err(hdmi->dev, "%s: Invalid format %d\n", __func__,
> > +			daifmt->fmt);
> > +		return -EINVAL;
> > +	}
> > +
> > +	/* channel status */
> > +	/* byte 0: no copyright is asserted, mode 0 */
> > +	hdmi_params.hdmi_l_channel_state[0] = 1 << 2;
> > +	/* byte 1: category code */
> > +	hdmi_params.hdmi_l_channel_state[1] = 0;
> > +	/* byte 2: source/channel number don't take into account */
> > +	hdmi_params.hdmi_l_channel_state[2] = 0;
> > +	/* byte 4: word length 16bits */
> > +	hdmi_params.hdmi_l_channel_state[4] = 0x2;
> > +	memcpy(hdmi_params.hdmi_r_channel_state,
> > +	       hdmi_params.hdmi_l_channel_state,
> > +	       sizeof(hdmi_params.hdmi_l_channel_state));
> 
> Hmm, yes, it is the IEC958 channel status bytes.  We have a helper
> for this - snd_pcm_create_iec958_consumer().

hdmi-codec already calls snd_pcm_create_iec958_consumer and provides the
result via params->iec.state, so I'll try to just use that.

regards
Philipp

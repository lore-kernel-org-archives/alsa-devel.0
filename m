From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Mixer volume/decibel mapping
Date: Fri, 28 May 2010 16:10:59 +0200
Message-ID: <4BFFCEF3.9060309@ladisch.de>
References: <201005191834.57919.vand2@gmx.de>	<AANLkTimRTIwmzU2Dq4lgBSSwtcmSxfMcBfcll9YDC_l5@mail.gmail.com>	<4BF629B3.9020904@ladisch.de>	<201005210951.36495.peter.ujfalusi@nokia.com>	<4BF658C6.4030404@ladisch.de>	<AANLkTik7mD1DAVWkOwM7sNu0EfgGApvzX9WRXWBOO4PI@mail.gmail.com>	<4BFB8E3E.3010209@ladisch.de>	<AANLkTin7CGFuW_fhHEbhaDB77DLbKoTvck7YvuzVzGUw@mail.gmail.com>	<4BFBE056.9000706@ladisch.de>
	<AANLkTinxF-OdPg_mZabDfupb_knV0uh2bslOQeBXyDgp@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5.smtp.messagingengine.com (out5.smtp.messagingengine.com
	[66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id A0F98103B13
	for <alsa-devel@alsa-project.org>;
	Fri, 28 May 2010 16:11:33 +0200 (CEST)
In-Reply-To: <AANLkTinxF-OdPg_mZabDfupb_knV0uh2bslOQeBXyDgp@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Julian Scheel <julian@jusst.de>
List-Id: alsa-devel@alsa-project.org

Raymond Yau wrote:
> 2010/5/25 Clemens Ladisch <clemens@ladisch.de>
> > Raymond Yau wrote:
> > > I have doubt about DECLARE_TLV_DB_LINEAR(ak4396_db_scale, TLV_DB_GAIN_MUTE, 0);
> > >
> > > since the datasheet mention that dB range is only -48dB to 0dB
> > >
> > > ATT = 20 log10 (ATT_DATA / 255) [dB]
> > >
> > > How can AK4396 has scale of -inf DB to 0dB in the driver code  ?
> >
> > When ATT_DATA = 0, there is no output, which is an attenuation of -inf.
> > The next value, ATT_DATA = 1, results in ATT = -48 dB.
> 
> refer to ice1712/prodigy_hifi.c , why the comment is -64dB to 0dB  ?
> 
> /*
>  * DAC volume attenuation mixer control (-64dB to 0dB)
> */

Apparently just copied from pontis.c.

> static int ak4396_dac_vol_info(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
> {
>         uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
>         uinfo->count = 2;
>         uinfo->value.integer.min = 0;   /* mute */
>         uinfo->value.integer.max = 0xFF; /* linear */
>        return 0;
> }
> ...
> static const DECLARE_TLV_DB_SCALE(db_scale_wm_dac, -12700, 100, 1);

And this defines a dB scale from -127 dB to +128 dB, which will break
PulseAudio's volume calculations.

> > This is true regardless of the precision of the multiplier.  Even a one-
> > bit factor behaves like this; in fact, this would describe a mute switch.
> 
> This mean that the dB range should be calculated from the next step above
> the min_dB and max_dB when min_dB regarded as a mute switch

No; the AK4396 datasheet mentions -48 dB only because this is the minimum
attenuation that isn't completely mute.  The minimum of the ATT_DATA
registers _is_ zero, i.e. -inf dB, and therefore TLV_DB_GAIN_MUTE is the
correct minimum for the dB range.


Regards,
Clemens

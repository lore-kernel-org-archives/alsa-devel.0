From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re:
	Question	about	snd_mixer_selem_get_playback_dB_range()
Date: Tue, 22 Mar 2011 09:02:18 +0200
Message-ID: <4D88497A.4090702@nokia.com>
References: <1300711933.24854.263.camel@IT-W2076>	<AANLkTi=jXgTmNUM=RG=AuToV9Z-gNpVAmPWSk8Zq4GSs@mail.gmail.com>	<1300715722.24854.290.camel@IT-W2076>
	<4D876303.3090100@ladisch.de> <1300718695.24854.310.camel@IT-W2076>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-sa02.nokia.com (smtp.nokia.com [147.243.1.48])
	by alsa0.perex.cz (Postfix) with ESMTP id 0F1ED103826
	for <alsa-devel@alsa-project.org>; Tue, 22 Mar 2011 08:02:20 +0100 (CET)
In-Reply-To: <1300718695.24854.310.camel@IT-W2076>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Tanu Kaskinen <tanu.kaskinen@digia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On 03/21/11 16:44, ext Tanu Kaskinen wrote:
>>> Is it a bug in alsa (the driver or alsa-lib or whatever) if
>>> snd_mixer_selem_get_playback_dB_range() returns something else than
>>> SND_CTL_TLV_DB_GAIN_MUTE as the min gain, if the lowest volume step for
>>> the element is mute?
>>
>> Yes.
> =

> Thank you for the answer!

AFAIK the SND_CTL_TLV_DB_GAIN_MUTE received a fix regarding to this:
2f6206da0c1ff88235e6eca0077343f22a4b43ee
tlv: fix returned dB information for min-is-mute controls

Looking at the patch itself, it does going to return
min=3DSND_CTL_TLV_DB_GAIN_MUTE from snd_tlv_get_dB_range function.

However I have my doubts, if this is the correct way...

Take these two gain controls for example:
RAW value   GAIN1  GAIN2
   0        mute   mute
   1        -2dB   0dB
   2         0dB   1dB
   3         2dB   2dB

If user space asks for the dB_range:
        min    max
GAIN1   mute   2dB
GAIN2   mute   2dB

They are going to return with the same range, however if you ask for
-2dB on both:
GAIN1 will be -2dB
GAIN2 will be muted

So we are kind of hiding the dB range for the control.
I don't know how to fix it (well, I have some ideas, but it would need
changes in the API IMHO).

-- =

P=E9ter

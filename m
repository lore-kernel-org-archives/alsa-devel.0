From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ASoC: tlv320aic3x: Correct S24_3LE support
Date: Fri, 13 Dec 2013 15:29:33 +0200
Message-ID: <52AB0BBD.2020001@ti.com>
References: <1386939499-5163-1-git-send-email-peter.ujfalusi@ti.com>
 <20131213130443.GY11044@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id 52C12261606
 for <alsa-devel@alsa-project.org>; Fri, 13 Dec 2013 14:29:37 +0100 (CET)
In-Reply-To: <20131213130443.GY11044@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 12/13/2013 03:04 PM, Mark Brown wrote:
> On Fri, Dec 13, 2013 at 02:58:19PM +0200, Peter Ujfalusi wrote:
> =

>> -	case SNDRV_PCM_FORMAT_S24_LE:
>> +	case SNDRV_PCM_FORMAT_S24_3LE:
>>  		data |=3D (0x02 << 4);
>>  		break;
> =

> This should be adding the case for the new format rather than replacing
> the old one shouldn't it?  They ought to turn out the same on the AIF so
> the CODECs shouldn't care about the difference, ideally the core would
> hide the difference from them.

Not really since the codec has only field to specify the data format. The
codec can not support S24_LE (S24_LE is basically S32_LE msbits=3D=3D24) si=
nce we
can not say to the codec to ignore the 8bit over the 24 bits of real data.
In case of S24_3LE the I2S bus will have 24 clocks/per channel which can not
be used to stream S24_LE either.

-- =

P=E9ter

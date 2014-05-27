From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 0/2] ASoC: tlv320aic3x: Fix
 snd_soc_dapm_put_volsw_aic3x callback
Date: Tue, 27 May 2014 16:04:38 +0300
Message-ID: <53848D66.1050204@ti.com>
References: <1401187986-11059-1-git-send-email-peter.ujfalusi@ti.com>
 <20140527110259.GM12304@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id 08C1A2655D7
 for <alsa-devel@alsa-project.org>; Tue, 27 May 2014 15:04:43 +0200 (CEST)
In-Reply-To: <20140527110259.GM12304@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Mark,

On 05/27/2014 02:02 PM, Mark Brown wrote:
> On Tue, May 27, 2014 at 01:53:04PM +0300, Peter Ujfalusi wrote:
>> Hi,
>>
>> Commit "cf7c1de20c576 ASoC: dapm: Move 'value' field from widget to
>> control" changed the way how the 'value' has been stored for a widget.
>> This resulted issues with codec drivers needing and using custom dapm put
>> callbacks to handle the hw underneath, like the tlv320aic3x driver.
>> Since the driver is not updated following the mentioned commit it is mos=
tly
>> broken when we try to change Left/Righ PGA mixers:
> =

> Applied both, thanks.

After discussing this with Lars over the IRC, would it be possible to drop
these patches? I'll come back with another set to fix this issue tomorrow.

Thanks,
P=E9ter

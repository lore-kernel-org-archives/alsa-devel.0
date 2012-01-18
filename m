From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v5] ASoC: Apply msbits constraint for
 sample size bigger than the msbits
Date: Wed, 18 Jan 2012 16:43:36 +0100
Message-ID: <4F16E8A8.9070209@ti.com>
References: <1326899114-26979-1-git-send-email-peter.ujfalusi@ti.com>
	<4F16E6C7.5070502@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog111.obsmtp.com (na3sys009aog111.obsmtp.com
	[74.125.149.205])
	by alsa0.perex.cz (Postfix) with ESMTP id A71A924661
	for <alsa-devel@alsa-project.org>; Wed, 18 Jan 2012 16:43:51 +0100 (CET)
Received: by mail-yw0-f42.google.com with SMTP id n55so148485yhn.29
	for <alsa-devel@alsa-project.org>; Wed, 18 Jan 2012 07:43:37 -0800 (PST)
In-Reply-To: <4F16E6C7.5070502@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On 01/18/2012 04:35 PM, Clemens Ladisch wrote:
> Peter Ujfalusi wrote:
>> We run the loop as long as the sample size is bigger than the requested
>> msbits.
> =

>> +	while (sample_sizes[i] > bits && i < ARRAY_SIZE(sample_sizes)) {
> =

> This will overrun sample_sizes[] if bits < 8.

which is prevented by the: && i < ARRAY_SIZE(sample_sizes)

-- =

P=E9ter

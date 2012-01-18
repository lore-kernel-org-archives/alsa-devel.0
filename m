From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v5] ASoC: Apply msbits constraint for
 sample size bigger than the msbits
Date: Wed, 18 Jan 2012 16:49:36 +0100
Message-ID: <4F16EA10.6080306@ti.com>
References: <1326899114-26979-1-git-send-email-peter.ujfalusi@ti.com>
	<4F16E6C7.5070502@ladisch.de> <4F16E8A8.9070209@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog106.obsmtp.com (na3sys009aob106.obsmtp.com
	[74.125.149.76]) by alsa0.perex.cz (Postfix) with ESMTP id 4E03924669
	for <alsa-devel@alsa-project.org>; Wed, 18 Jan 2012 16:49:51 +0100 (CET)
Received: by mail-yw0-f49.google.com with SMTP id j72so2939688yhj.8
	for <alsa-devel@alsa-project.org>; Wed, 18 Jan 2012 07:49:38 -0800 (PST)
In-Reply-To: <4F16E8A8.9070209@ti.com>
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

On 01/18/2012 04:43 PM, Peter Ujfalusi wrote:
> On 01/18/2012 04:35 PM, Clemens Ladisch wrote:
>> Peter Ujfalusi wrote:
>>> We run the loop as long as the sample size is bigger than the requested
>>> msbits.
>>
>>> +	while (sample_sizes[i] > bits && i < ARRAY_SIZE(sample_sizes)) {
>>
>> This will overrun sample_sizes[] if bits < 8.
> =

> which is prevented by the: && i < ARRAY_SIZE(sample_sizes)

I take it back. True, we overrun. These need to be swapped.

-- =

P=E9ter

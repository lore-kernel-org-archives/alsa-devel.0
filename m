From: "Girdwood, Liam" <lrg@ti.com>
Subject: Re: [PATCH v2] ASoC: ad193x: Use snd_soc_update_bits
	for read-modify-write
Date: Wed, 19 Oct 2011 09:01:49 +0100
Message-ID: <CABS+qY1puXbMmgb8RMgoQydp7fKX4KJ9Z6GEZ40--X_fDBCxZQ@mail.gmail.com>
References: <1318890308.15935.0.camel@phoenix>
	<4E9D9F88.109@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog122.obsmtp.com (na3sys009aog122.obsmtp.com
	[74.125.149.147])
	by alsa0.perex.cz (Postfix) with ESMTP id 9C5AD243F7
	for <alsa-devel@alsa-project.org>;
	Wed, 19 Oct 2011 10:01:51 +0200 (CEST)
Received: by mail-gy0-f181.google.com with SMTP id 5so1905367gye.26
	for <alsa-devel@alsa-project.org>; Wed, 19 Oct 2011 01:01:49 -0700 (PDT)
In-Reply-To: <4E9D9F88.109@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Axel Lin <axel.lin@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Barry Song <21cnbao@gmail.com>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 18 October 2011 16:47, Lars-Peter Clausen <lars@metafoo.de> wrote:
> On 10/18/2011 12:25 AM, Axel Lin wrote:
>> Use snd_soc_update_bits for read-modify-write register access instead of
>> open-coding it using snd_soc_read and snd_soc_write
>>
>> Signed-off-by: Axel Lin <axel.lin@gmail.com>
>
> Acked-by: Lars-Peter Clausen <lars@metafoo.de>
>

Acked-by: Liam Girdwood <lrg@ti.com>

From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [PATCH v2] ASoC: samsung: i2s: Null pointer
 dereference on samsung_i2s_remove
Date: Fri, 11 Aug 2017 15:00:22 +0200
Message-ID: <029a9c75-b8ca-1969-d846-fb49c4bc41bf@samsung.com>
References: <CGME20170811123601epcas4p49ca200aaa39cae3fa0f6cba5bf86f1f8@epcas4p4.samsung.com>
 <1502454942-739-1-git-send-email-vasilyev@ispras.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
 by alsa0.perex.cz (Postfix) with ESMTP id 5F09D2675CA
 for <alsa-devel@alsa-project.org>; Fri, 11 Aug 2017 15:00:31 +0200 (CEST)
In-reply-to: <1502454942-739-1-git-send-email-vasilyev@ispras.ru>
Content-language: en-GB
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Anton Vasilyev <vasilyev@ispras.ru>
Cc: ldv-project@linuxtesting.org, alsa-devel@alsa-project.org, Sangbeom Kim <sbkim73@samsung.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Krzysztof Kozlowski <krzk@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On 08/11/2017 02:35 PM, Anton Vasilyev wrote:
> If (quirks & QUIRK_SEC_DAI == 0) then samsung_i2s_probe() doesn't allocate
> sec_dai and pri_dai->sec_dai remains Null, but samsung_i2s_remove()
> permorms pri_dai->sec_dai dereference in any case.
   ^^^^^^^^
Still you have a typo here. ;)

> The patch adds sec_dai check on Null before derefence at
> samsung_i2s_remove().
> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Signed-off-by: Anton Vasilyev<vasilyev@ispras.ru>

Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>

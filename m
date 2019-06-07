From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [PATCH] ASoC: Fix freeing of incompletely
 initialized snd_soc_dapm_context
Date: Fri, 7 Jun 2019 17:23:22 +0200
Message-ID: <11aad80c-bdde-9a09-c74f-8082e6ee50c4@samsung.com>
References: <CGME20190607141821epcas2p120786c8cc5a1f1b71dbd1828b0a9d837@epcas2p1.samsung.com>
 <20190607141745.759-1-s.nawrocki@samsung.com>
 <CA+Px+wUOjG9YvDrPud7TH1xdBVDX50Y9f3mA8hgyFQBVTgM==A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5A3A2F896CE
 for <alsa-devel@alsa-project.org>; Fri,  7 Jun 2019 17:23:40 +0200 (CEST)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20190607152337euoutp01e2aafe5a7cf75810576430941fa91c95~l8_aNfMot2226322263euoutp01c
 for <alsa-devel@alsa-project.org>; Fri,  7 Jun 2019 15:23:37 +0000 (GMT)
In-Reply-To: <CA+Px+wUOjG9YvDrPud7TH1xdBVDX50Y9f3mA8hgyFQBVTgM==A@mail.gmail.com>
Content-Language: en-GB
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Tzung-Bi Shih <tzungbi@google.com>
Cc: ALSA development <alsa-devel@alsa-project.org>, Jimmy Cheng-Yi Chiang <cychiang@google.com>, kuninori.morimoto.gx@renesas.com, b.zolnierkie@samsung.com, Liam Girdwood <lgirdwood@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, Mark Brown <broonie@kernel.org>, Dylan Reid <dgreid@google.com>, m.szyprowski@samsung.com
List-Id: alsa-devel@alsa-project.org

On 6/7/19 17:02, Tzung-Bi Shih wrote:
> Based on current for-next branch, we could simply remove the
> soc_cleanup_card_resources() call.

Thank you for looking into this, I will post a patch removing that
unnecessary call instead.

From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [PATCH] ASoC: samsung: odroid: Add missing DAPM routes
Date: Fri, 15 Feb 2019 13:45:34 +0100
Message-ID: <ddefa7c5-3341-dd4b-9088-2ae8c9db050b@samsung.com>
References: <CGME20190215120457epcas2p3cd14657fc2159c058ab6448c10a47648@epcas2p3.samsung.com>
        <20190215120422.22907-1-s.nawrocki@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20190215120422.22907-1-s.nawrocki@samsung.com>
Content-language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: lgirdwood@gmail.com, krzk@kernel.org, sbkim73@samsung.com, m.szyprowski@samsung.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 2/15/19 13:04, Sylwester Nawrocki wrote:
> With old DTS there will be missing DAPM routes linking BE with CODECs.
> Add those routes in the card driver so sound works properly on Odroid
> XU3/4 also without DTS updates enabling the secondary PCM.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>

I forgot to add: 

Reported-by: Krzysztof Kozlowski <krzk@kernel.org>

From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [alsa-devel] [PATCH 1/3] ASoC: fsl_ssi: mark SACNT register volatile
Date: Tue, 5 Jan 2016 12:57:27 -0200
Message-ID: <CAOMZO5CQ_jeEQTri9eFsib1yPDLCCRDkvk8+7Y=S==8VMOpA9g@mail.gmail.com>
References: <56770FE1.4060202@maciej.szmigiero.name>
	<CAOZdJXVK-_j+pF+dXsnWd0AQZWD3p9+=ziS3Byw5e2ED1W_W=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAOZdJXVK-_j+pF+dXsnWd0AQZWD3p9+=ziS3Byw5e2ED1W_W=g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Timur Tabi <timur@tabi.org>
Cc: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Xiubo Li <Xiubo.Lee@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: alsa-devel@alsa-project.org

Timur,

On Thu, Dec 24, 2015 at 2:12 PM, Timur Tabi <timur@tabi.org> wrote:
> On Sun, Dec 20, 2015 at 2:30 PM, Maciej S. Szmigiero
> <mail@maciej.szmigiero.name> wrote:
>> SACNT register should be marked volatile since
>> its WR and RD bits are cleared by SSI after
>> completing the relevant operation.
>> This unbreaks AC'97 register access.
>>
>> Fixes: 05cf237972fe ("ASoC: fsl_ssi: Add driver suspend and resume to support MEGA Fast")
>>
>> Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
>
> These patches seem okay, but can we hold off merging them until I get
> back from vacation and have a chance to review them?

Have you had a chance to review these patches?

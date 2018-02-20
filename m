From: Fabio Estevam <festevam@gmail.com>
Subject: Re: ASoC: Failed to create component debugfs directory
Date: Tue, 20 Feb 2018 15:43:17 -0300
Message-ID: <CAOMZO5AHCkFOmjCVU1BZ__QWsNYtps5WCU5zhBg2hYcX7Z_kxg@mail.gmail.com>
References: <CAOMZO5D071pPr4fL7eLwWgX6h8Mppwic2u4mUCGzUZiss-+3MQ@mail.gmail.com>
 <2bf70c96-1ecc-50b5-b936-7372c4b23276@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ot0-f175.google.com (mail-ot0-f175.google.com
 [74.125.82.175])
 by alsa0.perex.cz (Postfix) with ESMTP id 8B3C9267502
 for <alsa-devel@alsa-project.org>; Tue, 20 Feb 2018 19:43:19 +0100 (CET)
Received: by mail-ot0-f175.google.com with SMTP id s4so12328197oth.7
 for <alsa-devel@alsa-project.org>; Tue, 20 Feb 2018 10:43:19 -0800 (PST)
In-Reply-To: <2bf70c96-1ecc-50b5-b936-7372c4b23276@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi Srinivas,

On Tue, Feb 20, 2018 at 3:37 PM, Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:

> I hit something similar while testing some of the qcom sound card.
>
> This patch fixed the issue for me:
>
>
> https://git.linaro.org/people/srinivas.kandagatla/linux.git/commit/?h=v4.16-rc1-dsp-audio-v3&id=b91fa95c38912dd8a9f56ebdb9b59449252798ef
>
> Its basically to do with nested device tree nodes, the device name seems to
> exceed the NAME_SIZE of 32 bytes.

Thanks for the suggestion, but this does not solve the issue on my case.

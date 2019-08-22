From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/3] input: Add SW_UNSUPPORT_INSERT define
Date: Thu, 22 Aug 2019 11:16:19 -0700
Message-ID: <20190822181619.GH76194@dtor-ws>
References: <1558730438-16524-1-git-send-email-bgoswami@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E8D6CF80112
 for <alsa-devel@alsa-project.org>; Thu, 22 Aug 2019 20:16:26 +0200 (CEST)
Received: by mail-pg1-x529.google.com with SMTP id w10so4126389pgj.7
 for <alsa-devel@alsa-project.org>; Thu, 22 Aug 2019 11:16:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1558730438-16524-1-git-send-email-bgoswami@codeaurora.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: bgoswami@codeaurora.org
Cc: alsa-devel@alsa-project.org, plai@codeaurora.org, tiwai@suse.com, broonie@kernel.org, srinivas.kandagatla@linaro.org, linux-input@vger.kernel.org, Gopikrishnaiah Anandan <agopik@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

Hi Banajit,

On Fri, May 24, 2019 at 01:40:38PM -0700, bgoswami@codeaurora.org wrote:
> From: Banajit Goswami <bgoswami@codeaurora.org>
> 
> Some devices may not support specific type of input devices. For example,
> when a headset or extension cable with GND/MIC swap is plugged into a
> headset jack that does not support the headset/cable, it needs to be
> reported with a corresponding input event. Also, increase the max values
> for INPUT_DEVICE_ID_SW_MAX and SW_MAX, to accommodate future extension of
> the number of event.

I do not think that adding this switch is a good idea as it will not
allow you to easily extend the reporting and to convey to the user why
something is not supported. I would look into alternate mechanism to
signal when and why a headset/peripheral was rejected.

Thanks.

-- 
Dmitry

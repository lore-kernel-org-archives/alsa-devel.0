From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: Re: [PATCH 4/5] ASoC: tegra: Use NULL instead of 0 for
	pointers
Date: Tue, 22 Jan 2013 10:31:09 +0530
Message-ID: <CAK9yfHyGmQYh5jp2sVySSXcXmm9HPaYxLM67CSF5MF5Dbb7rVA@mail.gmail.com>
References: <1358760566-3803-1-git-send-email-sachin.kamat@linaro.org>
 <1358760566-3803-5-git-send-email-sachin.kamat@linaro.org>
 <50FD779E.5010800@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f176.google.com (mail-ob0-f176.google.com
 [209.85.214.176])
 by alsa0.perex.cz (Postfix) with ESMTP id 26A7C264FF5
 for <alsa-devel@alsa-project.org>; Tue, 22 Jan 2013 06:01:10 +0100 (CET)
Received: by mail-ob0-f176.google.com with SMTP id un3so6626103obb.35
 for <alsa-devel@alsa-project.org>; Mon, 21 Jan 2013 21:01:09 -0800 (PST)
In-Reply-To: <50FD779E.5010800@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, swarren@nvidia.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On 21 January 2013 22:45, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 01/21/2013 02:29 AM, Sachin Kamat wrote:
>> Fixes the following sparse warnings:
>> sound/soc/tegra/tegra30_ahub.c:583:16: warning:
>> Using plain integer as NULL pointer
>> sound/soc/tegra/tegra30_ahub.c:600:16: warning:
>> Using plain integer as NULL pointer
>
> Out of curiosity, which compiler is this with; I've never seen this warning.

This is actually a sparse warning which you can see if you build the
kernel with C=1 (or C=2) option as below:

  make C=1   [targets] Check all c source with $CHECK (sparse by default)
  make C=2   [targets] Force check of all c source with $CHECK

-- 
With warm regards,
Sachin

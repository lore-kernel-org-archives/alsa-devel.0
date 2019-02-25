From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ASoC:hdac_hda: use correct format to setup
	hda codec
Date: Mon, 25 Feb 2019 12:04:13 -0600
Message-ID: <a7d6f54c-5466-ec63-4dec-cb403eed7b86@linux.intel.com>
References: <20190225074845.73950-1-rander.wang@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E5487F89650
 for <alsa-devel@alsa-project.org>; Mon, 25 Feb 2019 19:06:36 +0100 (CET)
In-Reply-To: <20190225074845.73950-1-rander.wang@linux.intel.com>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Rander Wang <rander.wang@linux.intel.com>, broonie@kernel.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


On 2/25/19 1:48 AM, Rander Wang wrote:
> The current implementation of the hdac_hda codec results in zero-valued
> samples on capture and noise with headset playback when SOF is used on
> platforms with an on-board HDaudio codec. This is root-caused to SOF
> using be_hw_params_fixup, and the prepare() call using invalid runtime
> fields to determine the format.
>
> This patch moves the format handling to the hw_params() callback, as
> done already for hdac_hdmi, to make sure the fixed-up information is
> taken into account but keeps the codec initialization in prepare() as
> the stream_tag is only available at that time. Moving everything in the
> prepare() callback is possible but the code is less elegant so this
> two-step solution was chosen.
>
> The solution was tested with the SST driver with no regressions, and all
> the issues with SOF playback and capture are solved.
>
> Signed-off-by: Rander Wang <rander.wang@linux.intel.com>

I suggested to Rander to send this patch upstream last week, but since 
there are two additional fixes suggested over the week-end on the SOF 
github we probably want to discard this patch.

We will resubmit a series once all the current ASoC+HDaudio issues are 
sorted out (both with the Skylake and SOF drivers). It's easier for 
reviewers and people backporting stuff.

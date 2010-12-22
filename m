From: Stephen Warren <swarren@nvidia.com>
Subject: Re: Tegra driver silent running on linux-next
Date: Tue, 21 Dec 2010 22:21:40 -0800
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF030FD78CE2@HQMAIL01.nvidia.com>
References: <74CDBE0F657A3D45AFBB94109FB122FF030FD78CE0@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate03.nvidia.com (hqemgate03.nvidia.com [216.228.121.140])
	by alsa0.perex.cz (Postfix) with ESMTP id A87592434C
	for <alsa-devel@alsa-project.org>; Wed, 22 Dec 2010 07:22:19 +0100 (CET)
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF030FD78CE0@HQMAIL01.nvidia.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Mark Brown (broonie@opensource.wolfsonmicro.com)" <broonie@opensource.wolfsonmicro.com>
Cc: "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Stephen Warren wrote:
> I've made the Tegra audio driver compile against ALSA's -next, and it seems
> like it's working; the files in /sys/kernel/debug/asoc contain everything
> I'd expect, aplay -[lL] list what I'd expect, aplay runs without errors
> and completes after the expected about of time, same for speaker-test.
> 
> However, the headphones are completely silent.

Bah, it's working now. Tegra wasn't driving anything on the codec's MCLK input.
I thought I'd checked all the Tegra clock programming, but obviously not well
enough...

(and for reference, the DAPM/routing calls I added weren't actually required)

Sorry for the noise.

-- 
nvpublic

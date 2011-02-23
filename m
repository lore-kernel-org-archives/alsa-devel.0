From: Stephen Warren <swarren@nvidia.com>
Subject: Re: [PATCH 2/2] ASoC: WM8903: Fix double-applied patch
Date: Tue, 22 Feb 2011 16:43:11 -0800
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF03112A5BCE@HQMAIL01.nvidia.com>
References: <1298420637-9230-1-git-send-email-swarren@nvidia.com>
	<1298420637-9230-2-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate03.nvidia.com (hqemgate03.nvidia.com [216.228.121.140])
	by alsa0.perex.cz (Postfix) with ESMTP id CB88F1038EB
	for <alsa-devel@alsa-project.org>; Wed, 23 Feb 2011 01:43:27 +0100 (CET)
In-Reply-To: <1298420637-9230-2-git-send-email-swarren@nvidia.com>
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
To: Stephen Warren <swarren@nvidia.com>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Stephen Warren wrote at Tuesday, February 22, 2011 5:24 PM:
> A patch named "ASoC: Actively manage WM8903 DC servo configuration" was
> applied twice, with commit IDs:
> 
> 1605b831ae71a4008671e43113e1151a669ed0bf
> c5b6a9feaeb0fa0e39e3fc10f9bf8cc8de498739
> 
> Remove the duplicate code caused by this.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

Sorry, this is bogus; somehow I applied this patch locally to my
tree; the duplicate is not in the ASoC tree at all, and hence this
patch is not required to fix any problem.

-- 
nvpublic

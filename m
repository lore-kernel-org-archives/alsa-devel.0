From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 2/2] ASoC: tegra: complete Tegra->Tegra20
	renaming
Date: Fri, 06 Apr 2012 09:44:16 -0600
Message-ID: <4F7F0F50.8070205@wwwdotorg.org>
References: <1333662894-22672-1-git-send-email-swarren@wwwdotorg.org>
	<1333662894-22672-2-git-send-email-swarren@wwwdotorg.org>
	<20120406132324.GD19424@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 9E2F9244A7
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Apr 2012 17:44:20 +0200 (CEST)
In-Reply-To: <20120406132324.GD19424@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On 04/06/2012 07:23 AM, Mark Brown wrote:
> On Thu, Apr 05, 2012 at 03:54:54PM -0600, Stephen Warren wrote:
>> From: Stephen Warren <swarren@nvidia.com>
>>
>> Rename Tegra20-specific Kconfig variables, module filenames, all internal
>> symbol names, clocks, and platform devices, to reflect the fact the DAS
>> and I2S drivers are for a specific HW version.
> 
> Oops, sorry - replied to the wrong one - this one doesn't seem to apply
> against for-3.5, I applied 1/2 though.  I believe this is due to 3.4
> fixes not having propagated over 3.5 yet.  Can you regenerate against
> for-3.5 please, or perhaps it's best to wait until things have merged
> back up?

Yes, it's because of the I2S debugfs fix.

I'm not sure when "things have merged back up" will be; do you intend to
merge your for-3.4 branch into for-3.5 at any particular time, or
perhaps rebase your for-3.5 onto v3.4-rc2 when its out?

Alternatively, I can regenerate that patch against your for-3.5, but
then you'll get a merge conflict when merging in your for-3.4, since the
code it affects will have experienced a rename. Should be trivial to
resolve though.

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: GPIO issue with RT5670
Date: Mon, 21 Aug 2017 16:18:45 -0500
Message-ID: <5568f645-b001-3628-06a7-36c2b41fed5f@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id F3D7F266C99
 for <alsa-devel@alsa-project.org>; Mon, 21 Aug 2017 23:18:48 +0200 (CEST)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Bard Liao <bardliao@realtek.com>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

the commit f10e4bf6632b5be11cea875b66ba959833a69258
     gpio: acpi: Even more tighten up ACPI GPIO lookups

now generates the following issue

[    9.694204] rt5670 i2c-10EC5672:00: ASoC: Cannot get gpio at index 0: -2
[    9.694293] rt5670 i2c-10EC5672:00: Adding jack GPIO failed

This is the 3rd occurrence of an audio issue with this commit [1][2], 
what is the recommended fix here since this codec is not only used in 
ACPI-based devices and do we need to check for more issues in audio drivers?

Thanks

-Pierre

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git/commit/?h=for-next&id=7c197881e163f34679b941c75500a6c85560b7c9

[2] https://bugzilla.kernel.org/show_bug.cgi?id=115531

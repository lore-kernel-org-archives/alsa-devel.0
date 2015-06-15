From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH 4/4] ASoC: intel: Constify ACPI device ids
Date: Mon, 15 Jun 2015 16:07:22 +0300
Message-ID: <557ECE0A.9050500@linux.intel.com>
References: <1434198316-8400-1-git-send-email-minipli@googlemail.com>
 <1434198316-8400-5-git-send-email-minipli@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 6A49A2614C4
 for <alsa-devel@alsa-project.org>; Mon, 15 Jun 2015 15:07:26 +0200 (CEST)
In-Reply-To: <1434198316-8400-5-git-send-email-minipli@googlemail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mathias Krause <minipli@googlemail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
List-Id: alsa-devel@alsa-project.org

On 06/13/2015 03:25 PM, Mathias Krause wrote:
> Constify the ACPI device ID array, it doesn't need to be writable at
> runtime.
>
> Signed-off-by: Mathias Krause <minipli@googlemail.com>
> Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> ---
>   sound/soc/intel/common/sst-acpi.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

From: Sergej Sawazki <sergej@taudac.com>
Subject: Re: [PATCH] ASoC: wm8741: Fix setting BCLK and LRCLK
 polarity
Date: Fri, 3 Nov 2017 14:05:30 +0100
Message-ID: <403c4e22-7caf-0a31-90b8-46586f8f53a1@taudac.com>
References: <1509628982-9767-1-git-send-email-sergej@taudac.com>
 <20171103114526.hjjmkkmkbxmotkpo@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from s62.goserver.host (s62.goserver.host [37.17.224.62])
 by alsa0.perex.cz (Postfix) with ESMTP id 1C4D526752C
 for <alsa-devel@alsa-project.org>; Fri,  3 Nov 2017 14:05:31 +0100 (CET)
In-Reply-To: <20171103114526.hjjmkkmkbxmotkpo@sirena.org.uk>
Content-Language: en-GB
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: ce3a@gmx.de, patches@opensource.cirrus.com, alsa-devel@alsa-project.org, ckeepax@opensource.cirrus.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


Am 03.11.2017 um 12:45 schrieb Mark Brown:
> On Thu, Nov 02, 2017 at 02:23:02PM +0100, Sergej Sawazki wrote:
>> After checking the code and the datasheet, it seems like we are handling
>> the clock inversion (SND_SOC_DAIFMT_NB_IF and SND_SOC_DAIFMT_IB_IF) not
>> correctly.
> 
> This doesn't apply against current code, please check and resend.
> 

It applies against "for-next" (e67852427fb). Is it the wrong branch?

Sergej

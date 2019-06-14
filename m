From: AS50 KCHsu0 <KCHSU0@nuvoton.com>
Subject: Re: [PATCH] ASoC: nau8825: fix fake interruption when
	booting
Date: Fri, 14 Jun 2019 10:02:04 +0800
Message-ID: <cb856871-aa10-d67d-4900-823578f2f40e@nuvoton.com>
References: <20190610024029.12193-1-KCHSU0@nuvoton.com>
 <20190610034040.12629-1-KCHSU0@nuvoton.com>
 <20190613112042.GJ5316@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
 by alsa1.perex.cz (Postfix) with ESMTP id 846ABF80764
 for <alsa-devel@alsa-project.org>; Fri, 14 Jun 2019 04:02:10 +0200 (CEST)
In-Reply-To: <20190613112042.GJ5316@sirena.org.uk>
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
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, cychiang@google.com, WTLI@nuvoton.com, lgirdwood@gmail.com, yuhsuan@google.com, YHCHuang@nuvoton.com, CTLIN0@nuvoton.com, Cheng-Yi Chiang <cychiang@chromium.org>, mhkuo@nuvoton.com
List-Id: alsa-devel@alsa-project.org


On 6/13/2019 7:20 PM, Mark Brown wrote:

On Mon, Jun 10, 2019 at 11:40:40AM +0800, John Hsu wrote:


There is no pull-up resistor at IRQ line where it connects from
the codec to SoC. When booting, the signal of IRQ pin will keep low



On some specific system?


No, not really.
The ISR is made for active low. The setup decreases the risk of
system damage, in case the hardware has no pull-up resistor.



Please don't send new patches in the middle of old threads, it makes it
hard to spot them and work out what the current version is.


I understand. Thanks for reminding. Sorry for a little pushy.





===========================================================================================
The privileged confidential information contained in this email is intended for use only by the addressees as indicated by the original sender of this email. If you are not the addressee indicated in this email or are not responsible for delivery of the email to such a person, please kindly reply to the sender indicating this fact and delete all copies of it from your computer and network server immediately. Your cooperation is highly appreciated. It is advised that any unauthorized use of confidential information of Nuvoton is strictly prohibited; and any information in this email irrelevant to the official business of Nuvoton shall be deemed as neither given nor endorsed by Nuvoton.

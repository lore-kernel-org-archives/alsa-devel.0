From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: ASUS Phoebus (CMI8888) HDA Support
Date: Wed, 04 Dec 2013 12:57:04 +0100
Message-ID: <529F1890.6070003@ladisch.de>
References: <20131204213613.31b9a9c9@sarah.home.spacevs.com>	<529F098C.3020208@ladisch.de>
 <20131204215711.68b52af6@sarah.home.spacevs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 65292265366
 for <alsa-devel@alsa-project.org>; Wed,  4 Dec 2013 12:57:06 +0100 (CET)
In-Reply-To: <20131204215711.68b52af6@sarah.home.spacevs.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Geoffrey McRae <geoff@spacevs.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Geoffrey McRae wrote:
> Clemens Ladisch <clemens@ladisch.de> wrote:
>> Geoffrey McRae wrote:
>>> I enabled MMIO in my BIOS, which instantly fixed the missing RIRB
>>> DMA data issue
>>
>> What mainboard are you using, and what is the exact name of this BIOS
>> option?
>
> Manufacturer: ASUSTeK COMPUTER INC.
> Product Name: SABERTOOTH 990FX
>
> The option is titled "MMIO", thats it. There is an additional option,
> "MMIO Mode" which is set to "64MB".

Please show the outputs of dmesg directly after booting with the IOMMU
option both disabled and enabled.


Regards,
Clemens

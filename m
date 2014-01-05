From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [RFC] ASoC: Adding trivial codec drivers
Date: Sun, 05 Jan 2014 17:01:22 +0100
Message-ID: <52C981D2.2020800@metafoo.de>
References: <52C95977.5070400@koalo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-079.synserver.de (smtp-out-019.synserver.de
 [212.40.185.19])
 by alsa0.perex.cz (Postfix) with ESMTP id AAD9E260886
 for <alsa-devel@alsa-project.org>; Sun,  5 Jan 2014 17:01:05 +0100 (CET)
In-Reply-To: <52C95977.5070400@koalo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Florian Meier <florian.meier@koalo.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On 01/05/2014 02:09 PM, Florian Meier wrote:
> This is not intended to be a real patch.
> I would just like to ask if this is the preferred way 
> to add codec and machine driver for codecs without
> I2C or SPI configuration possibilities or should I 
> rather use a more generic approach?
> 

Should be fine. There are a couple of other similar drivers.

- Lars

From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v3] ARM: kirkwood: extend the kirkwood i2s
 driver for DT usage
Date: Tue, 23 Jul 2013 11:03:38 +0200
Message-ID: <51EE46EA.1020809@metafoo.de>
References: <20130723104615.3696f1a9@armhf>
 <20130723085346.GQ24642@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-088.synserver.de (smtp-out-088.synserver.de
 [212.40.185.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 52BCF261B0C
 for <alsa-devel@alsa-project.org>; Tue, 23 Jul 2013 11:02:51 +0200 (CEST)
In-Reply-To: <20130723085346.GQ24642@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Jean-Francois Moine <moinejf@free.fr>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <rob.herring@calxeda.com>, devicetree-discuss@vger.kernel.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On 07/23/2013 10:53 AM, Russell King - ARM Linux wrote:
> On Tue, Jul 23, 2013 at 10:46:15AM +0200, Jean-Francois Moine wrote:
>> The kirkwood i2s driver is used without DT in the Kirkwood machine.
>> This patch adds a DT compatible definition for use in other Marvell
>> machines as the Armada 88AP510 (Dove).
> 
> Yet again, this illustrates why converting to DT causes backwards
> steps in drivers: the conversion of devm_clk_get() to of_clk_get()
> necessitates a clk_put().

That's just a very poor usage of the API in this patch. devm_clk_get() works
fine on DT and non-DT platforms. The driver shouldn't need any changes in
that regard.

- Lars

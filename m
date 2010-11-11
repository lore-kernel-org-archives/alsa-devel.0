From: Jesse Marroquin <jesse.marroquin@maxim-ic.com>
Subject: Re: [PATCH] ASoC: Add MAX98089 CODEC driver
Date: Thu, 11 Nov 2010 17:16:12 -0600
Message-ID: <4CDC793C.2040406@maxim-ic.com>
References: <4CDC5033.50302@maxim-ic.com>
	<20101111211801.GA3399@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from antispam01.maxim-ic.com (antispam01.maxim-ic.com
	[205.153.101.182])
	by alsa0.perex.cz (Postfix) with ESMTP id 4F993103815
	for <alsa-devel@alsa-project.org>; Fri, 12 Nov 2010 00:16:15 +0100 (CET)
In-Reply-To: <20101111211801.GA3399@opensource.wolfsonmicro.com>
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
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Peter Hsiang <Peter.Hsiang@maxim-ic.com>, Liam@alsa-project.org, Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org


Thanks for pointing out the I2C device ID. After looking at the existing
drivers that have multiple I2C IDs, I see that the devices can be uniquely
identified. With this we should be able to accommodate both devices with
the same driver.


On 11/11/2010 03:18 PM, Mark Brown wrote:
> On Thu, Nov 11, 2010 at 02:21:07PM -0600, Jesse Marroquin wrote:
>> This patch adds the initial driver for the MAX98089 CODEC.
> 
> I've not read this properly yet but on a first quick scan through this
> bears a more than passing resemblance to the MAX98088 driver - are there
> sufficient incompatibilities between the chips to warrant having a
> separate driver?  http://datasheets.maxim-ic.com/en/ds/MAX98088.pdf
> would suggest not...  
> 
> Keeping a single driver means less code to maintain, which is generally
> a win.  Variations between the parts can be accommodated by registering
> different controls and so on based on the I2C device ID that the system
> registers.
> 

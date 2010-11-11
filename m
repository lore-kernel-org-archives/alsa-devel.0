From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Add MAX98089 CODEC driver
Date: Thu, 11 Nov 2010 21:18:02 +0000
Message-ID: <20101111211801.GA3399@opensource.wolfsonmicro.com>
References: <4CDC5033.50302@maxim-ic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9112C1037EE
	for <alsa-devel@alsa-project.org>; Thu, 11 Nov 2010 22:17:56 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4CDC5033.50302@maxim-ic.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jesse Marroquin <jesse.marroquin@maxim-ic.com>
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Peter Hsiang <Peter.Hsiang@maxim-ic.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 11, 2010 at 02:21:07PM -0600, Jesse Marroquin wrote:
> This patch adds the initial driver for the MAX98089 CODEC.

I've not read this properly yet but on a first quick scan through this
bears a more than passing resemblance to the MAX98088 driver - are there
sufficient incompatibilities between the chips to warrant having a
separate driver?  http://datasheets.maxim-ic.com/en/ds/MAX98088.pdf
would suggest not...  

Keeping a single driver means less code to maintain, which is generally
a win.  Variations between the parts can be accommodated by registering
different controls and so on based on the I2C device ID that the system
registers.

From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC: SAMSUNG: About I2S_v4 support
Date: Wed, 3 Mar 2010 09:54:12 +0000
Message-ID: <20100303095412.GA2581@opensource.wolfsonmicro.com>
References: <1b68c6791003030032n7de8a0d8t5395a0a260d92b19@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2A7631038FE
	for <alsa-devel@alsa-project.org>; Wed,  3 Mar 2010 10:54:11 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1b68c6791003030032n7de8a0d8t5395a0a260d92b19@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: jassi brar <jassisinghbrar@gmail.com>
Cc: alsa-devel@alsa-project.org, Ben Dooks <ben-linux@fluff.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 03, 2010 at 05:32:13PM +0900, jassi brar wrote:

> Otherwise, I am planning to re-factor(as and if needed) s3c-i2s-v2.c,
> s3c2412-i2s.c and s3c64xx-i2s.c
> and add a new s3c-i2s-v4.c to handle I2S_v4 controllers.

As I've said when you've mentioned this in the past I'd prefer an
explicit IISv4 driver (sharing most of the actual code with the core)
since none of the Samsung documentation covers the IISv4 and IISv2
blocks as completely independant blocks.  This would make it easier for
people to find what they need to use.

> Kindly ACK/NAK this idea if you are busy with other stuff and I am to
> start working on the issue.

Please also remember that we need to get the clock API changes to allow
the driver to start.  I've been chasing patches for these for the past
couple of kernel releases but it's not ideal that I need to do this.

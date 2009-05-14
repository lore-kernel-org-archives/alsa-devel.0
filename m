From: Karl Beldan <karl.beldan@gmail.com>
Subject: Re: [PATCH 1/4 v2] pxa2xx-i2s: Proper hw initialization
Date: Thu, 14 May 2009 10:40:12 +0200
Message-ID: <4A0BD8EC.4080107@gmail.com>
References: <4A0B2AA5.9000700@gmail.com> <20090513224829.GC24973@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f175.google.com (mail-ew0-f175.google.com
	[209.85.219.175])
	by alsa0.perex.cz (Postfix) with ESMTP id D6D1124366
	for <alsa-devel@alsa-project.org>;
	Thu, 14 May 2009 10:40:14 +0200 (CEST)
Received: by ewy23 with SMTP id 23so1414838ewy.32
	for <alsa-devel@alsa-project.org>; Thu, 14 May 2009 01:40:14 -0700 (PDT)
In-Reply-To: <20090513224829.GC24973@sirena.org.uk>
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
Cc: Eric Miao <eric.miao@marvell.com>, alsa-devel@alsa-project.org, Russell King <linux@arm.linux.org.uk>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, Matthieu Dumont <matthieu.dumont@mobile-devices.fr>
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> On Wed, May 13, 2009 at 10:16:37PM +0200, Karl Beldan wrote:
>> Make sure we are in a know good state at end of probe :
>> Reset FIFO logic and registers, and make sure REC and RPL functions
>> along with FIFO service are disabled (SACR0_RST enables REC and RPL).
>>
>> Resetting loses current settings so remove reset from stream startup.
>> Now reset occurs only at probe.
>>
>> Signed-off-by: Karl Beldan <karl.beldan@mobile-devices.fr>
> 
> This one has already been applied from your previous posting.  I'll
> review the rest tomorrow.

Please take [PATCH 1/4 v3] if possible, otherwise I'll post [PATCH 2/4 v3].

-- 
Karl

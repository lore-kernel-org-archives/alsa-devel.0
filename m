From: Evan Ragsdale <Evan.Ragsdale@maximintegrated.com>
Subject: Re: [PATCH RESEND] ASoC: max98088 - fix element type
 of the register cache.
Date: Mon, 15 Jul 2013 10:33:20 -0700
Message-ID: <A453F1AE3B5DC14DB19666C506CE75A710ACDBE077@ITSVLEX06.it.maxim-ic.internal>
References: <1373906326-18601-1-git-send-email-dgreid@chromium.org>
 <20130715172203.GY11538@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from antispam02.maximintegrated.com (antispam02.maxim-ic.com
 [205.153.101.183])
 by alsa0.perex.cz (Postfix) with ESMTP id D82FC261A94
 for <alsa-devel@alsa-project.org>; Mon, 15 Jul 2013 19:33:24 +0200 (CEST)
In-Reply-To: <20130715172203.GY11538@sirena.org.uk>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Dylan Reid <dgreid@chromium.org>
Cc: Chih-Chung Chang <chihchung@chromium.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Ralph Birt <Ralph.Birt@maximintegrated.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

+ Ralph Birt.

Best Regards,

Evan Ragsdale
Strategic Applications, Audio Solutions
160 Rio Robles | San Jose, CA 95134 | USA
Office: +1 (408) 601-5510
Maxim Integrated | www.maximintegrated.com



-----Original Message-----
From: Mark Brown [mailto:broonie@kernel.org] 
Sent: Monday, July 15, 2013 10:22 AM
To: Dylan Reid
Cc: alsa-devel@alsa-project.org; lgirdwood@gmail.com; Evan Ragsdale; Chih-Chung Chang
Subject: Re: [PATCH RESEND] ASoC: max98088 - fix element type of the register cache.

On Mon, Jul 15, 2013 at 09:38:46AM -0700, Dylan Reid wrote:
> From: Chih-Chung Chang <chihchung@chromium.org>
> 
> The registers of max98088 are 8 bits, not 16 bits. This bug causes the 
> contents of registers to be overwritten with bad values when the codec 
> is suspended and then resumed.

Applied, thanks, though really this driver ought to be being converted to regmap.

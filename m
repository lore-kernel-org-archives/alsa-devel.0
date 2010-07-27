From: Timur Tabi <timur@freescale.com>
Subject: Re: asoc multi-component: almost there!
Date: Tue, 27 Jul 2010 08:07:19 -0500
Message-ID: <AANLkTikmQgnqByfVB_yJ0rSfeuRb2YmGDeXzOrDV9tHX@mail.gmail.com>
References: <AANLkTimKhtzu-_Sts3AkVmDhc19tOGg4dqMGzdCro=A7@mail.gmail.com>
	<1280227335.3085.29.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 067FA2455C
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Jul 2010 15:07:56 +0200 (CEST)
Received: by gya1 with SMTP id 1so1360925gya.38
	for <alsa-devel@alsa-project.org>; Tue, 27 Jul 2010 06:07:55 -0700 (PDT)
In-Reply-To: <1280227335.3085.29.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>, Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 27, 2010 at 5:42 AM, Liam Girdwood <lrg@slimlogic.co.uk> wrote:

> You don't need to register two CODEC DAIs here. One will do, since we
> only have the one CODEC.

I don't see how I can avoid it.  I register one DAI for playback, and
another for capture.  In the past, multi-component was able to handle
this.  It's only with the most recent change that it's broken.

-- 
Timur Tabi
Linux kernel developer at Freescale

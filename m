From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: 2.6.32-gitX: oops in ac97 codec registration
Date: Thu, 17 Dec 2009 10:56:00 +0000
Message-ID: <20091217105559.GC20667@rakim.wolfsonmicro.main>
References: <f861ec6f0912170040m57874014s7b1a6bb3b863c0f1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 24A1E2448F
	for <alsa-devel@alsa-project.org>; Thu, 17 Dec 2009 11:56:01 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <f861ec6f0912170040m57874014s7b1a6bb3b863c0f1@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Manuel Lauss <manuel.lauss@googlemail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 17, 2009 at 09:40:50AM +0100, Manuel Lauss wrote:

> current 2.6.32-git spits out the following oops when I load my machine

Do you mean 2.6.32 or 2.6.33?

> Oops is inside snd_ac97_dev_add_pdata() call: seems ac97->dev is NULL.

> I'm not entirely sure that this isn't somehow the fault of my machine driver;
> has the procedure to register the asoc device changed since 2.6.32?

The generic AC97 bodge code is broken.  Again.  I've not checked the
ordering requirements here but reversing the order of snd_soc_new_pcms()
and snd_ac97_bus() in ac97_soc_probe() might do the trick.

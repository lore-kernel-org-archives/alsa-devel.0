From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: RFC: reworking ASOC for large registers
Date: Tue, 22 Jul 2008 00:16:15 -0400
Message-ID: <9e4733910807212116m557b9b45x99fbef4510b2917c@mail.gmail.com>
References: <9e4733910807201847q6d914e58l567a96904679ada8@mail.gmail.com>
	<9e4733910807211625l3268a1a9m59d6914fb55593c6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.156])
	by alsa0.perex.cz (Postfix) with ESMTP id 8FE8D24541
	for <alsa-devel@alsa-project.org>;
	Tue, 22 Jul 2008 06:16:16 +0200 (CEST)
Received: by yw-out-1718.google.com with SMTP id 9so724118ywk.2
	for <alsa-devel@alsa-project.org>; Mon, 21 Jul 2008 21:16:15 -0700 (PDT)
In-Reply-To: <9e4733910807211625l3268a1a9m59d6914fb55593c6@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA-devel <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On 7/21/08, Jon Smirl <jonsmirl@gmail.com> wrote:
> Here's what I've done so far, just to give you idea of what is needed.
>  I'm only half way through the soc core. I'm not able to run my driver
>  yet to test anything.

This 64b values in this attempt are not playing nice with the existing
ALSA user space API. I'm going to have to come up with another way to
do this.

-- 
Jon Smirl
jonsmirl@gmail.com

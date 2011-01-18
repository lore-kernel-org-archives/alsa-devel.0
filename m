From: "Rajashekhara, Sudhakar" <sudhakar.raj@ti.com>
Subject: Re: [PATCH 0/5] davinci: da850: clean up pinmux arrays
	in da850.c
Date: Tue, 18 Jan 2011 17:18:38 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59302484739CD@dbde02.ent.ti.com>
References: <1294406333-30054-1-git-send-email-michael.williamson@criticallink.com>
	<B85A65D85D7EB246BE421B3FB0FBB59302484733F8@dbde02.ent.ti.com>
	<B85A65D85D7EB246BE421B3FB0FBB59302484734D4@dbde02.ent.ti.com>
	<4D357C59.8000907@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
	by alsa0.perex.cz (Postfix) with ESMTP id 5FD8910385B
	for <alsa-devel@alsa-project.org>; Tue, 18 Jan 2011 12:48:52 +0100 (CET)
In-Reply-To: <4D357C59.8000907@mvista.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

Hi Sergei,

On Tue, Jan 18, 2011 at 17:11:13, Sergei Shtylyov wrote:
> Hello.
> 
> On 18-01-2011 7:40, Rajashekhara, Sudhakar wrote:
> 
> > I was testing Audio with 2.6.37 on DA850 from Kevin Hilman Linux tree
> > at [1] and found that audio is broken. Below patch fixes the issue.
> 
> > ---
> > From: Rajashekhara, Sudhakar<sudhakar.raj@ti.com>
> 
> > davinci: fixes for audio on da850/omap-l138/am18x
> >
> > On DA850/OMAP-L138/AM18x, AIC3x codec is at 0x18 slave address.
> > But in sound/soc/davinci/davinci-evm.c file, "struct snd_soc_dai_link"
> > has the wrong AIC3x codec slave address. This patch fixes this issue.
> 
> > Also, this patch registers the platform device for davinci-pcm-audio.
> 
>     Shouldn't this be 2 patches? I don't see a connection between the changes.
> 

Yes, definitely this should be 2 patches. I just posted the fix as-is to unblock
any folks who are facing the issue. As you can see from my e-mail there are still
some issues which I am debugging currently. I'll post the proper patch later.

Regards,
Sudhakar 

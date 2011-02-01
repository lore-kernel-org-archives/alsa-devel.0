From: "Rajashekhara, Sudhakar" <sudhakar.raj@ti.com>
Subject: Re: No soundcards found with 2.6.37 (and 2.6.38-rc2)
Date: Tue, 1 Feb 2011 14:57:57 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59302486D66D4@dbde02.ent.ti.com>
References: <1296551578.2009.43.camel@sven>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id F3C4C24464
	for <alsa-devel@alsa-project.org>; Tue,  1 Feb 2011 10:28:07 +0100 (CET)
In-Reply-To: <1296551578.2009.43.camel@sven>
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
To: Sven Neumann <s.neumann@raumfeld.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Daniel Mack <daniel@caiaq.de>
List-Id: alsa-devel@alsa-project.org

Hi,

On Tue, Feb 01, 2011 at 14:42:58, Sven Neumann wrote:
> Hi,
> 
> we are using an ARM PXA300 based device with SoC devices. The code is
> completely upstream, our platform is defined in sound/soc/pxa/raumfeld.c
> 
> I've recently tried to update our kernel to 2.6.37, but it looks like
> there have been some changes in the Linux kernel that cause our sound
> hardware not to be recognized or initialised correctly any longer.
> 

I also faced similar problem on the platform I had and I submitted couple of
patches to overcome this. Please see:

https://patchwork.kernel.org/patch/495211/ 
https://patchwork.kernel.org/patch/495751/

Also, you can refer to https://patchwork.kernel.org/patch/485331/ for the
discussion which happened before posting the patch to the list.

Thanks,
Sudhakar

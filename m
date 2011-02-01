From: Sven Neumann <s.neumann@raumfeld.com>
Subject: Re: No soundcards found with 2.6.37 (and 2.6.38-rc2)
Date: Tue, 01 Feb 2011 11:05:42 +0100
Message-ID: <1296554742.2009.54.camel@sven>
References: <1296551578.2009.43.camel@sven>
	<B85A65D85D7EB246BE421B3FB0FBB59302486D66D4@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vwp2514.webpack.hosteurope.de (vwp2514.webpack.hosteurope.de
	[87.230.42.24]) by alsa0.perex.cz (Postfix) with ESMTP id 8FD3A103926
	for <alsa-devel@alsa-project.org>; Tue,  1 Feb 2011 11:05:46 +0100 (CET)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59302486D66D4@dbde02.ent.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Rajashekhara, Sudhakar" <sudhakar.raj@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Daniel@alsa-project.org, Mack <daniel@caiaq.de>
List-Id: alsa-devel@alsa-project.org

On Tue, 2011-02-01 at 14:57 +0530, Rajashekhara, Sudhakar wrote:

> On Tue, Feb 01, 2011 at 14:42:58, Sven Neumann wrote:
> > Hi,
> > 
> > we are using an ARM PXA300 based device with SoC devices. The code is
> > completely upstream, our platform is defined in sound/soc/pxa/raumfeld.c
> > 
> > I've recently tried to update our kernel to 2.6.37, but it looks like
> > there have been some changes in the Linux kernel that cause our sound
> > hardware not to be recognized or initialised correctly any longer.
> > 
> 
> I also faced similar problem on the platform I had and I submitted couple of
> patches to overcome this. Please see:
> 
> https://patchwork.kernel.org/patch/495211/ 
> https://patchwork.kernel.org/patch/495751/
> 
> Also, you can refer to https://patchwork.kernel.org/patch/485331/ for the
> discussion which happened before posting the patch to the list.

Thanks for the quick answer. I had a look at these patches, but I don't
think that the solution to my problem is that similar. As far as I can
see the sound hardware is registered correctly in our platform code.
I've added some printk() statements to verify that this code in
raumfeld.c is indeed run at bootup:

	raumfeld_audio_device = platform_device_alloc("soc-audio", 0);
	platform_set_drvdata(raumfeld_audio_device,
                             &snd_soc_raumfeld);
	platform_device_add(raumfeld_audio_device);

Or is this not any longer correct?


Sven

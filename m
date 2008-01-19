From: Dmitry <dbaryshkov@gmail.com>
Subject: Re: [PATCH 10/17] Don't lock the codec list in
	snd_soc_dapm_new_widgets()
Date: Sun, 20 Jan 2008 00:48:24 +0300
Message-ID: <bc64b4640801191348g671ec552icfa55f3622a3ca23@mail.gmail.com>
References: <1199971035-13553-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1199971035-13553-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1199971035-13553-5-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1199971035-13553-6-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1199971035-13553-7-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1199971035-13553-8-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1199971035-13553-9-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1199971035-13553-10-git-send-email-broonie@opensource.wolfsonmicro.com>
	<bc64b4640801151540n4cb66f99u68ba0d42c91b5ff6@mail.gmail.com>
	<20080118101816.GA19291@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.177])
	by alsa0.perex.cz (Postfix) with ESMTP id D9E7B24405
	for <alsa-devel@alsa-project.org>; Sat, 19 Jan 2008 22:48:25 +0100 (CET)
Received: by py-out-1112.google.com with SMTP id w49so2008169pyg.36
	for <alsa-devel@alsa-project.org>; Sat, 19 Jan 2008 13:48:25 -0800 (PST)
In-Reply-To: <20080118101816.GA19291@rakim.wolfsonmicro.main>
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
To: Dmitry <dbaryshkov@gmail.com>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Liam Girdwood <lg@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Hi,

2008/1/18, Mark Brown <broonie@opensource.wolfsonmicro.com>:
> On Wed, Jan 16, 2008 at 02:40:55AM +0300, Dmitry wrote:
>
> > I'm sorry, but I tested this patch only now. And I just got another
> > message from lockdep:
>
> Could you give this patch a try, please?

Thanks, now I've got a clean boot log :)

-- 
With best wishes
Dmitry

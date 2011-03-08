From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Add MAX9850 codec driver
Date: Tue, 8 Mar 2011 10:21:45 +0000
Message-ID: <20110308102145.GB11205@opensource.wolfsonmicro.com>
References: <1299501913-3772-1-git-send-email-christian.glindkamp@taskit.de>
	<AANLkTikYd7+WXa1jcse=VG1YxyX52JM1Z6y-khCwZJ-R@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6017B10383E
	for <alsa-devel@alsa-project.org>; Tue,  8 Mar 2011 11:21:48 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <AANLkTikYd7+WXa1jcse=VG1YxyX52JM1Z6y-khCwZJ-R@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Seungwhan Youn <claude.youn@gmail.com>
Cc: Christian Glindkamp <christian.glindkamp@taskit.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 08, 2011 at 01:40:05AM +0900, Seungwhan Youn wrote:
> IMHO, because of MAX9850_* macros are only using inside max9850.c, I
> think that move MAX9850_* macros into max9850.c and remove max9850.h
> header file, is more looks good to me.

It is common practice to have the register definitions / enumerations in
a header file even though they are only used by 1 driver.  However, any
other type declarations or definitions which are not used by multiple
drivers are never put into the header file.

Thanks,
Dimitris

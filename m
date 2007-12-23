From: "Lee Revell" <rlrevell@joe-job.com>
Subject: Re: [RFC] virtual master control for HD-audio
Date: Sat, 22 Dec 2007 22:15:12 -0500
Message-ID: <75b66ecd0712221915o2ebed9b5vaa6b740dbb86d648@mail.gmail.com>
References: <s5hprx12x6x.wl%tiwai@suse.de>
	<Pine.LNX.4.61.0712212030470.8567@tm8103.perex-int.cz>
	<fkif0k$adr$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.185])
	by alsa0.perex.cz (Postfix) with ESMTP id A185F24506
	for <alsa-devel@alsa-project.org>; Sun, 23 Dec 2007 04:15:14 +0100 (CET)
Received: by rv-out-0910.google.com with SMTP id k20so629216rvb.32
	for <alsa-devel@alsa-project.org>; Sat, 22 Dec 2007 19:15:13 -0800 (PST)
In-Reply-To: <fkif0k$adr$1@ger.gmane.org>
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
To: "Alexander E. Patrakov" <patrakov@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Dec 22, 2007 2:39 AM, Alexander E. Patrakov <patrakov@gmail.com> wrote:
> Aren't the patches supposed to be useful also for OSS-only apps, where userspace
> solutions can't work without LD_PRELOAD hacks? Currently, without the patch and
> the "aoss" wrapper, OSS apps sound too loud. I have not tested the patch, but I
> am too lazy to change each .desktop file for each OSS-only application provided
> by the distribution.

Please file a bug report with your distro.  It should be considered a
bug for a modern distro to ship OSS only apps withut using the aoss
wrapper.  It causes all sorts of problems, like blocking the soundcard
for ALSA apps.

Lee

From: "Adrian McMenamin" <adrianmcmenamin@gmail.com>
Subject: Effect of CONFIG_SND_PCM_OSS_PLUGINS
Date: Tue, 24 Jul 2007 23:30:02 +0100
Message-ID: <92a12cdb0707241530h3703a721md7bceeac2cd3144a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 31BB9103803
	for <alsa-devel@alsa-project.org>;
	Wed, 25 Jul 2007 00:30:05 +0200 (CEST)
Received: by nz-out-0506.google.com with SMTP id m22so17nzf
	for <alsa-devel@alsa-project.org>; Tue, 24 Jul 2007 15:30:03 -0700 (PDT)
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Unless CONFIG_SND_PCM_OSS_PLUGINS is set then with my driver the
userspace (and OSS) app mpg123 doesn't work properly - not outputting
any sound.

Is this likely to be a problem with my driver or with the app?

Adrian

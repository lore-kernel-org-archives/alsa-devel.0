From: Dmitri Vorobiev <dmitri.vorobiev@movial.com>
Subject: suspicious code in aplay.c
Date: Fri, 7 Aug 2009 15:00:13 +0300
Message-ID: <e50e54220908070500h5e693cdt1d89aa28a0239da0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog104.obsmtp.com (na3sys009aog104.obsmtp.com
	[74.125.149.73])
	by alsa0.perex.cz (Postfix) with ESMTP id C9873103902
	for <alsa-devel@alsa-project.org>;
	Fri,  7 Aug 2009 14:00:19 +0200 (CEST)
Received: by fg-out-1718.google.com with SMTP id 13so405730fge.19
	for <alsa-devel@alsa-project.org>; Fri, 07 Aug 2009 05:00:13 -0700 (PDT)
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

Hello,

The following code in alsa-utils/aplay/aplay.c looks suspicious to me:

1215         if (!quiet_mode)
1216                 fprintf(stderr, _("Suspended. Trying resume. "));
fflush(stderr);

Is it really necessary to flush the stderr stream even if there was no
call to fprintf()? Perhaps these lines have to be like that:

if (!quiet_mode) {
        fprintf(stderr, _("Suspended. Trying resume. "));
        fflush(stderr);
}

Thanks,
Dmitri

P.S. I'm not subscribed to the mailing list, so please Cc: me on reply.

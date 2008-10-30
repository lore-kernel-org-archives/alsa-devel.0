From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: ASOC deprecated warning
Date: Thu, 30 Oct 2008 15:22:31 -0400
Message-ID: <9e4733910810301222v360ecf8aqbbead50759a2b844@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.241])
	by alsa0.perex.cz (Postfix) with ESMTP id CE3831037E3
	for <alsa-devel@alsa-project.org>; Thu, 30 Oct 2008 20:22:32 +0100 (CET)
Received: by rv-out-0708.google.com with SMTP id f25so719747rvb.32
	for <alsa-devel@alsa-project.org>; Thu, 30 Oct 2008 12:22:31 -0700 (PDT)
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
To: alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

What's the status of this?

 CC      sound/soc/soc-dapm.o
sound/soc/soc-dapm.c:1029: warning: 'snd_soc_dapm_connect_input' is
deprecated (declared at sound/soc/soc-dapm.c:1026)
sound/soc/soc-dapm.c:1029: warning: 'snd_soc_dapm_connect_input' is
deprecated (declared at sound/soc/soc-dapm.c:1026)

Could we have a Kconfig option of disabling deprecated APIs?
If I can get rid of this I'll have a warning free build.

-- 
Jon Smirl
jonsmirl@gmail.com

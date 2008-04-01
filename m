From: "Risto Suominen" <risto.suominen@gmail.com>
Subject: Re: snd-powermac
Date: Tue, 1 Apr 2008 23:55:00 +0300
Message-ID: <46e1c7760804011355ta958cffhca81ef893fdf4132@mail.gmail.com>
References: <46e1c7760803290805i9f56637uce18036db7a6756d@mail.gmail.com>
	<46e1c7760804011101w41e613c5k5d84f31da692445a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hs-out-0708.google.com (hs-out-0708.google.com [64.233.178.246])
	by alsa0.perex.cz (Postfix) with ESMTP id 0A8A8103836
	for <alsa-devel@alsa-project.org>;
	Tue,  1 Apr 2008 22:55:01 +0200 (CEST)
Received: by hs-out-0708.google.com with SMTP id x43so945987hsb.0
	for <alsa-devel@alsa-project.org>; Tue, 01 Apr 2008 13:55:00 -0700 (PDT)
In-Reply-To: <46e1c7760804011101w41e613c5k5d84f31da692445a@mail.gmail.com>
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

2008/4/1, Risto Suominen <risto.suominen@gmail.com>:
>  They are allocated and freed in the same order and manner
>  in alsa-kernel/ppc/pmac.c.
>

Actually, in this case, the file in question is ppc/pmac_old.c, and
they are allocated in function snd_pmac_new and freed in
snd_pmac_free.

Risto

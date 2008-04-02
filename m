From: "Risto Suominen" <risto.suominen@gmail.com>
Subject: Re: snd-powermac
Date: Wed, 2 Apr 2008 14:43:49 +0300
Message-ID: <46e1c7760804020443k1445be38ve18055967ba10e1f@mail.gmail.com>
References: <46e1c7760803290805i9f56637uce18036db7a6756d@mail.gmail.com>
	<46e1c7760804011101w41e613c5k5d84f31da692445a@mail.gmail.com>
	<46e1c7760804011355ta958cffhca81ef893fdf4132@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hs-out-0708.google.com (hs-out-0708.google.com [64.233.178.247])
	by alsa0.perex.cz (Postfix) with ESMTP id 588F6243E9
	for <alsa-devel@alsa-project.org>;
	Wed,  2 Apr 2008 13:43:50 +0200 (CEST)
Received: by hs-out-0708.google.com with SMTP id x43so1353579hsb.0
	for <alsa-devel@alsa-project.org>; Wed, 02 Apr 2008 04:43:49 -0700 (PDT)
In-Reply-To: <46e1c7760804011355ta958cffhca81ef893fdf4132@mail.gmail.com>
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

Found a solution for the interrupt problem with kernel 2.6.15:
manually edited in include/config.h from:

/* #undef CONFIG_SND_NEW_IRQ_HANDLER */

to:

#define CONFIG_SND_NEW_IRQ_HANDLER 1

Maybe I should submit a bug report in ALSA 1.0.16...

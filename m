From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: wrong decibel data?
Date: Thu, 24 Jun 2010 17:53:10 +0800
Message-ID: <AANLkTikM4wCkh9UKj8NI5WMPxBkLC9SwV0vWdqVIsAnY@mail.gmail.com>
References: <q2s98391a7b1004021121sde36d074m8a70acc142f95d93@mail.gmail.com>
	<r2i4f3252891004051846xc6ef1834habaf4f9db3bdd384@mail.gmail.com>
	<q2z98391a7b1004060101kd5ffef92tf4d98faa62a3ad5b@mail.gmail.com>
	<q2l4f3252891004071905l553da6a0he8b53448524fc94d@mail.gmail.com>
	<z2s98391a7b1004080542ud4af307l992ac9636d9aa508@mail.gmail.com>
	<u2w4f3252891004081611tc0293e7fzb6312ca188eacdc1@mail.gmail.com>
	<s2l98391a7b1004090030vd55faadew6ae97c85a7a4b379@mail.gmail.com>
	<x2q4f3252891004090440h78a3c187p1f3b51be7be1e858@mail.gmail.com>
	<s2l98391a7b1004090527je4458c3m143b5c129424751c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f179.google.com (mail-qy0-f179.google.com
	[209.85.216.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 28AF3243F3
	for <alsa-devel@alsa-project.org>;
	Thu, 24 Jun 2010 11:53:12 +0200 (CEST)
Received: by qyk36 with SMTP id 36so110601qyk.38
	for <alsa-devel@alsa-project.org>; Thu, 24 Jun 2010 02:53:10 -0700 (PDT)
In-Reply-To: <s2l98391a7b1004090527je4458c3m143b5c129424751c@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2010/4/9 Nicolo' Chieffo <nicolo.chieffo@gmail.com>

> As I've already told you, I'm not able to run dbmeasure because it
> says it can't detect any audio.
> I will investigate...
>

I cannot run dbmeasure on my au8830 or HDA sound card too.

you have to ask the author of dbmeasure.c

First glance at the source code , it seem the program expect the driver
support exactly one second buffer but neither au8830 or HDA driver can offer
a buffer size of exactly one second

May be just only work on his USB audio only

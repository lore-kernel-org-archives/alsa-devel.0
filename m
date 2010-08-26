From: Keith Chew <keith.chew@gmail.com>
Subject: Re: 5.1 surround on 3 jacks (retasking)
Date: Thu, 26 Aug 2010 19:16:01 +1200
Message-ID: <AANLkTim7vc8cTboZT4ELZpYkF40tmEjMOX5X5G=SN8Sn@mail.gmail.com>
References: <AANLkTin3DKSRuUZwARAadMTVPTrj17eHK8557bCsb3YM@mail.gmail.com>
	<4C75A7D9.1030604@canonical.com>
	<AANLkTinE8sjRWWsHYJYq1w_rLJu9Y91J4gs7k-Q_M3j-@mail.gmail.com>
	<4C76100C.3040205@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 89E8210381A
	for <alsa-devel@alsa-project.org>;
	Thu, 26 Aug 2010 09:16:02 +0200 (CEST)
Received: by iwn4 with SMTP id 4so1323541iwn.38
	for <alsa-devel@alsa-project.org>; Thu, 26 Aug 2010 00:16:01 -0700 (PDT)
In-Reply-To: <4C76100C.3040205@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> I'm not 100% sure, but I think that HDA-analyzer approach will probably
> not work here as you'll need a complete codec reconfig. After the
> reconfig, you shouldn't even have a "Line in" in alsamixer, instead you
> should have volume controls for "rear" and "center/lfe".
> Also make sure that the pin configs are configured as "front", "rear",
> and "center/lfe"

Thanks David, I understand your approach now.  I will try to figure
out how to get the correct hex values for the user configs,
documentation is quite sparse. Will report back soon.

Regards
Keith

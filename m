From: "Martijn Sipkema" <msipkema@sipkema-digital.com>
Subject: Re: opening alsa pcm device for input/output on specific channels
Date: Thu, 6 Jun 2002 16:24:54 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <001e01c20d6e$6beb46a0$0400a8c0@martijn>
References: <200206061341.g56DfbH16112@post2.fast.net>
Reply-To: "Martijn Sipkema" <msipkema@sipkema-digital.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from hirogen.kabelfoon.nl (hirogen.kabelfoon.nl [62.45.45.69])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id QAA14159
	for <alsa-devel@alsa-project.org>; Thu, 6 Jun 2002 16:26:02 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Paul Davis <pbd@op.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> you do it using ~/.asoundrc to define a PCM device that has the
> channel characteristics you want.
>
> next, you'll be asking how. that's the part i can't help you with. the
> archives have some examples, and there are several people on the list who
> can tell you.

aha, so the idea is that an application can only open a device with a number
of channels and the user uses the configuration file to map channels? there
is no way for an aaplication to open a device for output on specific
channels
, perhaps using a channel mask as in EASI?

--martijn




_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm

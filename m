From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: How to pair Wine with ALSA? part1: intro &
	underruns (long)
Date: Wed, 17 Aug 2011 20:19:57 +0800
Message-ID: <CAN8cciY1LonA4Kc_ZkdX67g8PS6fDhO4kYAOE89DmU54587MPQ@mail.gmail.com>
References: <8E4C156DA5797D418DBFADFD8CE655A4138FB471F5@HE113481.emea1.cds.t-internal.com>
	<4E47BE17.1000205@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id F089524685
	for <alsa-devel@alsa-project.org>;
	Wed, 17 Aug 2011 14:19:59 +0200 (CEST)
Received: by fxh10 with SMTP id 10so662568fxh.38
	for <alsa-devel@alsa-project.org>; Wed, 17 Aug 2011 05:19:59 -0700 (PDT)
In-Reply-To: <4E47BE17.1000205@ladisch.de>
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

2011/8/14 Clemens Ladisch <clemens@ladisch.de>:
> Joerg-Cyril.Hoehle@t-systems.com wrote:

> I'd suggest to have a default device ("default") and one device for each
> hardware sound card ("default:x", where x is the card index, but some
> people write a custom .asoundrc where this doesn't work), with the
> possibility of adding other device names.
>

http://git.alsa-project.org/?p=alsa-lib.git;a=commit;h=e6f990e5c9be5cac6f36924d20a75d0f69d27297

Now with this patch , you can use sysdefault:x or sysdefault:CARD=x
to use the default device define in /usr/share/alsa/cards/*.conf as
same as the past

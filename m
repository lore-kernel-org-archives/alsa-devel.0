From: Krzysztof Helt <krzysztof.h1@gmail.com>
Subject: Re: [PATCH] opti931: additional check for OPL3 device
Date: Mon, 17 Sep 2007 14:26:50 +0200
Message-ID: <20070917142650.f7b862e4.krzysztof.h1@gmail.com>
References: <8c74410a0709140735j3903a11dp23f783d45bffc55c@mail.gmail.com>
	<1189781567.3648.1210664373@webmail.messagingengine.com>
	<20070914184705.9ba48d80.krzysztof.h1@gmail.com>
	<1190016893.19336.1210994773@webmail.messagingengine.com>
	<46EE5284.9070202@gmail.com>
	<1190025593.12774.1211014755@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.174])
	by alsa0.perex.cz (Postfix) with ESMTP id 23E371037F7
	for <alsa-devel@alsa-project.org>;
	Mon, 17 Sep 2007 14:19:31 +0200 (CEST)
Received: by ug-out-1314.google.com with SMTP id h2so858030ugf
	for <alsa-devel@alsa-project.org>; Mon, 17 Sep 2007 05:19:30 -0700 (PDT)
In-Reply-To: <1190025593.12774.1211014755@webmail.messagingengine.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <cladisch@fastmail.net>
Cc: ALSA devel <alsa-devel@alsa-project.org>, Rene Herman <rene.herman@gmail.com>
List-Id: alsa-devel@alsa-project.org

Guys,

Look at the code. Shifting the fm_port address by 8 (Rene's) is correct way to do as the OPL3 is searched at fm_port and fm_port +2, but the OPL4 is searched at fm_port and fm_port -8
(which will be the fm_port before shifting).

Is the OPL4 located at 0x380 and 0x388 or 0x378 and 0x380? If the former, the Rene's patch is correct.

Regards,
Krzysztof

From: VDR User <user.vdr@gmail.com>
Subject: Re: Intel HDMI audio stops after 15 minutes
Date: Wed, 4 Aug 2010 19:41:27 -0700
Message-ID: <AANLkTime=62ZQ6i-KtRK_pP4X54jLNQbz73PK3tFNtbJ@mail.gmail.com>
References: <20100804173509.GA12328@csy.ca> <20100805010259.GA6079@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51]) by alsa0.perex.cz (Postfix) with ESMTP id C291D2441B
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Aug 2010 04:41:28 +0200 (CEST)
Received: by ywa6 with SMTP id 6so2484216ywa.38
	for <alsa-devel@alsa-project.org>; Wed, 04 Aug 2010 19:41:28 -0700 (PDT)
In-Reply-To: <20100805010259.GA6079@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Wu Fengguang <fengguang.wu@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Shane W <shane-alsa@csy.ca>
List-Id: alsa-devel@alsa-project.org

If it's screen blanking then add these to the `Section "ServerLayout"`
of your xorg conf:

        Option          "BlankTime"     "0"
        Option          "StandbyTime"   "0"
        Option          "SuspendTime"   "0"
        Option          "OffTime"       "0"

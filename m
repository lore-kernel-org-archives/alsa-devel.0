From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Mixer volume/decibel mapping
Date: Sat, 5 Jun 2010 07:46:17 +0800
Message-ID: <AANLkTin0BHtrHukMLmLP7PaTESTAKH54dv5Jrz6SBGXw@mail.gmail.com>
References: <201005191834.57919.vand2@gmx.de>
	<AANLkTimRTIwmzU2Dq4lgBSSwtcmSxfMcBfcll9YDC_l5@mail.gmail.com>
	<4BF629B3.9020904@ladisch.de>
	<201005210951.36495.peter.ujfalusi@nokia.com>
	<4BF658C6.4030404@ladisch.de>
	<AANLkTikXWtp87B0Gq_B-vQZXZlBl_MEBqbuHt6N5cTbi@mail.gmail.com>
	<4BFB8C89.3010207@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gw0-f51.google.com (mail-gw0-f51.google.com [74.125.83.51])
	by alsa0.perex.cz (Postfix) with ESMTP id DD9C6103B34
	for <alsa-devel@alsa-project.org>;
	Sat,  5 Jun 2010 01:46:18 +0200 (CEST)
Received: by gwj15 with SMTP id 15so1370265gwj.38
	for <alsa-devel@alsa-project.org>; Fri, 04 Jun 2010 16:46:17 -0700 (PDT)
In-Reply-To: <4BFB8C89.3010207@ladisch.de>
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

2010/5/25 Clemens Ladisch <clemens@ladisch.de>

> Raymond Yau wrote:
> > 2010/5/21 Clemens Ladisch <clemens@ladisch.de>
>
>
> > > 0 == -infinity dB, full scale == 0 dB, and the mapping between mixer
> > > control values and corresponding dB values it _not_ linear.
> > >
>

20 log10 rule

This mean than 0.5 == -6 dB ,  0.25 == -12 dB , 0.124 == -24dB . 0.625 ==
-48dB

I have doubt why PA is at 15% when the volume control of HDA is -48dB

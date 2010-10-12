From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Alsamixertest
Date: Tue, 12 Oct 2010 22:33:43 +0800
Message-ID: <AANLkTikHjYVUmZAP3sJj44x0N2wsYJ8zgcD2cmGNKKpk@mail.gmail.com>
References: <4C9F6409.6010400@aknet.ru> <20100927005858.GD21247@sirena.org.uk>
	<4CA0221D.6030208@aknet.ru> <i7qltg$bph$1@dough.gmane.org>
	<AANLkTi=9gcs0A6s55wSS-RP4NucvUqkxCoYynezdF+5g@mail.gmail.com>
	<4CA306CB.1090305@canonical.com>
	<AANLkTi=h+ZKXNdhmC1BtTbBaGF6_V+uD2ZO7sx4WMJMW@mail.gmail.com>
	<4CA9877F.7060009@canonical.com> <4CA9C22A.2010104@ladisch.de>
	<4CA9C7BE.7020804@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) by alsa0.perex.cz (Postfix) with ESMTP id F2BAB24385
	for <alsa-devel@alsa-project.org>;
	Tue, 12 Oct 2010 16:33:43 +0200 (CEST)
Received: by ewy9 with SMTP id 9so722454ewy.38
	for <alsa-devel@alsa-project.org>; Tue, 12 Oct 2010 07:33:43 -0700 (PDT)
In-Reply-To: <4CA9C7BE.7020804@canonical.com>
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

2010/10/4 David Henningsson <david.henningsson@canonical.com>
>>I just released a new version where you can set the step size at the
command line:

>>
https://edge.launchpad.net/~diwic/+archive/maverick/+files/alsamixertest_48.11.tar.gz<https://edge.launchpad.net/%7Ediwic/+archive/maverick/+files/alsamixertest_48.11.tar.gz>


Have you performed any test on your HDA-Intel since you have changed
testcase.sh to use "plug:front" as output device ?


softvol plugin of front device of HDA-Intel is 0.2 dB per step (
51dB/255)and what is your HDA master volume 's dB per step ?


StepSize (7 bits) indicates the size of each step in the gain range. Each
individual step may be 0-32 dB specified in 0.25-dB steps. A value of 0
indicates 0.25-dB steps, while a value of 127d indicates a 32-dB step

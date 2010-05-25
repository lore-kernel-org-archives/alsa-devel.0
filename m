From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Mixer volume/decibel mapping
Date: Tue, 25 May 2010 10:49:13 +0200
Message-ID: <4BFB8F09.9010302@ladisch.de>
References: <201005191834.57919.vand2@gmx.de>	
	<AANLkTimRTIwmzU2Dq4lgBSSwtcmSxfMcBfcll9YDC_l5@mail.gmail.com>	
	<4BF629B3.9020904@ladisch.de>	
	<201005210951.36495.peter.ujfalusi@nokia.com>	
	<4BF658C6.4030404@ladisch.de>	
	<AANLkTikXWtp87B0Gq_B-vQZXZlBl_MEBqbuHt6N5cTbi@mail.gmail.com>	
	<4BFB8C89.3010207@ladisch.de>
	<AANLkTimNj_7k_l7nKLk87towdjtN5j0CSdmws02gpg8v@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 4A7F52413A
	for <alsa-devel@alsa-project.org>;
	Tue, 25 May 2010 10:49:16 +0200 (CEST)
In-Reply-To: <AANLkTimNj_7k_l7nKLk87towdjtN5j0CSdmws02gpg8v@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: James Courtier-Dutton <james.dutton@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Lennart Poettering <lennart@poettering.net>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

James Courtier-Dutton wrote:
> On 25 May 2010 09:38, Clemens Ladisch <clemens@ladisch.de> wrote:
> > All the others seem to be mistakes:
> >
> > > soc/codecs/stac9766.c:...
> > > soc/codecs/wm8350.c:...
> > > soc/codecs/wm8400.c:...
> > > soc/codecs/wm8990.c:...
> 
> Could this maybe explain why pulseaudio was having such problems with
> alsa with regards to gain controls????

Only if it happens on embedded hardware that uses these particular
codecs.


Regards,
Clemens

From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: Setting audio channels on ICH5 with SALSA
Date: Fri, 13 Jul 2007 19:19:31 +0200
Message-ID: <1184347171.32282.1200039381@webmail.messagingengine.com>
References: <469537DD.3020901@tse.gov.br> <469556F3.9060600@tse.gov.br>
	<1184222164.3645.1199757897@webmail.messagingengine.com>
	<46979E84.3090006@tse.gov.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id C221024344
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Jul 2007 19:19:33 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <46979E84.3090006@tse.gov.br>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Fausto Carvalho Marques SIlva <fausto@tse.gov.br>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Fausto Carvalho Marques SIlva wrote:
> I think the default device on alsa.conf is setting something the 
> salsa-lib does not...

Yes: When the hardware does not support the sample format requested by
the application, the default device automatically converts it.


Regards,
Clemens

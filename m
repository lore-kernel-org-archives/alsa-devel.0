From: Fausto Carvalho Marques SIlva <fausto@tse.gov.br>
Subject: Re: Remove dynamic configuration from alsa-lib
Date: Tue, 03 Jul 2007 16:29:17 -0300
Message-ID: <468AA38D.3030301@tse.gov.br>
References: <468A9F7E.3030806@tse.gov.br>
	<75b66ecd0707031215m609685aje041010626d7a5d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dexter.tse.gov.br (dexter.tse.gov.br [200.252.157.99])
	by alsa0.perex.cz (Postfix) with ESMTP id 8822F103841
	for <alsa-devel@alsa-project.org>;
	Tue,  3 Jul 2007 21:36:05 +0200 (CEST)
In-Reply-To: <75b66ecd0707031215m609685aje041010626d7a5d@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Lee Revell wrote:

>I doubt there's an easy way - why would you want to do that?
>  
>
Because i have a "embedded device" that does not need the alsa.conf. My 
configuration is only:

pcm.default {
	type hw
	card 0
	device 0
}

ctl.default {
	type hw
	card 0
}


No need for anything else...
Could be a "program" that runs with a configure option ( 
--conf-dynamic=<my-alsa.conf> ) for generating a
static structure for "feeding" pcm, control,rawmidi and others...

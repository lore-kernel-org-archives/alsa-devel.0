From: Fausto Carvalho Marques SIlva <fausto@tse.gov.br>
Subject: Re: Setting audio channels on ICH5 with SALSA
Date: Wed, 11 Jul 2007 19:17:23 -0300
Message-ID: <469556F3.9060600@tse.gov.br>
References: <469537DD.3020901@tse.gov.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dexter.tse.gov.br (dexter.tse.gov.br [200.252.157.99])
	by alsa0.perex.cz (Postfix) with ESMTP id BCE4F103817
	for <alsa-devel@alsa-project.org>;
	Thu, 12 Jul 2007 00:21:05 +0200 (CEST)
Received: from dexter.tse.gov.br (localhost.tse.gov.br [127.0.0.1])
	by nod32.tse.gov.br (Postfix) with ESMTP id 88571FCC32
	for <alsa-devel@alsa-project.org>; Wed, 11 Jul 2007 19:21:03 -0300 (BRT)
Received: from webmail.tse.gov.br (webmail.tse.gov.br [10.28.1.25])
	by dexter.tse.gov.br (Postfix) with ESMTP id 85B2FFCBED
	for <alsa-devel@alsa-project.org>; Wed, 11 Jul 2007 19:21:03 -0300 (BRT)
Received: from webmail.tse.gov.br (localhost.localdomain [127.0.0.1])
	by nod32.tse.gov.br (Postfix) with ESMTP id 6F7B014C0DD
	for <alsa-devel@alsa-project.org>; Wed, 11 Jul 2007 19:21:03 -0300 (BRT)
Received: from [10.28.219.33] (unknown [10.28.219.33])
	by webmail.tse.gov.br (Postfix) with ESMTP id 6D0F114C0DC
	for <alsa-devel@alsa-project.org>; Wed, 11 Jul 2007 19:21:03 -0300 (BRT)
In-Reply-To: <469537DD.3020901@tse.gov.br>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

More info:
Even getting the number of avaiable audio channels i get error: EINVAL
Debuging gets me to:

SNDRV_PCM_HW_PARAM_CHANNELS
params->intervals[2] =  {min = 2, max = 6, openmin = 0, openmax = 0, 
integer = 1, empty = 0}
so snd_interval_single does not get valid ...

Any help is wellcome...
Fausto Carvalho Marques Silva

>Setting audio channels on ICH5 with SALSA generates and: EINVAL
>Numbers of channels is 1. Does anyone have some ideias?? ( on ICH6 and 
>ICH7 works well)
>thanks...
>Fausto Carvalho Marques Silva
>_______________________________________________
>Alsa-devel mailing list
>Alsa-devel@alsa-project.org
>http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
>  
>

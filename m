From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: Setting audio channels on ICH5 with SALSA
Date: Thu, 12 Jul 2007 08:36:04 +0200
Message-ID: <1184222164.3645.1199757897@webmail.messagingengine.com>
References: <469537DD.3020901@tse.gov.br> <469556F3.9060600@tse.gov.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 65B2910387D
	for <alsa-devel@alsa-project.org>;
	Thu, 12 Jul 2007 08:36:06 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <469556F3.9060600@tse.gov.br>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Fausto Carvalho Marques SIlva <fausto@tse.gov.br>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Fausto Carvalho Marques SIlva wrote:
> >Setting audio channels on ICH5 with SALSA generates and: EINVAL
> >Numbers of channels is 1.

The ICH5 AC97 controller does not support mono output; you must use at
least a stereo stream.

> Even getting the number of avaiable audio channels i get error: EINVAL

What function did you try to use?

> Debuging gets me to:
> 
> SNDRV_PCM_HW_PARAM_CHANNELS
> params->intervals[2] =  {min = 2, max = 6, ...

It supports 2, 4 or 6 channels; this is not a single value.


HTH
Clemens

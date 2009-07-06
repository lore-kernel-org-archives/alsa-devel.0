From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: snd_pcm_format_set_silence parameter
Date: Mon, 06 Jul 2009 15:52:45 +0200
Message-ID: <4A5201AD.5040705@ladisch.de>
References: <1246761001-21982-1-git-send-email-troy.kisky@boundarydevices.com>	<1246761001-21982-2-git-send-email-troy.kisky@boundarydevices.com>	<1246761001-21982-3-git-send-email-troy.kisky@boundarydevices.com>	<1246761001-21982-4-git-send-email-troy.kisky@boundarydevices.com>	<1246761001-21982-5-git-send-email-troy.kisky@boundarydevices.com>	<1246761001-21982-6-git-send-email-troy.kisky@boundarydevices.com>	<1246761001-21982-7-git-send-email-troy.kisky@boundarydevices.com>	<1246761001-21982-8-git-send-email-troy.kisky@boundarydevices.com>	<1246761001-21982-9-git-send-email-troy.kisky@boundarydevices.com>	<1246878557.3192.25.camel@linux-1lbu>	<20090706115442.GA8925@sirena.org.uk>
	<4A51FB94.80802@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 79FBF245D6
	for <alsa-devel@alsa-project.org>;
	Mon,  6 Jul 2009 15:52:50 +0200 (CEST)
In-Reply-To: <4A51FB94.80802@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Guilherme Longo <grlongo.ireland@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Guilherme Longo wrote:
> What exactly does snd_pcm_format_set_silence is useful for???

It allows you to write silence samples into a buffer.
There are sample formats where silent samples are not zero bytes.


HTH
Clemens

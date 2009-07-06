From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: snd_pcm_info_alloca ( ptr) allocate an
	INVALID	snd_pcm_info_t
Date: Mon, 06 Jul 2009 15:52:51 +0200
Message-ID: <4A5201B3.6060903@ladisch.de>
References: <4A4E0610.50709@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 29AED103840
	for <alsa-devel@alsa-project.org>;
	Mon,  6 Jul 2009 15:52:56 +0200 (CEST)
In-Reply-To: <4A4E0610.50709@gmail.com>
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
> Mates, I was looking for a reasonable explanation on why the functions 
> *_alloca as snd_pcm_info_alloca allocates an INVALID snd_pcm_info_t??

"Invalid" just means that the thing does not yet contain valid data.
It would have been better to describe it as empty.


Best regards,
Clemens

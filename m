From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Aureal issues on resume
Date: Sun, 04 Sep 2011 22:32:44 +0200
Message-ID: <4E63E06C.9050109@ladisch.de>
References: <4E60F0C1.5020008@ladisch.de>
	<CAN8cciaL8O_wyESQSeYOr=bvmg=0vjBj0Cw0y09q2eQygs9ODQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4.smtp.messagingengine.com (out4.smtp.messagingengine.com
	[66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id 3C5731037EE
	for <alsa-devel@alsa-project.org>;
	Sun,  4 Sep 2011 22:33:09 +0200 (CEST)
In-Reply-To: <CAN8cciaL8O_wyESQSeYOr=bvmg=0vjBj0Cw0y09q2eQygs9ODQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Raymond Yau wrote:
> The possible way is to save the contents of 128K memory mapped I/O
> ports before suspend to non-volatile memory and restore them after
> resume
>
> Is there any way for alsa driver to allocate non-volatile memory ?

'Normal' memory is saved over suspend.  Just use {k|v}malloc.


Regards,
Clemens

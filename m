From: David Binderman <dcb314@hotmail.com>
Subject: Re: sound/pci/au88x0/au88x0_core.c: many calls to
 memset with not-plausible size ?
Date: Thu, 12 May 2016 15:44:44 +0000
Message-ID: <DUB128-W76D337B598ACBC7C6311A79C730@phx.gbl>
References: <DUB128-W77ABB1A6DDDC9A0AAA26119C790@phx.gbl>,
 <s5hh9e8sxq6.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from DUB004-OMC3S35.hotmail.com (dub004-omc3s35.hotmail.com
 [157.55.2.44]) by alsa0.perex.cz (Postfix) with ESMTP id B0811265162
 for <alsa-devel@alsa-project.org>; Thu, 12 May 2016 17:44:44 +0200 (CEST)
In-Reply-To: <s5hh9e8sxq6.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello there,

----------------------------------------
> Yes, indeed these look wrong. But the simplest fix is just to write
> like
> memset(stream->resources, 0, sizeof(stream->resources));
>
> Care to send a fix patch?

Thanks for your offer, but not possible from this account.
I am happy for someone else to provide one.

Regards

David Binderman


 		 	   		  

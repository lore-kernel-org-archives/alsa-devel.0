From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: no sound with the new imac
Date: Wed, 08 Apr 2009 16:40:26 +0200
Message-ID: <49DCB75A.1010005@ladisch.de>
References: <dd18b0c30904080023r5e915af1rdbb5333d57e49188@mail.gmail.com>
	<200904081016.32752.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtprelay05.ispgateway.de (smtprelay05.ispgateway.de
	[80.67.18.43]) by alsa0.perex.cz (Postfix) with ESMTP id 31A132435F
	for <alsa-devel@alsa-project.org>;
	Wed,  8 Apr 2009 16:40:19 +0200 (CEST)
In-Reply-To: <200904081016.32752.rjw@sisk.pl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Justin Mattock <justinmattock@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Rafael J. Wysocki wrote:
> Takashi, what's the appropriate list for ALSA-related things?

alsa-devel (Takashi is on vacation until after the Easter weekend).

> On Wednesday 08 April 2009, Justin Mattock wrote:
> > Can somebody point me in the right direction
> > to creating the correct pin numbers etc...
> > for the new imac so I can have sound.

What kernel version are you using?  Are there any messages in the
system log when you load the snd-hda-intel driver?  What model do you
mean with "the new imac"?  What are the contents of
/proc/asound/card0/codec#0?


Best regards,
Clemens

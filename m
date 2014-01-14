From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: alsa on non-linux
Date: Tue, 14 Jan 2014 15:04:58 +0100
Message-ID: <52D5440A.6080508@ladisch.de>
References: <20140110153700.GC1173@quark.internal.precedence.co.uk>
 <s5hwqi4t6zg.wl%tiwai@suse.de>
 <20140114101709.GB160@quark.internal.precedence.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 3BE8F261717
 for <alsa-devel@alsa-project.org>; Tue, 14 Jan 2014 15:05:07 +0100 (CET)
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
 by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 9F51E20F45
 for <alsa-devel@alsa-project.org>; Tue, 14 Jan 2014 09:05:01 -0500 (EST)
In-Reply-To: <20140114101709.GB160@quark.internal.precedence.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Patrick Welche <prlw1@cam.ac.uk>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Patrick Welche wrote:
> I started out, writing the attached patch in November, but then it looked
> as though the boundaries of application library interface and linux sound
> chip driver had become so blurred that I thought that a decision had been
> taken to bin all OSes bar linux, hence the question. Can you give me a
> hint on how you think it is supposed to work?

Only the "hw" plugins access the Linux kernel drivers.  Anything else
should be portable (with the exception of plugins like "dmix" that
require a "hw" plugin as their slave).

For most device types (hwdep/seq/rawmidi/timer), the hw plugin is the
only implementation, so a portable alsa-lib has only control and pcm
devices at the moment.


Regards,
Clemens

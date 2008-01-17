From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: S16_LE + softvol = bad
Date: Thu, 17 Jan 2008 15:00:47 +0100
Message-ID: <1200578447.2521.1231765977@webmail.messagingengine.com>
References: <fmnlt1$g5m$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id DDF81243AD
	for <alsa-devel@alsa-project.org>; Thu, 17 Jan 2008 15:00:48 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <fmnlt1$g5m$1@ger.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Alexander E. Patrakov" <patrakov@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Alexander E. Patrakov wrote:
> some cards (most notably, Intel HD audio) have the PCM control as softvol, and 
> default to S16_LE as a format for dmix.

HDA-Intel.conf doesn't set a sample format, and when none is set, dmix
tries S32 before S16.  You get S16 only if the device doesn't support
S32.


Regards,
Clemens

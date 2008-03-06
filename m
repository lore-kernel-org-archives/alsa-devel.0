From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: ALSA and SALSA install
Date: Thu, 06 Mar 2008 17:46:03 +0100
Message-ID: <47D01FCB.2010509@ladisch.de>
References: <200803061641.33445.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 89C641038F9
	for <alsa-devel@alsa-project.org>; Thu,  6 Mar 2008 17:44:31 +0100 (CET)
In-Reply-To: <200803061641.33445.gineera@aspect135.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alan Horstmann <gineera@aspect135.co.uk>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Alan Horstmann wrote:
> Is there a way to install both at the same time, so on a PC code can be
> compiled and experimented with first -lasound and then -lsalsa without
> alternately re-installing the libraries with make install?

It should be possible to install salsa-lib into another directory (by
using the *prefix configure options) and then to change the include
and library paths when compiling the program that uses it.


HTH
Clemens

From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH] aplay: increase channel limit to 256
Date: Wed, 29 Jun 2011 09:54:33 +0200
Message-ID: <4E0ADA39.8080902@perex.cz>
References: <a0a631e9393835ba8f25e49847259b71a84fcf88.1309333405.git.tim@klingt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [77.48.224.245])
	by alsa0.perex.cz (Postfix) with ESMTP id 18D8B24704
	for <alsa-devel@alsa-project.org>;
	Wed, 29 Jun 2011 09:54:35 +0200 (CEST)
In-Reply-To: <a0a631e9393835ba8f25e49847259b71a84fcf88.1309333405.git.tim@klingt.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tim Blechmann <tim@klingt.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Date 29.6.2011 09:44, Tim Blechmann wrote:
> aplay is limited to 32 channels, which makes it impossible to use it for
> testing devices with more channels. here we increase the limit to 256,
> which should be sufficient for a virtual device made of 4 64-channel
> soundcards.
> 
> Signed-off-by: Tim Blechmann <tim@klingt.org>

Applied. Thanks.

				Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project; Red Hat, Inc.

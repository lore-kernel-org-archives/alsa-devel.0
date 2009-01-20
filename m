From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH 1/2] Remove definition for surround sound
 devices on ICE1712.
Date: Tue, 20 Jan 2009 13:48:36 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0901201339310.8466@tm8103.perex-int.cz>
References: <1232455075-27712-1-git-send-email-flameeyes@gmail.com>
	<1232455075-27712-2-git-send-email-flameeyes@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 68BD82434E
	for <alsa-devel@alsa-project.org>; Tue, 20 Jan 2009 13:48:37 +0100 (CET)
In-Reply-To: <1232455075-27712-2-git-send-email-flameeyes@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: =?utf-8?q?Diego=20E=2E=20=27Flameeyes=27=20Petten=C3=B2?= <flameeyes@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 20 Jan 2009, Diego E. 'Flameeyes' Petten? wrote:

> The ICE1712-based cards are non-surround cards with only stereo final
> output. It's not possible to use them as surround cards, so these 
> devices don't make sense.

ICE1712 has 8 independent outputs, so why surround definitions do not 
make sense?

> They also don't work since opening those devices with less than the 
> amount of channels will fail.

Probably slave.pcm.channels definition is missing? But I wonder why it 
does not work automatically.

					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.

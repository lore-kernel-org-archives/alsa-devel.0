From: "Andreas Falkenhahn" <andreas@airsoftsoftwair.de>
Subject: Changing volume of a single PCM channel
Date: Mon, 3 May 2010 13:02:18 +0200
Message-ID: <dcf12bb1ee5921100de95d412cadcc5b-EhVcX19FRQFfRwgeDBcNWRwwfgFLV15YQUBGAEFbWi9fXEYKW1loAFBUQ1tYLkQAWFhRSFxQWwA=-webmailer2@server08.webmailer.hosteurope.de>
Reply-To: andreas@airsoftsoftwair.de
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from jordan.mc0.hosteurope.de (jordan.mc0.hosteurope.de
	[80.237.138.9]) by alsa0.perex.cz (Postfix) with ESMTP id 580F724536
	for <Alsa-devel@alsa-project.org>;
	Mon,  3 May 2010 13:02:19 +0200 (CEST)
Received: from server08.webmailer.hosteurope.de ([10.9.0.187]);
	by mailout.hosteurope.de (jordan.mc0.hosteurope.de) running
	EXperimental Internet Mailer with esmtps (TLSv1:AES256-SHA:256)
	id 1O8tQ6-0008It-IV
	for Alsa-devel@alsa-project.org; Mon, 03 May 2010 13:02:38 +0200
Received: from nobody by server08.webmailer.hosteurope.de with local (Exim
	4.69) (envelope-from <andreas@airsoftsoftwair.de>)
	id 1O8tPm-0004Sm-Lg
	for Alsa-devel@alsa-project.org; Mon, 03 May 2010 13:02:18 +0200
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

how do I change the volume of single PCM channel with ALSA? I'm playing
multiple sounds at the same time by opening a new channel for every sound
using snd_pcm_open() and let PulseAudio do the mixing. Now assuming that I
have allocated four channels using snd_pcm_open()... now I'd like to
change the volume of the second channel, the other three channels' volume
should not be affected. How can I do this?

AFAICS, volume control is provided by the ALSA mixer interface but I don't
seem to figure out how to connect the mixer with my PCM channels opened
using snd_pcm_open().

Thanks for any help,

Andreas

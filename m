From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: How to test new SDPIF implementation?
Date: Sun, 10 May 2009 21:25:58 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0905102122360.25064@eeebox2.perex-int.cz>
References: <9e4733910905101213y6c8909b4l16542f9e59c4db6f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 04588243F1
	for <alsa-devel@alsa-project.org>;
	Sun, 10 May 2009 21:25:59 +0200 (CEST)
In-Reply-To: <9e4733910905101213y6c8909b4l16542f9e59c4db6f@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sun, 10 May 2009, Jon Smirl wrote:

> I would like to test my SPDIF driver implementation. How can I used
> command line tools to play sample 5.1 music over SPDIF?
>
> I have a file 5.1 AC3 encoded file -- w.ac3
>
> This doesn't work:
>
> iecset -D hw:0 audio off
> aplay -c 2 -r 48000 -f S16_BE -D hw:0,1 w.ac3

Use 'ac3dec -C <ac3file>' from alsa-tools to play .ac3 files. The spdif 
output of ac3 format requires some padding. You cannot send contents of 
.ac3 file directly to PCM device.

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.

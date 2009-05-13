From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: ALSA 1.0.20 PCM Capture Problem (Does not happen
 on ALSA 1.0.19)
Date: Wed, 13 May 2009 10:43:28 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0905131041330.25064@eeebox2.perex-int.cz>
References: <4A09E719.9040100@messagenetsystems.com>
	<b24e53350905121945q35b1e515q1ad1a808b8d1539a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 456991037E3
	for <alsa-devel@alsa-project.org>;
	Wed, 13 May 2009 10:43:29 +0200 (CEST)
In-Reply-To: <b24e53350905121945q35b1e515q1ad1a808b8d1539a@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Robert Krakora <rob.krakora@messagenetsystems.com>
Cc: jerry Geis <geisj@messagenetsystems.com>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 12 May 2009, Robert Krakora wrote:

> Sorry, on the last e-mail I sent the output of the VLC client and not
> the server.  Here is the output of the VLC server:

Is something sound related in dmesg output?

Also try enable xrun_debug in /proc/asound tree (echo 1 > xrun_debug) and 
look to dmesg for debug messages.

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.

From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Dsnoop-plugin buffer sizes
Date: Mon, 14 Mar 2011 11:07:36 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1103141107030.4805@eeebox2.perex-int.cz>
References: <A612847CFE53224C91B23E3A5B48BAC749EE00F801@xmail3.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id AFFEB1037EC
	for <alsa-devel@alsa-project.org>; Mon, 14 Mar 2011 11:07:36 +0100 (CET)
In-Reply-To: <A612847CFE53224C91B23E3A5B48BAC749EE00F801@xmail3.se.axis.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Magnus Olsson <magnus.olsson@axis.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 14 Mar 2011, Magnus Olsson wrote:

> Hi,
>
> I'm having issues with garbage data in my audio stream, which I believe 
> is caused by incorrect buffer sizes somewhere in the audio pipeline. The 
> garbage occurs periodically and is always constant in length. This 
> problem only triggers when I use the dsnoo-plugin. If running directly 
> towards the device, the audio stream is fine (no garbage). I've not 
> tested if this occurs with any other plugin.
>
> I'm using Dsnoop to capture a mono stream from a stereo device using 
> arecord, arecord -v -r 16000 -c1 -Daudiosource0 -fS16_LE /tmp/in.wav 
> (where audiosource0 is my dsnoop-device, bound to channel 0)
>
> The verbose info from arecord shows me that ALSA has correctly created 
> the Dsnoop device, with a "buffer_size" of 8000. It also shows that it 
> has opened my Hardware device in MMAP-mode, with a "buffer_size" of 
> 8192.

Show us this output from 'arecord -v'.

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.

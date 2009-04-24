From: "Sudeept Prusti" <sudeeptp@tataelxsi.co.in>
Subject: Re: Help
Date: Fri, 24 Apr 2009 17:23:52 +0530
Message-ID: <9D5E1752379A43408015F7FE98466115023F03C4@CHNEXVS01.VSNLXCHANGE.COM>
References: <9D5E1752379A43408015F7FE98466115023F03C3@CHNEXVS01.VSNLXCHANGE.COM>
	<alpine.LNX.2.00.0904241338080.25064@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpin2.mailsecure.in (SMTPIN2.mailsecure.in [121.241.224.3])
	by alsa0.perex.cz (Postfix) with ESMTP id 17A3E103897
	for <alsa-devel@alsa-project.org>;
	Fri, 24 Apr 2009 13:59:32 +0200 (CEST)
Content-class: urn:content-classes:message
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Jaroslav,
 
can u tell what all are changes to be made for the program to playout a simple PCM file. if any reference you could give me then it's quiet good.
 
Thanks,
Sudeept

________________________________

From: Jaroslav Kysela [mailto:perex@perex.cz]
Sent: Fri 4/24/2009 5:09 PM
To: Sudeept Prusti
Cc: ALSA development
Subject: Re: [alsa-devel] Help



On Fri, 24 Apr 2009, Sudeept Prusti wrote:

> Hi all,
>
> As i am working on alsa for minimal PCM playback (8khz,mono,16 bit pcm
> file).
>
> When i tried to allocate 1k buffer and send through snd_pcm_writei()
> call it doesn't play perfect and skips are there in between. If we keep
> on increasing in allocating the buffer for 31 kb then it could play the
> buffers randomly.

Sure. Your file read logic is broken. You have to check number of bytes
read and do not assume that 'k' bytes were read all time. Also, using seek
is not necessary for sequential reads.

                                                Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.




The information contained in this electronic message and any attachments to this message are intended for the exclusive 
use of the addressee(s) and may contain proprietary, confidential or privileged information. If you are not the intended
 recipient, you should not disseminate, distribute or copy this e-mail. Please notify the sender immediately and destroy
 all copies of this message and any attachments contained in it.

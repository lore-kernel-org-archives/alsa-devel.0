From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: mm functions vs. normal IO
Date: Tue, 04 Mar 2008 14:04:26 +0000
Message-ID: <47CD56EA.9050405@superbug.co.uk>
References: <47CC7E6D.4030704@googlemail.com> <47CD0137.9000608@ladisch.de>
	<af8e60de0803040555k3bde920die41a13d1bd76a93c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from anchor-post-37.mail.demon.net (anchor-post-37.mail.demon.net
	[194.217.242.87])
	by alsa0.perex.cz (Postfix) with ESMTP id 1F7471038BB
	for <alsa-devel@alsa-project.org>; Tue,  4 Mar 2008 15:04:28 +0100 (CET)
In-Reply-To: <af8e60de0803040555k3bde920die41a13d1bd76a93c@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Reiner P <reiner1210@googlemail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Reiner P wrote:
> Hello,
>
> ok, at the moment I use a simple read(...) to get the data from file
> so mm should be ok.
>
> Playing position:
> I can count the frames I have written to the buffer but where is the
> actual play position ???
> What's the porpose of the triigerTimestamp in the status filed?
>
> Thanks
> Reiner
>
>    
Use snd_pcm_delay()

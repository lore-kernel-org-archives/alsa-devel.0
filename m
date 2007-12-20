From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Event notification
Date: Thu, 20 Dec 2007 10:55:14 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0712201052240.8567@tm8103.perex-int.cz>
References: <loom.20071219T234825-811@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 9D5C3103878
	for <alsa-devel@alsa-project.org>; Thu, 20 Dec 2007 10:55:14 +0100 (CET)
In-Reply-To: <loom.20071219T234825-811@post.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Miloslaw Smyk <thorgal@wfmh.org.pl>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 19 Dec 2007, Miloslaw Smyk wrote:

> Hi,
> 
> My app needs to know about the events occurring to a sound card. 
> Specifically, I am interested in start, stop, pause and volume change. 
> While I could monitor volume by similar means as alsamixer does (is 
> there any doc on this apart from the source code?), I am not sure if 
> monitoring other events is at all possible. I would appreciate any 
> suggestions as to how to do this.

You may write a simple monitor plugin to alsa-lib and create an interface 
to send these events to your code (shm, socket or so). Or you can monitor 
(periodically read) /proc/asound/card/ files (but they won't tell you the 
reason why stream stopped).

					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project

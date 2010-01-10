From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: aplay - Audio Surveilance
Date: Sun, 10 Jan 2010 18:59:35 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1001101858460.4210@eeebox2.perex-int.cz>
References: <1262988011.13167.10.camel@sauterws02.sauterhome>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 6397924788
	for <alsa-devel@alsa-project.org>; Sun, 10 Jan 2010 18:59:36 +0100 (CET)
In-Reply-To: <1262988011.13167.10.camel@sauterws02.sauterhome>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: John Sauter <John_Sauter@systemeyescomputerstore.com>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, 8 Jan 2010, John Sauter wrote:

> I have added some features to aplay to make audio surveillance easier:
> --process-id-file writes the PID to a file so another program can signal
> aplay to close its capture file and open another one without missing any
> sound.  --max-file-time causes the close and re-open to happen
> automatically.  --use-strftime allows capture files to be named for
> their start times.  Details are in the man file.

Thanks. I've applied all three patches with some minor modifications to 
the ALSA GIT tree.

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.

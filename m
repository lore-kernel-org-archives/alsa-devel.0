From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: [pulseaudio-discuss] alsa pulse bugs
Date: Tue, 6 May 2008 21:38:24 +0200
Message-ID: <20080506193824.GC25436@tango.0pointer.de>
References: <20080505103410.zv8dezd9z44cksoc@dbservice.com>
	<fvmi82$f7a$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 7E04E243A4
	for <alsa-devel@alsa-project.org>;
	Tue,  6 May 2008 21:38:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <fvmi82$f7a$1@ger.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: General PulseAudio Discussion <pulseaudio-discuss@mail.0pointer.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 05.05.08 09:58, Colin Guthrie (gmane@colin.guthr.ie) wrote:

> 
> tom@dbservice.com wrote:
> > I reported three bugs to the alsa bugtracker:
> > 
> > https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3942
> > https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3943
> > https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3944
> > 
> > It's three bugs after all. Once these are fixed I expect Wine to work.  
> > *fingers crossed*
> 
> Ace Tom :)
> 
> I've cross posted this to the alsa devel list. Hopefully Takashi (who's 
> committed some pulse-related stuff recently) will have some insight here.
> 
> Re the snd_pcm_delay() including network latency (#3945), this clearly 
> makes sense for network streams. Does you proposed fix include this 
> delay (albeit with the improvement that it also will drop to 0 if there 
> are no samples queued)?
> 
> Also re #3942, I believe (but not sure) that the max buffer in the 
> glitch free branch has been increased significantly (as it now needs to 
> keep some degree of past sound as well as future buffer to allow the 
> rewinds to work properly (this is no doubt an inaccurate description of 
> why it's needed.... :p)) I'm not sure how this would affect this 
> solution, but Lennart will be able to advise better.

Yes, with glitch-free maxlength becomes mostly irrelevant. It should
default to "0" know, to let the server decide.

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4

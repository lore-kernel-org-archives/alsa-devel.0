From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: alsa pulse bugs
Date: Mon, 05 May 2008 09:58:42 +0100
Message-ID: <fvmi82$f7a$1@ger.gmane.org>
References: <20080505103410.zv8dezd9z44cksoc@dbservice.com>
Reply-To: General PulseAudio Discussion <pulseaudio-discuss@mail.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <pulseaudio-discuss-bounces@mail.0pointer.de>
In-Reply-To: <20080505103410.zv8dezd9z44cksoc@dbservice.com>
List-Unsubscribe: <https://tango.0pointer.de/mailman/listinfo/pulseaudio-discuss>,
	<mailto:pulseaudio-discuss-request@mail.0pointer.de?subject=unsubscribe>
List-Archive: <https://tango.0pointer.de/pipermail/pulseaudio-discuss>
List-Post: <mailto:pulseaudio-discuss@mail.0pointer.de>
List-Help: <mailto:pulseaudio-discuss-request@mail.0pointer.de?subject=help>
List-Subscribe: <https://tango.0pointer.de/mailman/listinfo/pulseaudio-discuss>,
	<mailto:pulseaudio-discuss-request@mail.0pointer.de?subject=subscribe>
Sender: pulseaudio-discuss-bounces@mail.0pointer.de
Errors-To: pulseaudio-discuss-bounces@mail.0pointer.de
To: pulseaudio-discuss@mail.0pointer.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

tom@dbservice.com wrote:
> I reported three bugs to the alsa bugtracker:
> 
> https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3942
> https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3943
> https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3944
> 
> It's three bugs after all. Once these are fixed I expect Wine to work.  
> *fingers crossed*

Ace Tom :)

I've cross posted this to the alsa devel list. Hopefully Takashi (who's 
committed some pulse-related stuff recently) will have some insight here.

Re the snd_pcm_delay() including network latency (#3945), this clearly 
makes sense for network streams. Does you proposed fix include this 
delay (albeit with the improvement that it also will drop to 0 if there 
are no samples queued)?

Also re #3942, I believe (but not sure) that the max buffer in the 
glitch free branch has been increased significantly (as it now needs to 
keep some degree of past sound as well as future buffer to allow the 
rewinds to work properly (this is no doubt an inaccurate description of 
why it's needed.... :p)) I'm not sure how this would affect this 
solution, but Lennart will be able to advise better.

Hopefully he'll have some comments on all of the above bugs as you've 
clearly put in a lot of work to try and nail these issues :)

Col

From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Alsa: Get Playback Volume fails if set by outside
 source
Date: Fri, 16 May 2008 09:42:21 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0805160941170.18373@tm8103.perex-int.cz>
References: <6AA7F928714999469B70E7707C87F82C44CBBA@TW-EVS02.corelcorp.corel.ics>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id B543E24929
	for <alsa-devel@alsa-project.org>;
	Fri, 16 May 2008 09:42:21 +0200 (CEST)
In-Reply-To: <6AA7F928714999469B70E7707C87F82C44CBBA@TW-EVS02.corelcorp.corel.ics>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ashwin Chandra <Ashwin.Chandra@corel.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 16 May 2008, Ashwin Chandra wrote:

> Hello,
> 
> I am having an issue with the Alsa mixer. Currenty I have a function
> that gets the volume via snd_mixer_selem_get_playback_volume. This
> function works fine to get the last-set volume if my application is
> setting the volume. However if I change the volume using an outside
> source, such as alsamixer or gnome-volume-control and then I run the
> above function, the old volume that my application had set last is
> returned.
> 
> Now I edited amixer's source code to put a while(1) around the same
> functions (the snd_mixer_selem_get_playback_volume), and it too does not
> get the correct volume if set from an outside source. Alsamixer on the
> other hand seems to work find, but I am not quite sure how they do it. I
> thought maybe I had to reinitialize the alsa interface (ie.
> snd_mixer_close...and then open, attach, register, etc), but it doesn't
> seem that alsamixer does that. 
> 
> Does anyone have any suggestions about what I can do to get the correct
> volume if set by an outside source??

snd_mixer_handle_events() is function which updates changed controls. 
Values are cached.

						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.

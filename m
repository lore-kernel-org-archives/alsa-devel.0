From: "Timur Tabi" <timur@freescale.com>
Subject: Re: How to report error in _pointer function?
Date: Thu, 7 Aug 2008 13:59:56 -0500
Message-ID: <ed82fe3e0808071159k7aea218cm6184680a9c63d3d2@mail.gmail.com>
References: <ed82fe3e0807300856q6c6daf99n224df8ae4bfe6954@mail.gmail.com>
	<s5hhca7s64k.wl%tiwai@suse.de> <489A1D9E.7040709@freescale.com>
	<s5hfxpg6b65.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.232])
	by alsa0.perex.cz (Postfix) with ESMTP id 1A81124961
	for <alsa-devel@alsa-project.org>;
	Thu,  7 Aug 2008 21:27:12 +0200 (CEST)
Received: by wr-out-0506.google.com with SMTP id 36so479106wra.24
	for <alsa-devel@alsa-project.org>; Thu, 07 Aug 2008 12:27:11 -0700 (PDT)
In-Reply-To: <s5hfxpg6b65.wl%tiwai@suse.de>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 7, 2008 at 11:29 AM, Takashi Iwai <tiwai@suse.de> wrote:

> How is the PCM status during hang?  Check
> /proc/asound/card0/pcm*/sub*/* files.

I wrote a script that repeatedly dumps the contents of
/proc/asound/card0/pcm0p/sub0/status.  I started playback, and it
shows this:

...
closed
closed
closed
state: OPEN
trigger_time: 0.000000000
tstamp      : 0.000000000
delay       : 0
avail       : 0
avail_max   : 0
-----
hw_ptr      : 0
appl_ptr    : 0
state: OPEN
trigger_time: 0.000000000
tstamp      : 0.000000000
delay       : 0
avail       : 0
avail_max   : 0
-----
hw_ptr      : 0
appl_ptr    : 0
state: XRUN
trigger_time: 165.300191122
tstamp      : 165.302136461
delay       : 0
avail       : 0
avail_max   : 0
-----
hw_ptr      : 0
appl_ptr    : 17840
state: XRUN
trigger_time: 165.300191122
tstamp      : 165.304661787
delay       : 0
avail       : 0
avail_max   : 0
-----
hw_ptr      : 0
appl_ptr    : 17840
state: XRUN
trigger_time: 165.300191122
tstamp      : 165.306860459
delay       : 0
avail       : 0
avail_max   : 0
-----
hw_ptr      : 0
appl_ptr    : 17840

and so on.

> Also, could you run with gdb and check at which code-path is it
> stopped?

Sorry, I don't use gdb that much.  How can I do this?  I don't think I
have debug versions of alsa-lib or mplayer.

-- 
Timur Tabi
Linux kernel developer at Freescale

From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: [Alsa-user]  Crash 2.6.32.x, Echo 3G, Alsa, SCSI
Date: Fri, 18 Jun 2010 13:55:09 +0200
Message-ID: <20100618135509.08a51fe8@Jay>
References: <73211.74714.qm@web180714.mail.sp1.yahoo.com>
	<4B684513.8090201@ladisch.de> <20100202230911.71e8b600@Jay>
	<4C040864.8010205@ameritech.net> <20100531225936.4a9344df@Jay>
	<4C04FC3F.70905@ameritech.net> <20100603000828.04af4bdc@Jay>
	<4C1A10DA.4080304@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp209.alice.it (smtp209.alice.it [82.57.200.105])
	by alsa0.perex.cz (Postfix) with ESMTP id B90AE24581
	for <alsa-devel@alsa-project.org>;
	Fri, 18 Jun 2010 13:56:14 +0200 (CEST)
In-Reply-To: <4C1A10DA.4080304@ameritech.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "F. Heitkamp" <heitkamp@ameritech.net>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, linux-audio-user@lists.linuxaudio.org, Clemens Ladisch <clemens@ladisch.de>, linux-kernel@vger.kernel.org, alsa-user@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 17 Jun 2010 08:11:06 -0400
"F. Heitkamp" <heitkamp@ameritech.net> wrote:

> >> My goal is to be able to plug in a MIDI keyboard, or USB guitar
> >> interface and play along with songs etc.
> >>
> >> I plugged in a MIDI keyboard, "/proc/asound/cards" showed the keyboard
> >> was recognized.  The keyboard has a USB and MIDI interface.
> >> I am not sure if they both work at the same time.  I had the MIDI cable
> >> plugged into the Gina3G, but I could not tell if the keyboard was
> >> recognized.
> >> I compiled csound5.  When I engaged it the system immediately froze and
> >> started spitting out:
> >> [...]
> > Ok, I compiled csound, but I don't know how to use it. How can I reproduce
> > the problem ?
> >
> Sorry I took so long to get back to you.
> It turns out Csound is not related to the problem.
> 
> In this case I am only using kernel 2.6.33.5-rt23-amd64, alsa lib 1.0.2, 
> but 2.6.34 does it too.
> I bring up firefox.  Web pages attempt to play sound.   The kernel 
> begans doing:
> 
> [ 2879.766331] allocate_pipes: ch=1 int=2
> [ 2879.766332] allocate_pipes: channel already open
> [ 2879.766333] allocate_pipes(1) err=-11
> [ 2879.766334] pcm_hw_freed
> [ 2.821190] pcm_analog_out_open  cs=0  oc=2  r=44100
> [ 2879.821266] allocate_pipes: ch=1 int=2
> [ 2879.821267] allocate_pipes: channel already open
> 
> ,infinitely.  The system is unusable at this point and I have to 
> Alt-SysRq-k to get back in.
> 
> Let me know what other information to provide.

Perhaps is it related with the OSS emulation ?  Do you know if the browser
plays the sound itself or if it is using an external program or plugin ?


-- 
Giuliano.

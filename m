From: Dr Nicholas J Bailey <nicholas.bailey@glasgow.ac.uk>
Subject: Re: usb-usx2y: playback fails with Tascam US122
	on	kernel 3.14
Date: Thu, 21 Aug 2014 17:14:04 +0100
Message-ID: <13813163.9xG9j8aSFS@arial>
References: <4546801.Z4WD7yaEHq@arial> <1915519.7eNd95CgvB@arial>
 <s5hbnre8gvf.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from plockton.cent.gla.ac.uk (plockton.cent.gla.ac.uk
 [130.209.16.75])
 by alsa0.perex.cz (Postfix) with ESMTP id D12242658B8
 for <alsa-devel@alsa-project.org>; Thu, 21 Aug 2014 18:14:06 +0200 (CEST)
In-Reply-To: <s5hbnre8gvf.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thursday 21 August 2014 09:02:44 you wrote:
> At Wed, 20 Aug 2014 18:50:21 +0100,
> 
> Dr Nicholas J Bailey wrote:
> > ...
> > So the thing is, I can't make any stock kernel work on my Debian laptop,
> > which means there aren't two points between which to bisect.
> > 
> > That's all I've got time for at the moment. I'll append the notes I made
> > yesterday and today while the builds and tests were going on, just in case
> > they are any help. At least I have a kernel (3.10.11) that works for now,
> > but unless somebody who really knows what they are doing is going on the
> > case, it looks like its just a matter of time before I'll be buying a
> > whole bunch of new audio interfaces. We have at least 4 or 5 of these
> > Tascam US-122 boxes, and use them quite a lot, so I am nervously
> > fingering my wallet... :(
> Try to build 3.10.11 from linux-stable tree manually and see whether
> it works.  If yes, there must be a fix between 3.10 and 3.10.11, and
> you can bisect it easily.
> 
> If the manual built 3.10.11 kernel doesn't work, it's most likely a
> kernel config issue, assuming that Debian doesn't put so many own
> kernel patches (especially for the sound stuff).
> 
> 
> Takashi

OK, I don't understand git very well. When I first cloned the kernel repo, I 
did git tag -l, and I'd swear that there were only tags of the form 
v<major>.<minor>(-rc[0-9]+)? but now I give the same command again I get tags 
like v<major>.<minor>.<subminor>(-rc[0-9]+)? That's why I tried to build 3.10 
and 3.11.

I might be going mad. I know I'm tired, but this is a whole new level of 
insanity!

I'll try building 3.10.11 from git and report back.

Nick/.

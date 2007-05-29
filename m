From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: Alsa-OSS Duplex bug (revisited)
Date: Tue, 29 May 2007 23:16:17 +0100
Message-ID: <200705292316.17947.gineera@aspect135.co.uk>
References: <200705272323.13056.gineera@aspect135.co.uk>
	<s5hodk3zi09.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.talktalk.net (wmsmtp.opaltelecom.net [62.24.128.253])
	by alsa0.perex.cz (Postfix) with ESMTP id 6498624401
	for <alsa-devel@alsa-project.org>;
	Wed, 30 May 2007 00:07:39 +0200 (CEST)
In-Reply-To: <s5hodk3zi09.wl%tiwai@suse.de>
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
To: ALSA devel <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

On Tuesday 29 May 2007 17:55, you wrote:
> At Sun, 27 May 2007 23:23:13 +0100,
>
> Alan Horstmann wrote:
.......................................
> > Patch for 1.0.14rc4 is attached for consideration, together with example
> > portaudio patch.
>
> Thanks for the patch.  I see how you struggled with this problem.

Thanks for giving this some consideration...

> Well, this is a bit hard problem to decide which to go.
> While I see the advantage by your hack (small and backward
> compatible), I feel that it's too hackish -- it introduces an
> incompatible way of the existing ioctl.
>
Do you mean in that ioctls in general are not meant to work like that, in 
effect passing 2 numbers rather than one?

> So, I'm not fully convinced by this change yet.
>
> OK, let's whip this dead horse again.
>
> After a quick thought, another possible fix would be to let apps open
> each direction separately.  For that,
>
> - add some way to make the given PCM stream to non-fullduplex
>   (proc or module options?)

Are you thinking that if an option were set, Alsa-OSS would create separate 
devices for capture and playback rather than a single duplex device?  That 
would remove the problem, I think.

> or
>
> - change portaudio to open each direction separately, O_RDONLY and
>   O_WRONLY at first, then use O_RDWR as fallback

Do you mean O_RDONLY first, set capture channels, then O_WRONLY and set 
playback channels before finally O_RDWR in such a way that the previous 
values are retained?  This sounds tricky to implement depending on the apps 
code structure, but might be effective.

> Are these feasible?

The advantage of my proposal is that the ioctl value is a simple integer, and 
can pass between functions as a parameter, or be part of a varible structure 
in just the same way as the present channels number.  Therefore changes to 
the app are very small (portaudio is just one example).

What is frustrating is that the Alsa-OSS stream is fine in duplex with 
variable numbers of channels, but it is simply the lack of a way to pass the 
two numbers to the stream since the OSS ioctl only has one number.  If two 
had been used originally, all would be fine!

Alan

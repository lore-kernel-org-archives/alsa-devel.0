From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Specs available for Sweex External 5.1 with
	digital in/out USB 2.0 / C-Media CM6207
Date: Wed, 4 Jun 2008 13:38:01 -0400
Message-ID: <9e4733910806041038j171bee15j1ec3395e00d772bb@mail.gmail.com>
References: <4845A420.10804@slagter.name>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.245])
	by alsa0.perex.cz (Postfix) with ESMTP id C5D6E103821
	for <alsa-devel@alsa-project.org>;
	Wed,  4 Jun 2008 19:38:03 +0200 (CEST)
Received: by rv-out-0708.google.com with SMTP id f25so171054rvb.32
	for <alsa-devel@alsa-project.org>; Wed, 04 Jun 2008 10:38:02 -0700 (PDT)
In-Reply-To: <4845A420.10804@slagter.name>
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
To: Erik Slagter <erik@slagter.name>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 6/3/08, Erik Slagter <erik@slagter.name> wrote:
> Hi there,
>
>  Today I bought this sound device, I was hoping it had the C-Media CM650?
> USB chip which is already supported by alsa (according to the list).
>
>  Instead it has a CM6207 inside.
>
>  The good news is that it supports USB audio "class" and it's more or less
> usable, some mixer outputs are available (although they're all called
> "speaker") and with some trickery the various outputs can be used.
>
>  The other good news is that Sweex supplies the "official" datasheet from
> C-media which I think is quite interesting and may very well be useful to
> resolve the last few issues.


Write this up for the Free Linux Driver project.

http://lwn.net/Articles/276973/
http://www.linuxdriverproject.org/twiki/bin/view/Main/DriversNeeded


>
>  These are the actual issues (so far, I didn't yet test it exhaustively):
>
>   - using 2 channel output the sound is garbled; it looks like the "wrong" 2
> channel alt setting is used (output of /proc/asound/card?/stream0 on
> request), 4/6 channel output is OK though.
>   - some high squeeking noise although C-Media claims the IC to be high-end
> (or maybe their definition of high-end differs from mine ;-))
>   - all outputs are labelled "speaker 1"
>   - only two outputs have a mute knob, the others cannot be silenced in any
> way, only turned down
>   - one of the two outputs with the mute knob doesn't appear to do anything
> (or maybe it's the sp/dif output?)
>   - the other (with mute) controls the front output
>   - the others (without mute) don't seem to do anything at all
>
>  Is this a typical case of (a) bug(s) in the usb audio class driver or
> should I think of "vendor extensions" here?
>
>  Would any of the developers have some interest in the datasheet of the chip
> and or any data of this thing? Of course I'd like it very much if the device
> would be fully supported but I can only ask nicely ;-)
>
> _______________________________________________
>  Alsa-devel mailing list
>  Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
>
>


-- 
Jon Smirl
jonsmirl@gmail.com

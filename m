From: "Harsha priya gupta" <harshapriya@gmail.com>
Subject: Re: basic question on .pointer function
Date: Fri, 9 May 2008 23:51:17 +0530
Message-ID: <827ad74d0805091121u4c42d172yc2b8e734355ff81d@mail.gmail.com>
References: <827ad74d0805062040i4c2977adrc4fb50fbbc0bff43@mail.gmail.com>
	<s5hwsm321ag.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.240])
	by alsa0.perex.cz (Postfix) with ESMTP id F353024391
	for <alsa-devel@alsa-project.org>;
	Fri,  9 May 2008 20:21:18 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id d31so339316and.80
	for <alsa-devel@alsa-project.org>; Fri, 09 May 2008 11:21:17 -0700 (PDT)
In-Reply-To: <s5hwsm321ag.wl%tiwai@suse.de>
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
Cc: Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Thanks a lot for this pointer. A quick question;

For the .pointer function, it says " This callback is called when the PCM
middle layer inquires the current hardware position on the buffer."

Does the word "PCM middle layer" mean that the MMF like Helix / Gstreamer is
continuously querying for hardware position on the buffer? Or does the
player keep querying?

I also see that this function gets called quiet a number of times. Is there
a way to reduce these calls? My guess is that to reduce the number of calls
to .pointer, MMF or player needs to be modified. Am I thinking right?

-Harsha



On Fri, May 9, 2008 at 4:26 PM, Takashi Iwai <tiwai@suse.de> wrote:

> At Wed, 7 May 2008 09:10:00 +0530,
> Harsha priya gupta wrote:
> >
> > Hi,
> > It would be really helpful if someone can help me understand why do we
> need
> > to implement .pointer and what does it need to do? I am facing an issue
> to
> > write a driver in this .pointer function. Please help
> >
> > Also if someone can point me to a document where all the playback_ops are
> > defined, it would be really helpful
>
> Did you check the page below?
>
> http://www.alsa-project.org/main/index.php/ALSA_Driver_Documentation
>
>
> Takashi
>



-- 
-Harsha

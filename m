From: "Harsha priya gupta" <harshapriya@gmail.com>
Subject: Re: playback write error (DMA or IRQ trouble)
Date: Mon, 2 Jun 2008 13:26:01 +0530
Message-ID: <827ad74d0806020056r486cd83ke7bf137f45af71bd@mail.gmail.com>
References: <827ad74d0806020009l5b666eaex4ce2a2a0a0e42c58@mail.gmail.com>
	<s5h7id8b8bw.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.246])
	by alsa0.perex.cz (Postfix) with ESMTP id 573A110383F
	for <alsa-devel@alsa-project.org>;
	Mon,  2 Jun 2008 09:56:02 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id d31so240208and.80
	for <alsa-devel@alsa-project.org>; Mon, 02 Jun 2008 00:56:01 -0700 (PDT)
In-Reply-To: <s5h7id8b8bw.wl%tiwai@suse.de>
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

I implemented the copy function and immediately transfered the user block
data to the hardware.

Correct me if am wrong;
.pointer implementation - passes the current buffer pointer. When the
.pointer function returns the size of the buffer = user buffer size
logically I need to expect the hardware to send an interrupt because buffer
is consumed and I should call snd_pcm_period_elapsed after that.

what would happen if i call the snd_pcm_period_elapsed from the pointer
function once the buffer is consumed from hardware. Would that be right?
This is what i am trying to do



On Mon, Jun 2, 2008 at 1:02 PM, Takashi Iwai <tiwai@suse.de> wrote:

> At Mon, 2 Jun 2008 12:39:31 +0530,
> Harsha priya gupta wrote:
> >
> > Can anyone give me a clue as to when i would get such an error?
>
> ... only if you give more clue what exactly you did.
>
> In general, it implies that an interrupt isn't issued properly at PCM
> period boundary.
>
>
> Takashi
>



-- 
-Harsha

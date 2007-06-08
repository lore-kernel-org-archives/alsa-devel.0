From: "Nobin Mathew" <nobin.mathew@gmail.com>
Subject: Re: Testing/forcing XRUN
Date: Fri, 8 Jun 2007 12:49:32 +0530
Message-ID: <8d6898730706080019g44b671d3n55f04076746f2b50@mail.gmail.com>
References: <200706081759.06021.linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.235])
	by alsa0.perex.cz (Postfix) with ESMTP id 5161F24687
	for <alsa-devel@alsa-project.org>;
	Fri,  8 Jun 2007 09:19:34 +0200 (CEST)
Received: by wr-out-0506.google.com with SMTP id 67so624476wri
	for <alsa-devel@alsa-project.org>; Fri, 08 Jun 2007 00:19:33 -0700 (PDT)
In-Reply-To: <200706081759.06021.linux@audioscience.com>
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
To: Eliot Blennerhassett <linux@audioscience.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This will be OK to test XRUN condition in driver.

XRUN will be reported in either of these functions

static inline int snd_pcm_update_hw_ptr_interrupt(struct
snd_pcm_substream *substream)

or
static inline int snd_pcm_update_hw_ptr_post(struct snd_pcm_substream
*substream, struct snd_pcm_runtime *runtime)


or you can put some Debug logs in
static void xrun(struct snd_pcm_substream *substream)

All these functions are in sound/core/pcm_lib.c

When we stop the application by issuing Ctrl-Z then onwards
application will not write/read data from device. So driver will go to
XRUN state, when driver detects XRUN it stops the substream by calling
snd_pcm_stop() (inside xrun()). But application cannot detect this
because he is not active. But when we activate application (fg) then
it detects -EPIPE (stopped substream), then application prepare it
snd_pcm_prepare() and starts the playback(substream) again.

Nobin

On 6/8/07, Eliot Blennerhassett <linux@audioscience.com> wrote:
> Hi,
>
> I want to test my driver behaviour when an xrun happens.
>
> I have tried using aplay/arecord, and suspending (ctrl-Z) them while
> playing/recording but this doesn't have the desired effect. (I don't see my
> driver code detecting an xrun).  Instead I see a trigger-stop command to the
> driver.
>
> The apps do report an overrun when they are restarted though.
>
> Can anyone answer these:
>
> 1) Is this a valid way to simulate an xrun due to application not keeping up?
>
> 1.1) If not, what is? Do I have to write an app that deliberately starves the
> streams?
>
> 2) Where is the xrun being detected if my driver doesnt see it?  Where does
> the trigger-stop command come from when I suspend the app?
>
> thanks
>
> Eliot Blennerhassett
> AudioScience Inc.
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>

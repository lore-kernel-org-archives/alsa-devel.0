From: "Harsha priya gupta" <harshapriya@gmail.com>
Subject: Re: HW decoding abstracted in ALSA
Date: Wed, 19 Mar 2008 10:56:05 +0530
Message-ID: <827ad74d0803182226x6cc9ae27ld34d67b5e95962ab@mail.gmail.com>
References: <827ad74d0802242257u604e47d7sb844a29e2bcd1c3b@mail.gmail.com>
	<s5hzltptf9k.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.176])
	by alsa0.perex.cz (Postfix) with ESMTP id C603124343
	for <alsa-devel@alsa-project.org>; Wed, 19 Mar 2008 06:26:06 +0100 (CET)
Received: by wa-out-1112.google.com with SMTP id m33so229887wag.8
	for <alsa-devel@alsa-project.org>; Tue, 18 Mar 2008 22:26:05 -0700 (PDT)
In-Reply-To: <s5hzltptf9k.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, krishna.paul@intel.com
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

      Can you help quantify the 'difficult' part that you have mentioned
here?

     Would I be right if I say that it requires additional  APIs
implementation in ALSA framework and ALSA Libasound to be implemented? Or is
there any other path that we should be following?

     I am copying Krishna to this email who is working with me in this
project. She would like to correspond with you as well in this regard.


Thanks,
Harsha.

On Mon, Feb 25, 2008 at 5:33 PM, Takashi Iwai <tiwai@suse.de> wrote:

> At Mon, 25 Feb 2008 12:27:00 +0530,
> Harsha priya gupta wrote:
> >
> > Hi,
> >
> > I am new to ALSA and audio stack in Linux. I have a sound card that can
> do
> > HW decoding as well. I am looking at writing an ALSA driver such that
> > whatever may be the player or MMF above, it should use the HW decoder
> and
> > not the inherit SW decoder that is available with the player.
> >
> > Can someone help me with some pointers or existing like-drivers?
>
> Which format is in mind?  In theoery, you can implement the h/w
> decoder on the ALSA framework, but there are some restrictions:
>
> - ALSA PCM assumes the constant bitrate
> - The format bit must be defined
> - The specific app recognizes and supports that format
>
> In the case of AC3 or DTS, it's embedded in SPDIF frames so the PCM
> core stuff doesn't take care of the above.  But, in the case of native
> (non-PCM) formats, the support can be difficult as is.
>
>
> Takashi
>



-- 
-Harsha

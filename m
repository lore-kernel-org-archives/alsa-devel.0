From: "Harsha priya gupta" <harshapriya@gmail.com>
Subject: Fwd:  HW decoding abstracted in ALSA
Date: Mon, 25 Feb 2008 23:20:28 +0530
Message-ID: <827ad74d0802250950h7d3d4f01rf6d72e1efe80c0ab@mail.gmail.com>
References: <827ad74d0802242257u604e47d7sb844a29e2bcd1c3b@mail.gmail.com>
	<s5hzltptf9k.wl%tiwai@suse.de>
	<827ad74d0802250409j757042b1vf898282293f8ff79@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from el-out-1112.google.com (el-out-1112.google.com [209.85.162.177])
	by alsa0.perex.cz (Postfix) with ESMTP id 89C7C243F2
	for <alsa-devel@alsa-project.org>; Mon, 25 Feb 2008 18:50:31 +0100 (CET)
Received: by el-out-1112.google.com with SMTP id z25so1351024ele.8
	for <alsa-devel@alsa-project.org>; Mon, 25 Feb 2008 09:50:30 -0800 (PST)
In-Reply-To: <827ad74d0802250409j757042b1vf898282293f8ff79@mail.gmail.com>
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
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,
Thanks for your immediate reply.

My hardware supports MP3 decoding in HW (in addition to few others). I am
looking to write a driver such that when an MP3 file is played, the file is
decoded using the HW decoder and played. Is there a possibility in current
ALSA framework to do so?

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



-- 
-Harsha

From: "Lee Revell" <rlrevell@joe-job.com>
Subject: Re: Patch - Revo7.1 PCM Playback Switch
Date: Fri, 18 May 2007 17:34:55 -0400
Message-ID: <75b66ecd0705181434kbfee145qab84ff9d53892cb6@mail.gmail.com>
References: <9723.25254-1219-662959343-1179521630@seznam.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.230])
	by alsa0.perex.cz (Postfix) with ESMTP id DB64424413
	for <alsa-devel@alsa-project.org>;
	Fri, 18 May 2007 23:34:56 +0200 (CEST)
Received: by wr-out-0506.google.com with SMTP id 58so987589wri
	for <alsa-devel@alsa-project.org>; Fri, 18 May 2007 14:34:55 -0700 (PDT)
In-Reply-To: <9723.25254-1219-662959343-1179521630@seznam.cz>
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
To: "dustin@seznam.cz" <dustin@seznam.cz>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 5/18/07, dustin@seznam.cz <dustin@seznam.cz> wrote:
> I would like to get your opinion on the form of adding this support to the module. The options are either hard-coding the 16 capture channels into the code, assuming that users would prefer as many channels as possible and do the routing in jack, or introducing a module parameter emu1010-capture-channels (range e.g. 1 to 16 - untested yet) and leaving the default number at the existing 8.

I think you should hard code 16 channels.  If this device works
anything like the emu10k1, then you can achieve lower latency by
capturing more channels (because the capture buffer limits are in
bytes, so more channels = fill an N byte buffer faster = lower
latency).

This is how I did multichannel support for the emu10k1 and it works
great, no one has ever complained about wanting to capture fewer
channels...

Lee

From: "Nobin Mathew" <nobin.mathew@gmail.com>
Subject: Re: Software mixing according to priority of streams
Date: Fri, 15 Jun 2007 23:46:53 +0530
Message-ID: <8d6898730706151116s631893e1ja083f861c80d07cb@mail.gmail.com>
References: <8d6898730706150110m35fdfb59m6961aa25d0fcc3b3@mail.gmail.com>
	<8d6898730706150400h6126ec15sae1694b80b47ad53@mail.gmail.com>
	<75b66ecd0706151112h663009ub99740d026c168a6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.179])
	by alsa0.perex.cz (Postfix) with ESMTP id B2FFD246BE
	for <alsa-devel@alsa-project.org>;
	Fri, 15 Jun 2007 20:16:54 +0200 (CEST)
Received: by wa-out-1112.google.com with SMTP id m33so1267918wag
	for <alsa-devel@alsa-project.org>; Fri, 15 Jun 2007 11:16:53 -0700 (PDT)
In-Reply-To: <75b66ecd0706151112h663009ub99740d026c168a6@mail.gmail.com>
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
To: Lee Revell <rlrevell@joe-job.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

A sound server can do this

Maintain a buffer per application ,
and each buffer will have priority. when data comes on higher priority
buffer stop taking data from low priority buffer, and configure the
audio and start pumping data from high priority buffer.


On 6/15/07, Lee Revell <rlrevell@joe-job.com> wrote:
> On 6/15/07, Nobin Mathew <nobin.mathew@gmail.com> wrote:
> > Can somebody throw some ideas on this ?
>
> I don't understand your use case.  Are you saying you want to start a
> playback app (say mplayer) and have the audio switch between devices?
> That's impossible.
>
> If you just want to be able to play audio from multiple apps through
> the same device, then yes, dmix or jack can do it.
>
> Lee
>

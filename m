From: "Lee Revell" <rlrevell@joe-job.com>
Subject: Re: Software mixing according to priority of streams
Date: Fri, 15 Jun 2007 14:12:20 -0400
Message-ID: <75b66ecd0706151112h663009ub99740d026c168a6@mail.gmail.com>
References: <8d6898730706150110m35fdfb59m6961aa25d0fcc3b3@mail.gmail.com>
	<8d6898730706150400h6126ec15sae1694b80b47ad53@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.226])
	by alsa0.perex.cz (Postfix) with ESMTP id 51693246BE
	for <alsa-devel@alsa-project.org>;
	Fri, 15 Jun 2007 20:12:22 +0200 (CEST)
Received: by nz-out-0506.google.com with SMTP id j2so936364nzf
	for <alsa-devel@alsa-project.org>; Fri, 15 Jun 2007 11:12:21 -0700 (PDT)
In-Reply-To: <8d6898730706150400h6126ec15sae1694b80b47ad53@mail.gmail.com>
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
To: Nobin Mathew <nobin.mathew@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 6/15/07, Nobin Mathew <nobin.mathew@gmail.com> wrote:
> Can somebody throw some ideas on this ?

I don't understand your use case.  Are you saying you want to start a
playback app (say mplayer) and have the audio switch between devices?
That's impossible.

If you just want to be able to play audio from multiple apps through
the same device, then yes, dmix or jack can do it.

Lee

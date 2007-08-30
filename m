From: "John Utz" <john.utz@dmx.com>
Subject: Re: Dealing with 'siamesed' DAC sample rates
Date: Thu, 30 Aug 2007 13:05:13 -0700
Message-ID: <20070830130513.76072b52@jutz-gnto64>
References: <20070830115112.02820301@jutz-gnto64>
	<75b66ecd0708301247q6bb6112eh32caaff8bbc367d5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.dmxmusic.com (mail.dmxmusic.com [199.201.237.35])
	by alsa0.perex.cz (Postfix) with ESMTP id 652C9103818
	for <alsa-devel@alsa-project.org>;
	Thu, 30 Aug 2007 22:05:45 +0200 (CEST)
In-Reply-To: <75b66ecd0708301247q6bb6112eh32caaff8bbc367d5@mail.gmail.com>
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
Cc: ALSA Developers <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Lee;

On Thu, 30 Aug 2007 15:47:56 -0400
"Lee Revell" <rlrevell@joe-job.com> wrote:

> On 8/30/07, John Utz <john.utz@dmx.com> wrote:
> > Hello All;
> >
> > The thrice cursed vt1618 has the DAC sample rates regs for the
> > Surround and Center/LFE DAC's (0x2E, 0x30) set to RO and locked to
> > whatever rate that the Front DAC is set to.
> >
> 
> I don't think the driver should expose separate front and rear PCMs
> for this device as they cannot be controlled independently at the HW
> level.

That's a good point.

However, they can be controlled independently for everything *other*
than sample rate.

I'll have to ponder your point carefully and take it into consideration
for what i decide to do when i push out a patch (hopefully one that
will get accepted this time :-) )

But for our *product platform* the independent control is a must
have, so i am kinda stuck solving this problem somehow, someway.

tnx!

johnu

> Lee
> 

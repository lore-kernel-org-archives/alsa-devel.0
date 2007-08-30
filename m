From: "Lee Revell" <rlrevell@joe-job.com>
Subject: Re: Dealing with 'siamesed' DAC sample rates
Date: Thu, 30 Aug 2007 15:47:56 -0400
Message-ID: <75b66ecd0708301247q6bb6112eh32caaff8bbc367d5@mail.gmail.com>
References: <20070830115112.02820301@jutz-gnto64>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.187])
	by alsa0.perex.cz (Postfix) with ESMTP id B42851037F9
	for <alsa-devel@alsa-project.org>;
	Thu, 30 Aug 2007 21:47:58 +0200 (CEST)
Received: by rv-out-0910.google.com with SMTP id k20so222186rvb
	for <alsa-devel@alsa-project.org>; Thu, 30 Aug 2007 12:47:57 -0700 (PDT)
In-Reply-To: <20070830115112.02820301@jutz-gnto64>
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
To: John Utz <john.utz@dmx.com>
Cc: ALSA Developers <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 8/30/07, John Utz <john.utz@dmx.com> wrote:
> Hello All;
>
> The thrice cursed vt1618 has the DAC sample rates regs for the Surround
> and Center/LFE DAC's (0x2E, 0x30) set to RO and locked to whatever rate
> that the Front DAC is set to.
>

I don't think the driver should expose separate front and rear PCMs
for this device as they cannot be controlled independently at the HW
level.

Lee

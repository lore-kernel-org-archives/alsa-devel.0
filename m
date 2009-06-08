From: kls.schlz@googlemail.com
Subject: Re: EMU 0404USB: Odd sample rate shown during playback.
Date: Mon, 08 Jun 2009 07:32:32 +0000
Message-ID: <001636c5a907c27277046bd13e2e@google.com>
References: <4A2CBCCA.7040704@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-2122.google.com (fg-out-2122.google.com [72.14.220.24])
	by alsa0.perex.cz (Postfix) with ESMTP id A73CF24450
	for <alsa-devel@alsa-project.org>;
	Mon,  8 Jun 2009 09:32:32 +0200 (CEST)
Received: by fg-out-2122.google.com with SMTP id 23so175357fge.44
	for <alsa-devel@alsa-project.org>; Mon, 08 Jun 2009 00:32:32 -0700 (PDT)
In-Reply-To: <4A2CBCCA.7040704@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>, Klaus Schulz <kls.schlz@googlemail.com>
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Clemens.

THX for dropping in.

On my M-Audio Transit though it remains 44.1 even though it says "async" at  
16/44.1 in the stream0 file.

Cheers
\Klaus

On Jun 8, 2009 9:24am, Clemens Ladisch <clemens@ladisch.de> wrote:
> Klaus Schulz wrote:

> > The EMU 0404 is running in async USB mode as you know. When looking at  
> the

> > stream parameters during playback the sample rate shown is always  
> slightly

> > below 44100 -- something like 44098 is shown.



> This is what "asynchronous" means: The computer's clock and the device's

> clock run independently from each other, so they can have slightly

> different speeds.





> Best regards,

> Clemens

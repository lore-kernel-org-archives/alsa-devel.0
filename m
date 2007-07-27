From: "Lee Revell" <rlrevell@joe-job.com>
Subject: Re: Hidden rate conversion, and Alsa configuration
Date: Fri, 27 Jul 2007 11:59:53 -0400
Message-ID: <75b66ecd0707270859q33f02d05la5160f3443dc9cc1@mail.gmail.com>
References: <200707161340.23503.gineera@aspect135.co.uk>
	<20070719142440.GA2467@localhost>
	<200707201333.38449.gineera@aspect135.co.uk>
	<200707271720.41278.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 57D47103850
	for <alsa-devel@alsa-project.org>;
	Fri, 27 Jul 2007 17:59:57 +0200 (CEST)
Received: by wa-out-1112.google.com with SMTP id m33so1078712wag
	for <alsa-devel@alsa-project.org>; Fri, 27 Jul 2007 08:59:53 -0700 (PDT)
In-Reply-To: <200707271720.41278.gineera@aspect135.co.uk>
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
To: Alan Horstmann <gineera@aspect135.co.uk>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 7/27/07, Alan Horstmann <gineera@aspect135.co.uk> wrote:
> Could you give pointers as to how to modify Alsa configuration so that rate
> conversion can never happen, as I would prefer to have an error accessing the
> sound card rather than unknown conversion, which in my use should never be
> neccesary anyway.

Simply open the hw device rather than the default, dmix, or plughw device.

Lee

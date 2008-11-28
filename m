From: "John Kacur" <jkacur@gmail.com>
Subject: Re: simplest volume control possible
Date: Fri, 28 Nov 2008 16:23:23 +0100
Message-ID: <520f0cf10811280723o4bfdbd1cr404008aa6993307f@mail.gmail.com>
References: <520f0cf10811280650x195e1dc5lf1239ade86fc7090@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.243])
	by alsa0.perex.cz (Postfix) with ESMTP id C011D246CC
	for <alsa-devel@alsa-project.org>; Fri, 28 Nov 2008 16:23:24 +0100 (CET)
Received: by rv-out-0708.google.com with SMTP id f25so1329760rvb.32
	for <alsa-devel@alsa-project.org>; Fri, 28 Nov 2008 07:23:23 -0800 (PST)
In-Reply-To: <520f0cf10811280650x195e1dc5lf1239ade86fc7090@mail.gmail.com>
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
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 28, 2008 at 3:50 PM, John Kacur <jkacur@gmail.com> wrote:
> I'm looking at the dapm.txt documentation, and I'm looking at the code
> in codecs like wm8753.c, and I'm thinking that all of this is
> tremendous overkill for the very simple codec I have. Basically I
> don't care about power, the thing can be powered on all the time. I
> put a one pulse on a gpio for volume up and a zero pulse on a gpio for
> volume down, 0 - 63 pulses though.
>
> Question, then, what would be an appropriate widget to use?
>

minor correction, a 1 pulse on a gpio for volume up, and a 1 pulse on
a different gpio for volume down.

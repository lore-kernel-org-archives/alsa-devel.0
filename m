From: "Jarkko Nikula" <jhnikula@gmail.com>
Subject: Re: [PATCH 1/3] asoc tlv320aic3x: revisit clock setup
Date: Fri, 25 Apr 2008 13:40:42 +0300
Message-ID: <bd7b27490804250340y629cc7e6s61b056dc6505f55a@mail.gmail.com>
References: <20080425091707.GA18452@buzzloop.caiaq.de>
	<s5hlk32l1v7.wl%tiwai@suse.de>
	<20080425093657.GC18558@buzzloop.caiaq.de>
	<bd7b27490804250255j5ed1ea14l1df4b3c1d91e1b7c@mail.gmail.com>
	<20080425101801.GE18558@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.250])
	by alsa0.perex.cz (Postfix) with ESMTP id AAA5424784
	for <alsa-devel@alsa-project.org>;
	Fri, 25 Apr 2008 12:40:43 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id c36so987668ana.80
	for <alsa-devel@alsa-project.org>; Fri, 25 Apr 2008 03:40:42 -0700 (PDT)
In-Reply-To: <20080425101801.GE18558@buzzloop.caiaq.de>
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
To: Daniel Mack <daniel@caiaq.org>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 25, 2008 at 1:18 PM, Daniel Mack <daniel@caiaq.org> wrote:

> On Fri, Apr 25, 2008 at 12:55:23PM +0300, Jarkko Nikula wrote:
> > Did you forgot to take into account doubled fsref below (from the first
> > version) when calculating codec_clk because now it is doubled earlier?
>
> Oops, yes, you're right. Sorry for that.
>
> Doesn't work for 64000 kHz since 48000 * 10 / 64000 = 7.5 and later
calculations => 7*2 / 5 - 2 = 2 - 2 but this might to work:

...
data = (fsref * 20) / rate;
if (rate < 64000)
    data /= 2;
data /= 5;
...


Jarkko

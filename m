From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: Re: [PATCH] hda: add SW_LINEOUT_INSERT support
Date: Fri, 17 Oct 2008 09:15:48 -0400
Message-ID: <48F89004.7090809@embeddedalley.com>
References: <48F7F600.3040706@embeddedalley.com> <s5hd4hz69ia.wl%tiwai@suse.de>
	<20081017103857.GA2546@sirena.org.uk>
	<48F8833D.8080301@embeddedalley.com>
	<20081017123928.GD2546@sirena.org.uk>
	<48F88ABD.3010905@embeddedalley.com>
	<20081017130504.GE2546@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from easi.embeddedalley.com (easi.embeddedalley.com [71.6.201.124])
	by alsa0.perex.cz (Postfix) with SMTP id 571682432E
	for <alsa-devel@alsa-project.org>;
	Fri, 17 Oct 2008 15:16:14 +0200 (CEST)
In-Reply-To: <20081017130504.GE2546@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: Takashi Iwai <tiwai@suse.de>, Dmitry Torokhov <dtor@mail.ru>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> On Fri, Oct 17, 2008 at 08:53:17AM -0400, Matthew Ranostay wrote:
> 
>> Well is generally only one HP out jack, but there can be several line-out
>> reported by the one instance(lineout_jack). I assume this isn't the correct usage.
> 
> Could you provide a bit more detail here?  Are you saying that the
> hardware has several line outputs and can report connection status but
> is unable to identify which of them is connected?
> 

Yep, just wondering if that is an incorrect way of using the jack abstraction layer.
As of yet we are only using this to confirm if an HP and Line Out is connected for use
in ALSA plugin, if there is the stream processing is turned off.

So basically if you plug into two or more line outs, each time you unplug a line out,
it will still send a event as if a line out was connected until all line outs are removed.

-Matt

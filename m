From: Daniel Mack <daniel@caiaq.de>
Subject: Re: usbaudio: Support for USB audio v2.0 devices
Date: Mon, 22 Feb 2010 18:50:27 +0100
Message-ID: <20100222175027.GM28972@buzzloop.caiaq.de>
References: <1266856137-26252-1-git-send-email-daniel@caiaq.de>
	<4B82C197.1050004@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 62FD910384F
	for <alsa-devel@alsa-project.org>; Mon, 22 Feb 2010 18:50:31 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4B82C197.1050004@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: =?utf-8?B?5bKp5LqVIOmahg==?= <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 22, 2010 at 06:40:39PM +0100, Clemens Ladisch wrote:
> Daniel Mack wrote:
> > I've been working on support for USB devices compliant to audio class
> > v2.0 and would like to share what I got.
> 
> Great!
> 
> Just out of curiousity: what device are you testing this with?

An XMOS eval kit. I have OSX/CoreAudio as reference which seems to have
a more or less complete support.

> > My first step was to clean up most of the existing descriptor parsers
> > by moving away from anonymous byte array access to real structs so we
> > can see which fields we're actually dereferencing.
> 
> Please use the structures in <linux/usb/audio.h>.

Gna. Haven't seen that before. Why are they there if no code actually
uses them?

I'll rework my patches then.

Thanks,
Daniel

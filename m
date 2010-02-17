From: James Courtier-Dutton <james.dutton@gmail.com>
Subject: Re: Latency of mixer reconfiguration
Date: Wed, 17 Feb 2010 20:34:17 +0000
Message-ID: <ad2655cb1002171234g4f73edd4j19c2f89bfc7bf567@mail.gmail.com>
References: <20100217181530.GA23152@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f173.google.com (mail-qy0-f173.google.com
	[209.85.221.173])
	by alsa0.perex.cz (Postfix) with ESMTP id EBA4B10388E
	for <alsa-devel@alsa-project.org>; Wed, 17 Feb 2010 21:34:20 +0100 (CET)
Received: by qyk4 with SMTP id 4so4847101qyk.8
	for <alsa-devel@alsa-project.org>; Wed, 17 Feb 2010 12:34:19 -0800 (PST)
In-Reply-To: <20100217181530.GA23152@tango.0pointer.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 17 February 2010 18:15, Lennart Poettering <mznyfn@0pointer.de> wrote:
> Heya!
>
> So, as some of you might know in PA we extend the abilities of the
> hardware volume control in software. Meaning that if a hw mixer
> control only allows a limited range or granularity of a volume scale
> or does not distuingish between channels then PA will configure the
> hardware to the next higher available setting of the real
> volume it wants to achieve, and then attenuates the PCM stream to
> compensate for the rest.
>
> This actually works quite well but there is a certain probelm with
> latency: i.e. the mixer setting will be applied at a slightly
> different time than the PCM attenuation.
>
> Now the question I have is, how should I best deal with this? I
> currently assume that mixer volume changes are basically instantaneous
> when I call the respective function of ALSA. But are they really? How
> big is the latency at max? Do we need an API to query it?
>
> Lennart
>

The latency is non-deterministic.
latency of the PCM stream is more predictable.
I am not sure how you might get around this problem.

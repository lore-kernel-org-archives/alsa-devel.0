From: "Soeren D. Schulze" <soeren.d.schulze@gmx.de>
Subject: Re: hda-intel (ALC889) - sound loops/repeats
 continuously, and general brokenness
Date: Thu, 21 Oct 2010 17:33:49 +0200
Message-ID: <4CC05D5D.7000206@gmx.de>
References: <4CBF45C0.5060903@juliano.info>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mailout-de.gmx.net [213.165.64.22])
	by alsa0.perex.cz (Postfix) with SMTP id BE4291038A9
	for <alsa-devel@alsa-project.org>;
	Thu, 21 Oct 2010 17:33:54 +0200 (CEST)
In-Reply-To: <4CBF45C0.5060903@juliano.info>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Juliano F. Ravasi" <ml@juliano.info>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 20.10.2010 21:40, Juliano F. Ravasi wrote:
>  Hello ALSA devs,
> =

> (Cc'ing alsa-devel since looks like it can be a driver problem/bug, but
> still unsure. Need some expert advice.)
> =

> I'm experiencing a lot of problems reproducing audio with an HD Audio
> "card" integrated on an Intel DX58SO mainboard. It happens only on this
> card, everything is Ok with another (USB) card.
> =

> The most visible problem is that `aplay` plays only a small fragment of
> audio (less than one second), then hangs and the card keeps reproducing
> that fragment continuously in a loop, until killed with Ctrl-C. `aplay
> -N` progresses, but each fragment repeats 3 times.

[...]

As a matter of accident, I reported a similar bug to the Ubuntu
bugtracker just 30 minutes afterwards:

http://bugs.launchpad.net/ubuntu/+source/linux/+bug/664138

The error is not as bad for me, but it might be related.


Thanks,

S=F6ren

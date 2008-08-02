From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: ultra small alsa library
Date: Sat, 02 Aug 2008 18:48:03 +0200
Message-ID: <87tze3tlbw.fsf@free.fr>
References: <b542c8b90808020738g76115165ve9d2d02a033706bf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp7-g19.free.fr (smtp7-g19.free.fr [212.27.42.64])
	by alsa0.perex.cz (Postfix) with ESMTP id AA390246CC
	for <alsa-devel@alsa-project.org>;
	Sat,  2 Aug 2008 18:48:05 +0200 (CEST)
In-Reply-To: <b542c8b90808020738g76115165ve9d2d02a033706bf@mail.gmail.com>
	(Marco Schuster's message of "Sat\, 2 Aug 2008 16\:38\:28 +0200")
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Marco Schuster <marco@harddisk.is-a-geek.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

"Marco Schuster" <marco@harddisk.is-a-geek.org> writes:

> what are the minimum prerequisites for using s-alsa (esp. kernel!)? with
> 2.6.24 and debian i got segfaults.
Hello Marco,

I'll leave others for the prerequisites.

But I can tell you I run alsa on a little smartphone with 64MBytes of memory,
with a graphical application taking 25MBytes at its start. I have no problems so
far running alsa to play songs / use my phone.

My hardware setup (mio a701 smartphone) :
 - RAM: 64 MB
 - CPU: XScale PXA272
 - Storage : SD card
 - Swap: none (poor SD card otherwise)

Sofware setup :
 - Base stolen from OPIE 4.3.1
 - custom fixes for the smartphone, nothing related to alsa

I hope that cheers you a bit about your configuration.

--
Robert

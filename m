From: Jesse Burt <genecide@comcast.net>
Subject: Re: No sound from usb on Motorola C350 cellphone
Date: Mon, 12 Nov 2007 17:29:06 -0500
Message-ID: <1194906547.12156.17.camel@headhunter>
References: <7c5010d60711120528u16bef715ua48f440c49d962d1@mail.gmail.com>
	<7c5010d60711120534l13376fc9gc71228ca84322ddc@mail.gmail.com>
	<47385A14.4000301@gmail.com>
	<7c5010d60711120555r28363e3ax8bb1efa33209cc8c@mail.gmail.com>
	<7c5010d60711120557yed3e6cdn357553022d11788c@mail.gmail.com>
	<47385FAE.9070408@gmail.com>  <20071112103947.0e3afc4b@jutz-gnto64>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from QMTA03.emeryville.ca.mail.comcast.net
	(qmta03.emeryville.ca.mail.comcast.net [76.96.30.32])
	by alsa0.perex.cz (Postfix) with ESMTP id 8D1402454A
	for <alsa-devel@alsa-project.org>; Mon, 12 Nov 2007 23:29:12 +0100 (CET)
In-Reply-To: <20071112103947.0e3afc4b@jutz-gnto64>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Giovanni Maruzzelli <gmaruzz.lists@gmail.com>
Cc: alsa-devel@alsa-project.org, "Alexander E. Patrakov" <patrakov@gmail.com>
List-Id: alsa-devel@alsa-project.org

Giovanni,

I agree with John, this sounds very interesting; I have been looking to
do something at least remotely related to this, but standalone (though
perhaps I've misunderstood the purpose of your software completely).
I've been searching for a way to use a host PC as a
handsfree/speakerphone for my v3/v3x via bluetooth. The closest I've
come is the software at:
http://wall4.soft.uni-linz.ac.at/_wiki/tiki-index.php?page=ProjectBluezHandsfree

...but I only once got it to partly work with my V3 (very little audio,
and all broken up) and no audio at all with my V3x.
It seems the links to the tarballs are dead though so if anyone wants
them I think I can find them somewhere on my computer.

I have tried sending the 'AT+MODE=8' command to my phone and it indeed
does trigger a change in the USB state: it disconnects and attempts to
reconnect, but fails.

Also I don't mean to flood the list with something that might be
considered offtopic so unless someone feels any of what I've said is
relevant this will be my first and last post.

Cheers,
Jesse Burt

On Mon, 2007-11-12 at 10:39 -0800, John Utz wrote:
> Hi All;
> 
> I think this is a totally fascinating thing and i hope it will be
> possible to make it work.....
> 
> onto the specifics
> 
> On Mon, 12 Nov 2007 19:14:06 +0500
> "Alexander E. Patrakov" <patrakov@gmail.com> wrote:
> 
> > Giovanni Maruzzelli wrote:
> > > Needs more info, tests?
> > 
> > If you can make the audio functionality work under Windows 2000 or XP
> > with the new (non-standard) driver, snoopy logs will be interesting.
> > Snoopy is available from http://www.wingmanteam.com/usbsnoopy/ or
> > (different version) http://sourceforge.net/projects/usbsnoop/
> > 
> 
> i am not staring at the USB code right now (it's on a different box),
> but i would think that one of the first things that you might need to
> uncover is the USB device string. It may be offered up as part of the
> device probe when it's attached (check in dmesg) or you may find it in
> a registry or .inf file on the windows file system after you install
> the drivers.
> 
> if it's a class compliant device, then it may just work once alsa get's
> taught about it (dont hold me to that, i am not looking at code)
> 
> however, as one of you alluded to, there may be an AT command that
> needs to get tickled to turn it on.
> 
> the other annoying thing to consider is that it may actually be probe
> and connected, but you havent yet figured out how to turn up the
> volume :-( (yes, that happens)
> 
> i'll be really curious about this, so please continue to share with
> the list....
> 
> tnx!
> 
> johnu
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

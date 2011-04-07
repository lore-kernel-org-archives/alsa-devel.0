From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: Conexant CX20585 recording does not work
Date: Thu, 07 Apr 2011 14:42:13 +0200
Message-ID: <4D9DB125.6010600@canonical.com>
References: <10033.91.152.175.130.1302179699.squirrel@go-nix.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id A91EF1038A0
	for <alsa-devel@alsa-project.org>;
	Thu,  7 Apr 2011 14:42:14 +0200 (CEST)
In-Reply-To: <10033.91.152.175.130.1302179699.squirrel@go-nix.ca>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Gabriel Schulhof <nix@go-nix.ca>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 2011-04-07 14:34, Gabriel Schulhof wrote:
> Hi!
>
> My mom has a laptop with the following sound card:
>
> lspci: 00:14.2 Audio device: ATI Technologies Inc SBx00 Azalia (Intel HDA)
> (rev 40)
>
> driver: snd_hda_intel
>
> alsamixer:
> Card: HDA ATI SB
> Chip: Conexant CX20585
>
> I can't record from this card no matter what I try. It seems that
> alsamixer has a lot of options:
>
> Mic B<Capture switch>
> Mic C<Capture switch>
> Mic E<Capture switch>
> Mic F<Capture switch>
> Capture<0% -- 100% slider>
> Analog Mic Boost<0 db -- 40 db slider with 10 db increment>
>
> I have tried to record from each mic in turn, I have tried the different
> boost levels (0 db - 40 db), but I have had no luck picking up anything. I
> have attached an external mic to the line-in, but no difference.
>
> When I say "I have tried to record" I mean that I logged into her
> computer, chose one of the mics from the above list, and then I told my
> mom to say something while looking at the input sound level indicator in
> the GNOME sound settings panel. On other computers, I have found this a
> sufficient indication of whether the mic works.
>
> Is this inability to record a known limitation of this sound card? If not,
> is there some special setting I have to modify to make it work?
>
> Please find attached the output from alsa-info.
>
> TIA for your help,

Please try the model quirk "hp-laptop". In Ubuntu that would be adding 
the line:

options snd-hda-intel model=hp-laptop

to the file /etc/modprobe.d/alsa-base.conf

I guess it's the same in Fedora. If it works, we'll create a quirk.

(Memo to self: You should really help out with that cxt5066 autoparser 
someday.)

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic

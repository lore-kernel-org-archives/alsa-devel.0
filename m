From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Conexant CX20585 recording does not work
Date: Sat, 9 Apr 2011 14:43:13 +0800
Message-ID: <BANLkTin80mX8ii0mA=VQP+NO5fDAVr0cyw@mail.gmail.com>
References: <10033.91.152.175.130.1302179699.squirrel@go-nix.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id 2444624481
	for <alsa-devel@alsa-project.org>;
	Sat,  9 Apr 2011 08:43:15 +0200 (CEST)
Received: by bwz10 with SMTP id 10so3618645bwz.38
	for <alsa-devel@alsa-project.org>; Fri, 08 Apr 2011 23:43:13 -0700 (PDT)
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
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2011/4/7 Gabriel Schulhof <nix@go-nix.ca>

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
> Mic B            <Capture switch>
> Mic C            <Capture switch>
> Mic E            <Capture switch>
> Mic F            <Capture switch>
> Capture          <0% -- 100% slider>
> Analog Mic Boost <0 db -- 40 db slider with 10 db increment>
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
>
>
>
you need to find a model which
1) support internal mic at 0x23
2) enable unsolicted mic event at mic jack 0x1b
3) enable unsolicted hp event at HP jack 0x19

cxt5066_capture_source has "Mic B" , "Mic C" , "Mic E" and "Mic F" for  0x1a
0x1b 0x1d 0x1e at node [audio selector] 0x17  and it cannot handle internal
mic at 0x23

cxt5066 has five connection at 0x14

    /* Node 14 connections: 0x17 0x18 0x23 0x24 0x27 */

but cxt20585 has only four connection

     0x17* 0x18 0x23 0x24

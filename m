From: "Gabriel Schulhof" <nix@go-nix.ca>
Subject: Re: Conexant CX20585 recording does not work
Date: Sat, 9 Apr 2011 15:36:55 +0300 (EEST)
Message-ID: <21142.91.152.175.130.1302352615.squirrel@go-nix.ca>
References: <10033.91.152.175.130.1302179699.squirrel@go-nix.ca>
	<BANLkTin80mX8ii0mA=VQP+NO5fDAVr0cyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fipsb01.cogeco.net (smtp1.cogeco.ca [216.221.81.28])
	by alsa0.perex.cz (Postfix) with ESMTP id DD48F1037FC
	for <alsa-devel@alsa-project.org>;
	Sat,  9 Apr 2011 14:37:00 +0200 (CEST)
In-Reply-To: <BANLkTin80mX8ii0mA=VQP+NO5fDAVr0cyw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi!

On Sat, April 9, 2011 09:43, Raymond Yau wrote:
> you need to find a model which
> 1) support internal mic at 0x23
> 2) enable unsolicted mic event at mic jack 0x1b
> 3) enable unsolicted hp event at HP jack 0x19
>
> cxt5066_capture_source has "Mic B" , "Mic C" , "Mic E" and "Mic F" for
> 0x1a
> 0x1b 0x1d 0x1e at node [audio selector] 0x17  and it cannot handle
> internal
> mic at 0x23
>
> cxt5066 has five connection at 0x14
>
>     /* Node 14 connections: 0x17 0x18 0x23 0x24 0x27 */
>
> but cxt20585 has only four connection
>
>      0x17* 0x18 0x23 0x24

With my absolutely untrained eye, it seems like I should be trying
"ideapad", "thinkpad", and "vostro". At least, those are the only places
in patch_conexant.c that seem to have anything about a "0x23" in them.
Thank you grep! :)

Of course, if anyone could cast a less untrained glance at the source and
give me some more models to try, then please!

TIA for your help,



Gabriel

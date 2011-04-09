From: "Gabriel Schulhof" <nix@go-nix.ca>
Subject: Re: Conexant CX20585 recording does not work
Date: Sat, 9 Apr 2011 13:15:22 +0300 (EEST)
Message-ID: <20582.91.152.175.130.1302344122.squirrel@go-nix.ca>
References: <10033.91.152.175.130.1302179699.squirrel@go-nix.ca>
	<BANLkTin80mX8ii0mA=VQP+NO5fDAVr0cyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fipsb03.cogeco.net (smtp.cogeco.net [216.221.81.25])
	by alsa0.perex.cz (Postfix) with ESMTP id 3992E103807
	for <alsa-devel@alsa-project.org>;
	Sat,  9 Apr 2011 12:15:31 +0200 (CEST)
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
[...]
> but cxt20585 has only four connection
>
>      0x17* 0x18 0x23 0x24

Unfortunately, I don't know which model supports this. [0] lists the
models, but it doesn't list addresses :(

Can somebody please help me pick a value for the "model" based on the
above info? I'm going to keep digging, and ultimately, I can try all
models, but that's a fairly painstaking procedure.

TIA,



Gabriel

[0]
http://www.mjmwired.net/kernel/Documentation/sound/alsa/HD-Audio-Models.txt

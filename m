From: Fausto Carvalho Marques SIlva <fausto@tse.gov.br>
Subject: Re: Alsa lib configure asoundlib.h
Date: Tue, 10 Jul 2007 17:28:08 -0300
Message-ID: <4693EBD8.10303@tse.gov.br>
References: <468D0AFA.20208@tse.gov.br> <s5hwsxd50fg.wl%tiwai@suse.de>	
	<s5h3azwl5p2.wl%tiwai@suse.de>	
	<61c0054e0707100805m446a1bf0xbd12d6da6d68fde6@mail.gmail.com>	
	<20070710160423.748e5cd6.AlsaUser@PragmaSoft.com>
	<61c0054e0707101322h1d554d9ax1a52a4ceaf8826f8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dexter.tse.gov.br (dexter.tse.gov.br [200.252.157.99])
	by alsa0.perex.cz (Postfix) with ESMTP id 40A321037F2
	for <alsa-devel@alsa-project.org>;
	Tue, 10 Jul 2007 22:31:44 +0200 (CEST)
In-Reply-To: <61c0054e0707101322h1d554d9ax1a52a4ceaf8826f8@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Paul Kavan <pkavan@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Paul Kavan wrote:

>
>     Perhaps you just need to run the "strip" tool to remove symbols
>     from the
>     Object file ?
>
>
> I am really new to this. Could you tell me how to do that?
>
strip <dynamic-object-file> or
strip libasound.so

Fausto Carvalho Marques Silva

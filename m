From: Gabriel Johnson <johnsoga@gmail.com>
Subject: Re: dmix and mmap
Date: Wed, 6 May 2009 08:20:19 -0500
Message-ID: <bb6204720905060620p7faaeed9k10b3dd04a93d63a8@mail.gmail.com>
References: <bb6204720904300810ma174b6cn825f8565c0b694c0@mail.gmail.com>
	<20090430151301.GA27605@sirena.org.uk>
	<bb6204720904301229q3b0b93eao28563ec7bdef73cb@mail.gmail.com>
	<20090501113240.GF6975@sirena.org.uk>
	<ed82fe3e0905040957l13e53319j57ddd1c1de902f92@mail.gmail.com>
	<20090505113242.GB27386@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yx-out-1718.google.com (yx-out-1718.google.com [74.125.44.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 64A51246DC
	for <alsa-devel@alsa-project.org>;
	Wed,  6 May 2009 15:20:21 +0200 (CEST)
Received: by yx-out-1718.google.com with SMTP id 6so61917yxn.2
	for <alsa-devel@alsa-project.org>; Wed, 06 May 2009 06:20:20 -0700 (PDT)
In-Reply-To: <20090505113242.GB27386@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: alsa-devel@alsa-project.org, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org

Thanks for the help.  I ended up using Takashi Iwai's
dma_mmap_coherent patch and then added the mmap callback to my driver.
 So far it seems to be working.

On Tue, May 5, 2009 at 6:32 AM, Mark Brown <broonie@sirena.org.uk> wrote:
> On Mon, May 04, 2009 at 11:57:20AM -0500, Timur Tabi wrote:
>
>> The PowerPC MPC8610 drivers enable mmap support, and it seems to work,
>> but that chip has a coherent MMU. =A0I've never done a definitive test
>> that it works, though. =A0What's the easiest way to test mmap?
>
> If you had issues they'd be fairly obvious in the audio stream.
>

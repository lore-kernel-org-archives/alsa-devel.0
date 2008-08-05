From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [PATCH 10/11] wss_lib: use wss detection code
 instead of ad1848 one
Date: Tue, 05 Aug 2008 05:42:10 +0200
Message-ID: <4897CC12.1010600@keyaccess.nl>
References: <20080731211047.2c06bfad.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.groni1.gr.home.nl (smtpq1.groni1.gr.home.nl
	[213.51.130.200])
	by alsa0.perex.cz (Postfix) with ESMTP id 0C90924539
	for <alsa-devel@alsa-project.org>;
	Tue,  5 Aug 2008 05:42:14 +0200 (CEST)
In-Reply-To: <20080731211047.2c06bfad.krzysztof.h1@poczta.fm>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: Takashi Iwai <tiwai@suse.de>, Alsa-devel <alsa-devel@alsa-project.org>, Rene Herman <rene.herman@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 31-07-08 21:10, Krzysztof Helt wrote:

> From: Krzysztof Helt <krzysztof.h1@wp.pl>
> 
> Use the wss detection code and kill the ad1848 library.
> The library is fully assimilated into the new wss library.
> 
> This required reworking of the AD1848 family code
> so the code is changed to correctly detect chips from
> the AD1848 and CS4231 families.
> 
> I have tested it on following cards:
> Gallant SC-6600 (codec: AD1848, driver: snd-sc6600)
> SoundScape VIVO/90 (codec: AD1845, driver: snd-sscape)
> SG Waverider (codec: CS4231A, driver: Rene Herman's snd-galaxy)
> Opti930 (codec: built-in - CS4231 compatible, driver: snd-opti93x)
> Opti931 (codec: built-in - CS4231 compatible, driver: snd-opti93x)
> Gallant SC-70P (chip/codec: CS4237B, driver: snd-cs4236)
> Audio Plus 3D (chip/codec: CMI8330A, driver: snd-cmi8330)
> Dell Latitude CP (chip/codec: cs4236, driver snd-cs4232)
> 
> Sound playback and recording works on all these cards.
> 
> Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
> ---
> Changes since previous version:
> 
> 1. Remove AD1848_LIB symbol from the Kconfig.
> 2. Actually delete ad1848.h and ad1848_lib.c.
> 3. Leave different description for opti82x-ad1848
>    and opti 92x-cs4231 drivers (they are still
>    separated drivers).
> 4. One less assigment in if.

Acked-by: Rene Herman <rene.herman@gmail.com>

Rene.

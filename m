From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [PATCH] es1968: fix jitter on some maestro cards
Date: Mon, 14 Apr 2008 12:43:45 +0200
Message-ID: <48033561.3070309@keyaccess.nl>
References: <20080329234943.GA2899@slappy>	<47F164AB.5040009@keyaccess.nl>
	<s5habjwhh1p.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.tilbu1.nb.home.nl (smtpq2.tilbu1.nb.home.nl
	[213.51.146.201])
	by alsa0.perex.cz (Postfix) with ESMTP id 682E32438F
	for <alsa-devel@alsa-project.org>;
	Mon, 14 Apr 2008 12:40:58 +0200 (CEST)
In-Reply-To: <s5habjwhh1p.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA devel <alsa-devel@alsa-project.org>, Andreas Mueller <andreas@stapelspeicher.org>, linux-kernel@vger.kernel.org, MatzeBraun@gmx.de
List-Id: alsa-devel@alsa-project.org

On 14-04-08 12:22, Takashi Iwai wrote:

> At Tue, 01 Apr 2008 00:24:43 +0200,
> Rene Herman wrote:
>> On 30-03-08 00:49, Andreas Mueller wrote:
>>
>>> This patch suppresses jitter on several Maestro cards in stereo mode
>>> (ALSA of course).
>>>
>>> The patch is also incorporated in the *BSD drivers where I "ported" it from.
>>> I am barely used to driver-development so please take a look (esp. the channel
>>> parameters), nevertheless it completely works for me.
>>>
>>> Without this patch most of the stereo audio gets out of sync and really
>>> distorted (oss-emulation with mplayer at 48000khz worked somehow).
>>>
>>> CCed to those listed in the .c file.
>> Added the alsa-devel list (and re-attached the patch). My TerraTec DMX (ESS 
>> Canyon3D, ES1970MS-3D) doesn't need this but doesn't seem to suffer from it 
>> either. Otherwise no idea about this.
> 
> This should depend on the sample rate you use.  48k would work without
> the patch.

Just to be clear archive-wise -- on this Canyon3D, so does 44100.

> Anyway, I applied it to ALSA tree now.  Thanks.

Rene.

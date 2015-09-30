From: Panu Matilainen <pmatilai@laiskiainen.org>
Subject: Re: Zoom R16/24 playback slient
Date: Wed, 30 Sep 2015 12:45:45 +0300
Message-ID: <560BAF49.60701@laiskiainen.org>
References: <alpine.DEB.2.02.1509292156390.6263@lnxricardw1.se.axis.com>
 <560B8481.1080304@laiskiainen.org>
 <alpine.DEB.2.02.1509300955510.12892@lnxricardw1.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from homiemail-a58.g.dreamhost.com (sub5.mail.dreamhost.com
 [208.113.200.129])
 by alsa0.perex.cz (Postfix) with ESMTP id 5B1D6265AF0
 for <alsa-devel@alsa-project.org>; Wed, 30 Sep 2015 11:45:51 +0200 (CEST)
In-Reply-To: <alpine.DEB.2.02.1509300955510.12892@lnxricardw1.se.axis.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ricard Wanderlof <ricard.wanderlof@axis.com>
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 09/30/2015 11:05 AM, Ricard Wanderlof wrote:
>
> On Wed, 30 Sep 2015, Panu Matilainen wrote:
[...]
>> Another finding from my last round in the spring I do remember clearly,
>> is that enabling both the input and output interfaces makes things hang
>> up (timeouts and nothing really works). But if you disable the input
>> interface and enable the output interface, you get an apparently working
>> playback stream. Only no sound comes out. If you disable the output and
>> enable input, capture itself works fine.
>
> Ok, thanks for that tidbit, I'd read about problems with simulatenous
> capture and playback in previous threads; I thought perhaps (hopefully...)
> the only remaining issue was the silent playback.

Forgot to clarify this: I actually thought the silent playback was the 
only remaining issue when submitting the patch, but later realized I 
only ever had one of the interfaces enabled at a time to avoid any 
side-effects, and apparently never bothered to check with both since the 
playback was not really working anyway.

	- Panu -

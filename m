From: Rene Herman <rene.herman@gmail.com>
Subject: Re: ALSA C++ API
Date: Wed, 19 Sep 2007 14:52:15 +0200
Message-ID: <46F11B7F.90403@gmail.com>
References: <46F032BE.4090301@trn.iki.fi>	<46F08F9A.4040309@gmail.com>
	<s5habrisvdj.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.groni1.gr.home.nl (smtpq2.groni1.gr.home.nl
	[213.51.130.201])
	by alsa0.perex.cz (Postfix) with ESMTP id 98029103819
	for <alsa-devel@alsa-project.org>;
	Wed, 19 Sep 2007 14:53:21 +0200 (CEST)
In-Reply-To: <s5habrisvdj.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, =?ISO-8859-15?Q?Lasse_K=E4rkk=E4inen?= <tronic+8nhy@trn.iki.fi>
List-Id: alsa-devel@alsa-project.org

On 09/19/2007 02:16 PM, Takashi Iwai wrote:

> At Wed, 19 Sep 2007 04:55:22 +0200,
> Rene Herman wrote:
>> On 09/18/2007 10:19 PM, Lasse K=E4rkk=E4inen wrote:
>>
>>> Even though I got no replies to my original announcement, here is a new
>>> version that wraps hw and sw params completely, has a macro for checking
>>> ALSA C function return values (throws alsa::error) and uses different
>>> naming style (similar to the C++ standard library). It is better
>>> documented now, too.
>>>
>>> The code is now largely generated with macros, so it isn't very readabl=
e =

>>> anymore :/
>> It's C++ -- what's new? :\
> =

> C++ isn't unreadable unless you use template :)

And unless you use function and/or operator overloading, or exceptions, or =

well, any C++ feature really.

I'll admit that by now my C++ is becoming fairly historical (I'm from befor=
e =

the namespace thing...) but C++ very much by design has this major "behind =

your back" thing going which often means that it stays readable only as lon=
g =

as you don't actually _have_ to read it at any level of detail.

Well -- such is my impression. I did look at what was posted, and it didn't =

look too scary, just header mapping to libasound directly. If (other) C++ =

programmers would confirm this is useful, perhaps something for the main =

ALSA distribution?

Rene.

From: Reimundo Heluani <rheluani@gmail.com>
Subject: Re: mic on macbook air
Date: Mon, 27 Sep 2010 13:40:34 -0300
Message-ID: <AANLkTikbkubbhOnc0hCRmWRv5H6vqQTRjE6afmmJ48t=@mail.gmail.com>
References: <1285540323.2205.11.camel@vino> <s5hvd5rxncg.wl%tiwai@suse.de>
	<4CA0C81E.5030103@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f172.google.com (mail-qy0-f172.google.com
	[209.85.216.172])
	by alsa0.perex.cz (Postfix) with ESMTP id 5F79324371
	for <alsa-devel@alsa-project.org>;
	Mon, 27 Sep 2010 18:40:43 +0200 (CEST)
Received: by qyk1 with SMTP id 1so5923725qyk.17
	for <alsa-devel@alsa-project.org>; Mon, 27 Sep 2010 09:40:42 -0700 (PDT)
In-Reply-To: <4CA0C81E.5030103@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Justin P. Mattock" <justinmattock@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

As far as I know I wrote the only patch for macbook air 2,1 that
shipped with 2.6.34 but that was for the internal speaker only. I
could never get the mic going.

Cheers,

R.

On Mon, Sep 27, 2010 at 1:36 PM, Justin P. Mattock
<justinmattock@gmail.com> wrote:
> On 09/27/2010 07:39 AM, Takashi Iwai wrote:
>>
>> At Mon, 27 Sep 2010 00:32:03 +0200,
>> Reimundo wrote:
>>>
>>> Hello list, from time to time I spend some time trying to get the mic
>>> working on a Macbook air 2,1. I tried looking at the relevant info from
>>> the corresponding kernel extensions on mac os X. The codec has =A0"Vend=
or
>>> Id: 0x10ec0885" so the relevant part of the info.plist on mac os X reads
>>>
>>> <dict>
>>> <key>MicAttributes</key>
>>> <integer>28</integer>
>>> <key>MicInfo</key>
>>> <string>Sampled on rising edge</string>
>>> <key>NodeID</key>
>>> <integer>39</integer>
>>> <key>PinConfigDefault</key>
>>> <integer>2426405136</integer>
>>> </dict>
>>>
>>> Which tells me nothing. In particular I don't have a node 0x27=3D39 (at
>>> least not that hda-analyzer sees) so it's not surprising that if I send
>>> the corresponding verbs to set_config_default I don't get anything.
>>> Also, I don't see how setting the pinconfigdefault could affect my not
>>> having the mic working (anyway I tried setting those pinconfigdefaults
>>> that put the node as a fixed mic on all nids 0x19-0x1c to no avail)
>>>
>>> As for the sampled on rising edge, I don't know how to use this info.
>>> any ideas?
>>
>> Justin Mattock made once some patches for MacBookAir, but they are
>> pending because no one tested yet.
>>
>> Justin, could you repost the patches (rebase if needed) for testing
>> again?
>>
>>
>> thanks,
>>
>> Takashi
>>
>
>
> Sure I can rebase them... but there's no guarantee that they work...
> from what I remember the mic on the macbookAir is not shown with the codec
> file so you might have to change the pins around.
>
> Justin P. Mattock
>

From: "tet" <teteros@teknik.io>
Subject: Re: [alsa-plugins-1.17] Regression in JACK plugin
Date: Tue, 23 Oct 2018 17:04:32 +0000
Message-ID: <4b6e162e84e9dc1b559b60ae13f47e02@teknik.io>
References: <f69dd23e-65c1-9810-ede6-88c7d9c03560@perex.cz>
 <4372b03f-7669-092a-1646-9d270de35a16@perex.cz>
 <ffc0874e-79c9-2d65-8cd9-a93ca8fa2381@perex.cz>
 <be1e30c7b7f493d0235a135964a9a9d3@teknik.io>
 <400daefc94cf6e5267055a0b6e96f1db@teknik.io>
 <b8d385caef38ff8f27506211fe3c5f1f@teknik.io>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.teknik.io (mail.teknik.io [5.79.72.163])
 by alsa0.perex.cz (Postfix) with ESMTP id 10E98267546
 for <alsa-devel@alsa-project.org>; Tue, 23 Oct 2018 19:04:32 +0200 (CEST)
In-Reply-To: <f69dd23e-65c1-9810-ede6-88c7d9c03560@perex.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

You're right, it was the new 50-jack.conf bundled in new version.
It just happened my local pcm was also named "jack"
which indeed conflicts with system 50-jack.conf and had to be updated.

Renaming local pcm statements to avoid conflicts with system ones solved it.
Cheers!

Tet.

October 23, 2018 5:43 PM, "Jaroslav Kysela" <perex@perex.cz> wrote:

> Dne 23.10.2018 v 18:30 tet napsal(a):
> 
>> Sadly, still getting Unknown field playback_ports with f47466 reverted on alsa-plugins.git master.
> 
> I see it now:
> 
> There was added 50-jack.conf file in the newer plugins, so I think that
> your config just override this global config (but it only overrides the
> type, the rest is kept). Try to put only these lines to your ~/.asoundrc:
> 
> -----
> pcm.!default {
> @func getenv
> vars [ PCM ]
> default "plug:jack"
> }
> -----
> 
> Jaroslav
> 
>> October 23, 2018 5:09 PM, "Jaroslav Kysela" <perex@perex.cz> wrote:
>> 
>>> Dne 23.10.2018 v 17:43 tet napsal(a):
>> 
>> alsa-lib is indeed 1.1.7 and the line number is 1286 in the err, apologies I've had the wrong lib
>> checked out when sending.
>> 
>> I've now ran git bisect and commit 24db7f5 is the earliest buildable alsa-plugins commit with the
>> regression.
>> To recap I have alsa-lib-1.17 and alsa-plugins-git v1.1.6.r4.24db7f5-1
>> 
>> $ aplay test.wav
>> ALSA lib pcm_plug.c:1286:(_snd_pcm_plug_open) Unknown field playback_ports
>> aplay: main:828: audio open error: Invalid argument
>> 
>> Sorry again for the confusion.
>>> Thanks. Could you give a short test with latest when you revert only
>>> f4746667a4a2490f17c2a82b6f421bc3c9bd6de8 ?
>>> 
>>> Jaroslav
>> 
>> October 23, 2018 3:44 PM, "Jaroslav Kysela" <perex@perex.cz> wrote:
>> 
>> Dne 23.10.2018 v 15:19 tet napsal(a):
>> 
>> Hi, after updating to alsa-plugins-1.17 ALSA throws:
>> "ALSA lib pcm_plug.c:1273:(_snd_pcm_plug_open) Unknown field playback_ports
>> The line number does not match to the latest sources:
>> 
>> https://github.com/alsa-project/alsa-lib/blob/master/src/pcm/pcm_plug.c#L1286
>> 
>> What is version of your alsa library?
>> 
>> Jaroslav
>> 
>> My ~/.asourdrc is working in 1.16 and it does not look like the syntax changed for the plugin when
>> looking at the readme.
>> 
>> pcm.jack {
>> type plug slave.pcm {
>> type jack
>> capture_ports {
>> 0 system:capture_1
>> 1 system:capture_1
>> }
>> playback_ports {
>> 0 system:playback_1
>> 1 system:playback_2
>> }
>> }
>> hint.description "JACK Audio Kit"
>> }
>> pcm.!default {
>> @func getenv
>> vars [ PCM ]
>> default jack
>> }
>> 
>> Any ideas?
>> 
>> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel@alsa-project.org
>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>> --
>> Jaroslav Kysela <perex@perex.cz>
>> Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
>> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel@alsa-project.org
>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>>> --
>>> Jaroslav Kysela <perex@perex.cz>
>>> Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
>>> _______________________________________________
>>> Alsa-devel mailing list
>>> Alsa-devel@alsa-project.org
>>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 
> --
> Jaroslav Kysela <perex@perex.cz>
> Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

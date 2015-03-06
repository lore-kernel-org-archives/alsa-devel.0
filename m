From: =?ISO-8859-1?Q?Ingo=20Br=FCckl?= <ib@wupperonline.de>
Subject: Re: [PATCH] ALSA: hda - Make path_has_mixer() tristate
Date: Fri, 06 Mar 2015 12:07:56 +0100
Message-ID: <54f98aed.2e0f31a7.bm001@wupperonline.de>
References: <s5h7fuu5rcm.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moutD.wup.tal.de (moutd.wup.tal.de [213.240.144.30])
 by alsa0.perex.cz (Postfix) with ESMTP id 54910265AFB
 for <alsa-devel@alsa-project.org>; Fri,  6 Mar 2015 12:10:17 +0100 (CET)
In-Reply-To: <s5h7fuu5rcm.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, superquad.vortex2@gmail.com, david.henningsson@canonical.com
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote on Fri, 06 Mar 2015 11:54:01 +0100:

> At Fri, 06 Mar 2015 11:20:22 +0100,
> David Henningsson wrote:
>>
>> On 2015-03-06 10:57, Ingo Br=FCckl wrote:
>> > Takashi Iwai wrote on Fri, 06 Mar 2015 10:38:49 +0100:
>> >
>> >> Even if you try parsing the topology at first with ignoring 0x15,
>> >> you'll need to add the path over 0x15 manually back to the
>> >> information.  Otherwise it can't work.
>> >
>> > Why can't it work? I'm not going to use the speaker.
>>
>> There is no known hardware that has an speaker with no connection to it
>> (and it would be a BIOS error if there was one), so it is not a priority
>> (perhaps not even of interest) of the driver to support it.
>> Especially not as the option of using e g hdajackretask [1] to disable
>> the speaker permanently is an easier and better way than starting to
>> mess around with the connections and paths manually.

> Right.  The big difference is "not using" and "disabling".  The former
> is user's decision, but without telling the driver to disable the
> functionality, the driver must still assume that it might be used in
> future.

Thank you very much for this explanation. As a simple user, not being deep
into hardware and driver internals, I wasn't aware of that difference.

> OTOH, the latter can be achieved easily by changing the pin default
> configuration

Fine, if just someone could please advise what to do (hdajackretask isn't
an option, no GUI, only console access).

Ingo

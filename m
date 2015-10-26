From: George Gugulea <gugulea@gmail.com>
Subject: Re: No sound after suspend-to-ram
Date: Mon, 26 Oct 2015 11:00:43 +0200
Message-ID: <CALcwt_Cd=Fquq8pz4uQuC0r-4_DJo0kTLt-mupDZb=ynGM5Ahw@mail.gmail.com>
References: <CALcwt_Acar7dhMHtEo9PtSi+RBcpXXDcQTNHZr-CEfNYhhWmRA@mail.gmail.com>
 <s5hh9ljj5nd.wl-tiwai@suse.de>
 <CALcwt_DPaX1-oBw6gVUT85bFLUKeQGcv=M9aCBHsHD=+eu_bVA@mail.gmail.com>
 <s5hsi52ujmp.wl-tiwai@suse.de>
 <6FAB7C47BCF00940BB0999A99BE3547A17A236B9@RTITMBSV09.realtek.com.tw>
 <CALcwt_BakjANwqurkEkywkFTiNUd3WcmJFn1tovM5AVnF7XXUA@mail.gmail.com>
 <s5hr3kkaf7z.wl-tiwai@suse.de>
 <6FAB7C47BCF00940BB0999A99BE3547A17A237A0@RTITMBSV09.realtek.com.tw>
 <s5h4mhe9k77.wl-tiwai@suse.de>
 <6FAB7C47BCF00940BB0999A99BE3547A17A237D4@RTITMBSV09.realtek.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf0-f47.google.com (mail-lf0-f47.google.com
 [209.85.215.47])
 by alsa0.perex.cz (Postfix) with ESMTP id 635532612C6
 for <alsa-devel@alsa-project.org>; Mon, 26 Oct 2015 10:00:44 +0100 (CET)
Received: by lffv3 with SMTP id v3so139746665lff.0
 for <alsa-devel@alsa-project.org>; Mon, 26 Oct 2015 02:00:44 -0700 (PDT)
In-Reply-To: <6FAB7C47BCF00940BB0999A99BE3547A17A237D4@RTITMBSV09.realtek.com.tw>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kailang <kailang@realtek.com>
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I will test the patch on my system as well.

On Mon, Oct 26, 2015 at 9:45 AM, Kailang <kailang@realtek.com> wrote:
>
> Attach is the patch.
>
>> -----Original Message-----
>> From: Takashi Iwai [mailto:tiwai@suse.de]
>> Sent: Monday, October 26, 2015 3:13 PM
>> To: Kailang
>> Cc: George Gugulea; alsa-devel@alsa-project.org
>> Subject: Re: [alsa-devel] No sound after suspend-to-ram
>>
>> On Mon, 26 Oct 2015 08:00:20 +0100,
>> Kailang wrote:
>> >
>> > Hi Takashi,
>> >
>> >         [ALC275_FIXUP_DELL_XPS] = {
>> >                 .type = HDA_FIXUP_VERBS,
>> >                 .v.verbs = (const struct hda_verb[]) {
>> >                         /* Enables internal speaker */
>> >                         {0x20, AC_VERB_SET_COEF_INDEX, 0x1f},
>> >                         {0x20, AC_VERB_SET_PROC_COEF, 0x00c0},
>> >                         {0x20, AC_VERB_SET_COEF_INDEX, 0x30},
>> >                         {0x20, AC_VERB_SET_PROC_COEF, 0x00b1},
>> >                         {}
>> >                 }
>> >         },
>> >
>> > Could I put code as upper? Was it enter to initial state?
>> > I think it should be execute atfter resume back. Right?
>>
>> Yes, these are performed at resume.  But the COEF stuff needs
>> a bit care since it's written in multiple places.  If you can
>> cook up the patch, I can check it hda-emu, too.
>>
>>
>> thanks,
>>
>> Takashi
>>
>> ------Please consider the environment before printing this e-mail.
>>



-- 
gg

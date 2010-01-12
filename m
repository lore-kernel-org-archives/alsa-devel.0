From: Chris Clayton <chris2553@googlemail.com>
Subject: Re: No CD audio with kernel 2.6.32.3
Date: Tue, 12 Jan 2010 19:11:02 +0000
Message-ID: <c6b1100b1001121111r128c5808v9fcfbb7eac126924@mail.gmail.com>
References: <c6b1100b1001111251pb33f11atf5131228de6dc90d@mail.gmail.com>
	<s5hr5pv64je.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.157])
	by alsa0.perex.cz (Postfix) with ESMTP id A4C1B10383B
	for <alsa-devel@alsa-project.org>; Tue, 12 Jan 2010 20:11:03 +0100 (CET)
Received: by fg-out-1718.google.com with SMTP id 19so243531fgg.2
	for <alsa-devel@alsa-project.org>; Tue, 12 Jan 2010 11:11:03 -0800 (PST)
In-Reply-To: <s5hr5pv64je.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi,

Yes, that was it. Thanks for your help.

Chris

2010/1/12 Takashi Iwai <tiwai@suse.de>:
> At Mon, 11 Jan 2010 20:51:57 +0000,
> Chris Clayton wrote:
>>
>> Hi,
>>
>> Please cc me on any reply - I'm not subscribed.
>>
>> Except for CD audio, sound is working fine on my new HP G61 laptop
>> with kernel 2.6.32.3. I can play CD audio fine in Windows.
>>
>> IIRC, on my (very) old Dell laptop, alsamixer showed a CD audio
>> device, but that's not the case on the G61. I have asla built as
>> modules.
>
> Recent laptops have usually no analog CD connection, and yours is
> likely such one. =A0Most CD players have CDDA mode to extract the CD
> data and play it back, so use it.
>
>
> HTH,
>
> Takashi
>



-- =

No, Sir; there is nothing which has yet been contrived by man, by which
so much happiness is produced as by a good tavern or inn - Doctor Samuel
Johnson

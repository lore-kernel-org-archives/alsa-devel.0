From: =?UTF-8?Q?Andrej_Krut=C3=A1k?= <dev@andree.sk>
Subject: Re: [PATCH v2 7/9] ALSA: line6: Allow processing of
	raw incoming messages
Date: Tue, 30 Aug 2016 16:35:16 +0200
Message-ID: <CAFnc+wUvmcuFDHbFyhh-ytN=uqYNW4Ju2KPRBQZPLBTihkur8w@mail.gmail.com>
References: <1470942147-19848-1-git-send-email-dev@andree.sk>
 <1471558839-14120-1-git-send-email-dev@andree.sk>
 <1471558839-14120-8-git-send-email-dev@andree.sk>
 <s5hk2f62omt.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf0-f53.google.com (mail-lf0-f53.google.com
 [209.85.215.53])
 by alsa0.perex.cz (Postfix) with ESMTP id 52389266C95
 for <alsa-devel@alsa-project.org>; Tue, 30 Aug 2016 16:35:38 +0200 (CEST)
Received: by mail-lf0-f53.google.com with SMTP id b199so15328757lfe.0
 for <alsa-devel@alsa-project.org>; Tue, 30 Aug 2016 07:35:38 -0700 (PDT)
In-Reply-To: <s5hk2f62omt.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Stefan Hajnoczi <stefanha@gmail.com>, grabner@icg.tugraz.at, perex@perex.cz
List-Id: alsa-devel@alsa-project.org

>> -     for (;;) {
>> -             done =
>> -                 line6_midibuf_read(mb, line6->buffer_message,
>> -                                    LINE6_MESSAGE_MAXLEN);
>> +             for (;;) {
>> +                     done =
>> +                             line6_midibuf_read(mb, line6->buffer_message,
>> +                                             LINE6_MESSAGE_MAXLEN);
>>
>> -             if (done == 0)
>> -                     break;
>> +                     if (done == 0)
>> +                             break;
>>
>> -             line6->message_length = done;
>> -             line6_midi_receive(line6, line6->buffer_message, done);
>> +                     line6->message_length = done;
>> +                     line6_midi_receive(line6, line6->buffer_message, done);
>>
>> +                     if (line6->process_message)
>> +                             line6->process_message(line6);
>> +             }
>> +     } else {
>>               if (line6->process_message)
>>                       line6->process_message(line6);
>>       }
>
> Both if and else run the same code (line6->process_message) here at
> the end.  That is, this can be outside the if block.
>

Nope, the first one is done in a loop...

> Also, the patch should be also before the actual usage, i.e. patch 5.
>

Ack.


-- 
Andrej

From: Grant Diffey <gdiffey@gmail.com>
Subject: Re: [PATCH 0/6] snd-usb endpoint rework, version 7
Date: Fri, 13 Apr 2012 11:39:04 +1000
Message-ID: <CACckToU+zq2jrPFRJmYGA05REtfPkRjf05JqiGY+bSyDkk=p+w@mail.gmail.com>
References: <1334231475-20980-1-git-send-email-zonque@gmail.com>
	<CACckToUX5iLjbdtjsEFOPk1uBw63EBROe=bj9qokaczB6P5LrQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f51.google.com (mail-wg0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 4B5EB10B8E2
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Apr 2012 03:42:25 +0200 (CEST)
Received: by wgbed3 with SMTP id ed3so1877857wgb.20
	for <alsa-devel@alsa-project.org>; Thu, 12 Apr 2012 18:39:04 -0700 (PDT)
In-Reply-To: <CACckToUX5iLjbdtjsEFOPk1uBw63EBROe=bj9qokaczB6P5LrQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: tiwai@suse.de, blablack@gmail.com, alsa-devel@alsa-project.org, clemens@ladisch.de, linuxaudio@showlabor.de
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 13, 2012 at 9:59 AM, Grant Diffey <gdiffey@gmail.com> wrote:

> On Thu, Apr 12, 2012 at 9:51 PM, Daniel Mack <zonque@gmail.com> wrote:
>
>> Here's the 7th iteration of patches that reimplement the streaming logic
>> of
>> the ALSA USB audio driver.
>>
>> There were some bugs reportes by Felix and Grant, which have been
>> resolved.
>>
>> More testing is definitely important, but maybe the code will get a wider
>> test coverage when merged to the development tree?
>>
>
> So I've also tested this against the current -rt head and can report that
> it solves the clicking problem with playback there as well.
>
> Grant.
>


so dumb question...

is setting a sane set of alsa controls a problem for the driver or
userspace/distributions?

the problem is.

if all volumes are max on module insert. the ftu is essentially unusable
untill they're corrected

and there's no event for device removal (you don't eject a soundcard)


A script like this:

*

#!/bin/bash
i=0
j=0
for i in $(seq 8); do
        for j in $(seq 8); do
                if [ "$i" != "$j" ]; then
                        amixer -c Ultra set "DIn$i - Out$j" 0% > /dev/null
                else
                        amixer -c Ultra set "DIn$i - Out$j" 100% > /dev/null
                fi
                amixer -c Ultra set "AIn$i - Out$j" 0% > /dev/null
        done
done

*Sets the internal mixer to a 1:1 mapping to outputs (so each input
corresponds to each output)


Thoughts?

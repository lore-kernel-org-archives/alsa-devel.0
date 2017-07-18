From: Fulup Ar Foll <fulup.arfoll@iot.bzh>
Subject: Re: Reset to clean state after
 snd_ctl_add_integer_elem_set ?
Date: Tue, 18 Jul 2017 13:26:01 +0200
Message-ID: <fce8362a-04d4-a2f7-33b1-0660ff44b3c8@iot.bzh>
References: <5e7c39f0-6eeb-4ef6-44f9-c281533f08a3@iot.bzh>
 <5fcd8cd2-a3b9-2384-66ec-99c69d5f8746@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf0-f54.google.com (mail-lf0-f54.google.com
 [209.85.215.54])
 by alsa0.perex.cz (Postfix) with ESMTP id B3F3C267121
 for <alsa-devel@alsa-project.org>; Tue, 18 Jul 2017 13:26:05 +0200 (CEST)
Received: by mail-lf0-f54.google.com with SMTP id t72so11070091lff.1
 for <alsa-devel@alsa-project.org>; Tue, 18 Jul 2017 04:26:05 -0700 (PDT)
In-Reply-To: <5fcd8cd2-a3b9-2384-66ec-99c69d5f8746@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Clement,

This is more or less what I have todo today. Nevertheless I do not 
understand how "alsactl init" which says in help "initialize driver to a 
default state" does not do the job.

Fulup

On 18/07/17 13:03, Clemens Ladisch wrote:
> Fulup Ar Foll wrote:
>> I'm using snd_ctl_add_boolean_elem_set and snd_ctl_add_integer_elem_set
>> to create some user kernel controls. While the operation work find I
>> did not find any simple command to erase all those controls.
>>
>> Even "/usr/sbin/alsactl --init" does not remove those added controls.
>> The only way I find is to prevent  /usr/sbin/alsactl to happen during
>> reboot to really reset the ALSA driver to an initial state, which is
>> really not pratical when developing/debugging.
>>
>> Question: is there a simple method to return to a clean and fresh state
>> after snd_ctl_add_xxxx without rebooting the machine ?
>
> There is no ownership information for user controls, so "alsactl store"
> and "alsactl restore" always keep them.
>
> To remove them, you can write a tool to call snd_ctl_elem_remove() on
> all of them.  Alternatively, unload the driver module, and remove the
> entries from the saved state file (probably /var/lib/alsa/asound.state).
>
>
> Regards,
> Clemens
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>

From: Abramo Bagnara <abramo.bagnara@tin.it>
Subject: Re: Re: [alsa-cvslog] CVS: alsa-kernel/core rawmidi.c,1.40,1.41
Date: Mon, 02 Feb 2004 11:19:39 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <401E243B.7030409@tin.it>
References: <E1AnKYI-0000sI-Hg@sc8-pr-cvs1.sourceforge.net> <401D318E.4020100@tin.it> <Pine.LNX.4.58.0402020932230.1872@pnote.perex-int.cz> <401E228A.7010104@tin.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <401E228A.7010104@tin.it>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
Cc: Jaroslav Kysela <perex@suse.cz>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Abramo Bagnara ha scritto:
> Jaroslav Kysela ha scritto:
> 
>> On Sun, 1 Feb 2004, Abramo Bagnara wrote:
>>
>>
>>> Jaroslav Kysela ha scritto:
>>>
>>>> Modified Files:
>>>>     rawmidi.c Log Message:
>>>> copy_*_user() function cannot be called from spinlock context
>>>>
>>>> Index: rawmidi.c
>>>> ===================================================================
>>>> RCS file: /cvsroot/alsa/alsa-kernel/core/rawmidi.c,v
>>>> retrieving revision 1.40
>>>> retrieving revision 1.41
>>>> diff -u -r1.40 -r1.41
>>>> --- rawmidi.c    23 Oct 2003 14:34:52 -0000    1.40
>>>> +++ rawmidi.c    1 Feb 2004 16:34:28 -0000    1.41
>>>> @@ -909,10 +909,11 @@
>>>>         if (kernel) {
>>>>             memcpy(buf + result, runtime->buffer + 
>>>> runtime->appl_ptr, count1);
>>>>         } else {
>>>> +            spin_unlock_irqrestore(&runtime->lock, flags);
>>>>             if (copy_to_user(buf + result, runtime->buffer + 
>>>> runtime->appl_ptr, count1)) {
>>>> -                spin_unlock_irqrestore(&runtime->lock, flags);
>>>>                 return result > 0 ? result : -EFAULT;
>>>>             }
>>>> +            spin_lock_irqsave(&runtime->lock, flags);
>>>>         }
>>>>         runtime->appl_ptr += count1;
>>>>         runtime->appl_ptr %= runtime->buffer_size;
>>>> @@ -1133,10 +1134,13 @@
>>>>         if (kernel) {
>>>>             memcpy(runtime->buffer + runtime->appl_ptr, buf, count1);
>>>>         } else {
>>>> +            spin_unlock_irqrestore(&runtime->lock, flags);
>>>>             if (copy_from_user(runtime->buffer + runtime->appl_ptr, 
>>>> buf, count1)) {
>>>> +                spin_lock_irqsave(&runtime->lock, flags);
>>>>                 result = result > 0 ? result : -EFAULT;
>>>>                 goto __end;
>>>>             }
>>>> +            spin_lock_irqsave(&runtime->lock, flags);
>>>>         }
>>>>         runtime->appl_ptr += count1;
>>>>         runtime->appl_ptr %= runtime->buffer_size;
>>>
>>>
>>>
>>> With this patch you break write and read atomicity, you should:
>>>
>>> 1) read and save appl_ptr
>>> 2) update appl_ptr and avail
>>> 3) leave critical area
>>> 4) copy from/to user using saved appl_ptr
>>
>>
>>
>> But hardware can overwrite data (read) or send data which are not yet 
>> available (write) when we are not in the spinlock context and data are 
>> not copied.
> 
> 
> I see.
> 
>> If we need atomic read() and write() we must probably add a semaphore.
> 
> 
> Too heavyweight, I propose:
> 
> 1) size_t ptr = appl_ptr_next
> 2) update appl_ptr_next etc.
> 3) pending++
> 4) spin_unlock
> 5) copy from/to user

Using ptr of course

> 6) spin_lock
> 7) if (--pending) appl_ptr = appl_ptr_next

Sorry, this should be:
7) if (--pending == 0) appl_ptr = appl_ptr_next


-- 
Abramo Bagnara                       mailto:abramo.bagnara@tin.it

Opera Unica                          Phone: +39.0546.656023
Via Emilia Interna, 140
48014 Castel Bolognese (RA) - Italy


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn

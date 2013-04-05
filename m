From: mateen <abdulmateen.shaikh@gmail.com>
Subject: Re: Deadlock over semaphore issue with aplay while
	using dmix
Date: Fri, 5 Apr 2013 22:03:33 +0530
Message-ID: <CADryByFD=OTsevfSrEwhK2GTBKRrwfpfs5=HNaV8PyMxdNsT-Q@mail.gmail.com>
References: <CADryByFz6x_ekmwXW7uwn_wzSgwvDNb-HP9V7GCN1L=_BvOFeg@mail.gmail.com>
 <s5h8v4x2ima.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ve0-f169.google.com (mail-ve0-f169.google.com
 [209.85.128.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 164CB261719
 for <alsa-devel@alsa-project.org>; Fri,  5 Apr 2013 18:33:33 +0200 (CEST)
Received: by mail-ve0-f169.google.com with SMTP id d10so3722160vea.14
 for <alsa-devel@alsa-project.org>; Fri, 05 Apr 2013 09:33:33 -0700 (PDT)
In-Reply-To: <s5h8v4x2ima.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,



On Friday, April 5, 2013, Takashi Iwai <tiwai@suse.de> wrote:
> At Fri, 5 Apr 2013 19:02:08 +0530,
> mateen wrote:
>>
>> Hi,
>> I checked with Takshi's patch and would like to suggest couple of change=
s.
>>
>> 1. We keep dmix_down_sem(dmix) and dmix_up_sem(dmix) as macros instead of
>> defining them as functions.
>
> No, no. =A0That's a very bad practice. =A0Don't do it. =A0If any, use sta=
tic
> inline.
>

Agreed.

> But in this case, there is no merit to do inline. =A0Let compiler
> optimize.


>> 2. We free up the semaphore in snd_pcm_dmix_close() if it is recognized
>> that the semaphore is held up by the same process, which will be indicat=
ed
>> by dmix->semlocked flag.
>
> Why do you need reacquire the very same lock at all...?
> I see no point for it.
>

Agree,
That lock is still with the same process.we need not reacquire it.


> Takashi
>
>>
>> Mateen.
>>
>> diff -Nuar dir2/pcm_direct.h dir1/pcm_direct.h
>> --- dir2/pcm_direct.h =A0 =A02009-12-16 20:48:51.000000000 +0530
>> +++ dir1/pcm_direct.h =A0 =A02013-04-05 17:06:48.331497000 +0530
>> @@ -123,6 +123,7 @@
>> =A0 =A0 =A0int ipc_gid; =A0 =A0 =A0 =A0 =A0 =A0/* IPC socket gid */
>> =A0 =A0 =A0int semid; =A0 =A0 =A0 =A0 =A0 =A0/* IPC global semaphore ide=
ntification */
>> =A0 =A0 =A0int shmid; =A0 =A0 =A0 =A0 =A0 =A0/* IPC global shared memory=
 identification */
>> + =A0 =A0 =A0 int semlocked;
>> =A0 =A0 =A0snd_pcm_direct_share_t *shmptr; =A0 =A0/* pointer to shared m=
emory area */
>> =A0 =A0 =A0snd_pcm_t *spcm; =A0 =A0 =A0 =A0 /* slave PCM handle */
>> =A0 =A0 =A0snd_pcm_uframes_t appl_ptr;
>> diff -Nuar dir2/pcm_dmix.c dir1/pcm_dmix.c
>> --- dir2/pcm_dmix.c =A0 =A02009-12-16 20:48:51.000000000 +0530
>> +++ dir1/pcm_dmix.c =A0 =A02013-04-05 17:04:02.781109000 +0530
>> @@ -285,8 +285,17 @@
>> =A0 */
>> =A0#ifndef DOC_HIDDEN
>> =A0#ifdef NO_CONCURRENT_ACCESS
>> -#define dmix_down_sem(dmix) snd_pcm_direct_semaphore_down(dmix,
>> DIRECT_IPC_SEM_CLIENT)
>> -#define dmix_up_sem(dmix) snd_pcm_direct_semaphore_up(dmix,
>> DIRECT_IPC_SEM_CLIENT)
>> +#define dmix_down_sem(dmix) =A0\
>> +{\
>> +if (!dmix->semlocked++)\
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 snd_pcm_direct_semaphore_down(dmix, DIRECT=
_IPC_SEM_CLIENT);\
>> +}
>> +#define dmix_up_sem(dmix) \
>> +{\
>> + =A0 =A0 =A0 if (!--dmix->semlocked)\
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 snd_pcm_direct_semaphore_up(dmix, DIRECT_I=
PC_SEM_CLIENT);\
>> +}
>> +
>> =A0#else
>> =A0#define dmix_down_sem(dmix)
>> =A0#define dmix_up_sem(dmix)
>> @@ -764,7 +773,13 @@
>>
>> =A0 =A0 =A0if (dmix->timer)
>> =A0 =A0 =A0 =A0 =A0snd_timer_close(dmix->timer);
>> - =A0 =A0snd_pcm_direct_semaphore_down(dmix, DIRECT_IPC_SEM_CLIENT);
>> + =A0 =A0 =A0if(!dmix->semlocked)
>> + =A0 =A0 =A0 =A0 =A0 =A0snd_pcm_direct_semaphore_down(dmix, DIRECT_IPC_=
SEM_CLIENT);
>> + =A0 =A0 =A0else{
>> + =A0 =A0 =A0 =A0 =A0 =A0snd_pcm_direct_semaphore_up(dmix, DIRECT_IPC_SE=
M_CLIENT);
>> + =A0 =A0 =A0 =A0 =A0 =A0snd_pcm_direct_semaphore_down(dmix, DIRECT_IPC_=
SEM_CLIENT);
>> + =A0 =A0 =A0 =A0}
>> +
>> =A0 =A0 =A0snd_pcm_close(dmix->spcm);
>> =A0 =A0 =A0 if (dmix->server)
>> =A0 =A0 =A0 =A0 =A0 snd_pcm_direct_server_discard(dmix);
>>
>>
>>
>>
>> ------------------------------
>> ----------------------------------------
>>
>> Message: 1
>> Date: Thu, 04 Apr 2013 18:30:01 +0200
>> From: Takashi Iwai <tiwai@suse.de>
>> To: Jaroslav Kysela <perex@perex.cz>
>> Cc: alsa-devel@alsa-project.org
>> Subject: Re: [alsa-devel] Deadlock over semaphore issue with aplay
>> =A0 =A0 =A0 =A0 while =A0 using dmix
>> Message-ID: <s5h38v645ti.wl%tiwai@suse.de>
>> Content-Type: text/plain; charset=3DUS-ASCII
>>
>> At Thu, 04 Apr 2013 13:33:08 +0200,
>> Jaroslav Kysela wrote:
>> >
>> > Date 4.4.2013 11:27, mateen wrote:
>> > > Hi,
>> > >
>> > > I seeing sometimes deadlock issue with dmix when I press CTRL+C.
>> > >
>> > > Aplay's signal handler calls snd_pcm_close() if an interrupt occurs.
>> > > snd_pcm_close() will internally call =A0pcm->ops->close() which will=
 fall
>> to
>> > > snd_pcm_dmix_close() in case you are using dmix.
>> > >
>> > > snd_pcm_dmix_close() will try to acquire the semaphore with
>> > > snd_pcm_direct_semaphore_down(dmix, DIRECT_IPC_SEM_CLIENT).
>> > > The same semaphore is acquired in snd_pcm_dmix_sync_area() with
>> > > dmix_down_sem() in case of non-concurrent access.
>> > >
>> > > If semaphore is acquired in sn> [2 =A0<text/html; ISO-8859-1 (quoted=
-printable)>]
>>
>

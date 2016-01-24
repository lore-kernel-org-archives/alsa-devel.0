From: Tom Yan <tom.ty89@gmail.com>
Subject: Re: [PATCH - alsactl 1/1] make systemd service start
	in proper way
Date: Sun, 24 Jan 2016 18:48:09 +0800
Message-ID: <CAGnHSE=OP2U7SuDtavXrEsBaQPSLW82e15-2t1sAd_uPRiD2Vg@mail.gmail.com>
References: <56a41b26.5908620a.ff61a.6c10@mx.google.com>
 <s5hbn8bbec1.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <s5hbn8bbec1.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, patch@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Since v18:
http://cgit.freedesktop.org/systemd/systemd/commit/?id=88dfa2938af09e511e4911e6984360ded0e2cd8d
http://cgit.freedesktop.org/systemd/systemd/tag/?id=v18

On 24 January 2016 at 15:56, Takashi Iwai <tiwai@suse.de> wrote:
> On Sun, 24 Jan 2016 01:30:23 +0100,
> tom.ty89@gmail.com wrote:
>>
>> From: Tom Yan <tom.ty89@gmail.com>
>>
>> Use sound.target to trigger the service, which is the proper way
>> to start a service related to sound card. This also makes sure that
>> the service will only start if a sound card exists in the system.
>
> Has this target existed in all released versions of systemd?
> Just to be sure...
>
>> basic.target is too early for either of the service:
>> 1. alsa-state.service will spam "No soundcards found" on every boot
>
> Actually this should be seen as a bug of alsactl itself.  In the
> daemon mode, it should be allowed to run without the sound card at
> start.
>
>> 2. alsa-restore.service will never start because of
>>    "ConditionPathExistsGlob=/dev/snd/control*"
>
> ... unless reloading or starting the service later.
>
>> "After=sysinit.target" is removed from alsa-state.service because it
>> never made any sense.
>>
>> "After=alsa-state.service" is removed from alsa-restore.service because
>> it is completely unnecessary with the daemon conf switch.
>>
>> Now either of serivce is enough to manage the state all by itself without
>> the udev rules if only ONE sound card exists in the system, while the rules
>> are still necessary in system with multiple sound cards.
>
> ... or with a hotplug device.
>
>> "StandardOutput=syslog" is also removed from alsa-restore.service because it
>> makes little sense (if it has ever switched the behaviour away from default).
>
> That's superfluous indeed.
>
>
> thanks,
>
> Takashi
>
>
>> Signed-off-by: Tom Yan <tom.ty89@gmail.com>
>>
>> diff --git a/alsactl/Makefile.am b/alsactl/Makefile.am
>> index cac8094..90fab9d 100644
>> --- a/alsactl/Makefile.am
>> +++ b/alsactl/Makefile.am
>> @@ -29,8 +29,8 @@ systemdsystemunit_DATA = \
>>
>>  install-data-hook:
>>       $(MKDIR_P) -m 0755 \
>> -             $(DESTDIR)$(systemdsystemunitdir)/basic.target.wants
>> -     ( cd $(DESTDIR)$(systemdsystemunitdir)/basic.target.wants && \
>> +             $(DESTDIR)$(systemdsystemunitdir)/sound.target.wants
>> +     ( cd $(DESTDIR)$(systemdsystemunitdir)/sound.target.wants && \
>>               rm -f alsa-state.service alsa-restore.service && \
>>               $(LN_S) ../alsa-state.service alsa-state.service && \
>>               $(LN_S) ../alsa-restore.service alsa-restore.service)
>> diff --git a/alsactl/alsa-restore.service.in b/alsactl/alsa-restore.service.in
>> index 2884098..fbcf983 100644
>> --- a/alsactl/alsa-restore.service.in
>> +++ b/alsactl/alsa-restore.service.in
>> @@ -6,12 +6,9 @@
>>  [Unit]
>>  Description=Save/Restore Sound Card State
>>  ConditionPathExists=!@daemonswitch@
>> -ConditionPathExistsGlob=/dev/snd/control*
>> -After=alsa-state.service
>>
>>  [Service]
>>  Type=oneshot
>>  RemainAfterExit=true
>>  ExecStart=-@sbindir@/alsactl restore
>>  ExecStop=-@sbindir@/alsactl store
>> -StandardOutput=syslog
>> diff --git a/alsactl/alsa-state.service.in b/alsactl/alsa-state.service.in
>> index f1321d6..5a8fe5e 100644
>> --- a/alsactl/alsa-state.service.in
>> +++ b/alsactl/alsa-state.service.in
>> @@ -6,7 +6,6 @@
>>  [Unit]
>>  Description=Manage Sound Card State (restore and store)
>>  ConditionPathExists=@daemonswitch@
>> -After=sysinit.target
>>
>>  [Service]
>>  Type=simple
>> --
>> 2.7.0
>>

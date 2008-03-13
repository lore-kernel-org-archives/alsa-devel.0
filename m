From: "Pharaoh ." <pharaoh137@gmail.com>
Subject: Re: aplay doesnt work - new problem`
Date: Wed, 12 Mar 2008 17:44:56 -0700
Message-ID: <61445c750803121744w43611559nc39034b5ebd6d8ef@mail.gmail.com>
References: <61445c750803111605u1c9b8f5ascdee2289c992488a@mail.gmail.com>
	<47D7957D.2050505@ladisch.de>
	<61445c750803121149t45f1db2m69cce8d76fca213f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.229])
	by alsa0.perex.cz (Postfix) with ESMTP id B64BF2440A
	for <alsa-devel@alsa-project.org>; Thu, 13 Mar 2008 01:44:58 +0100 (CET)
Received: by wr-out-0506.google.com with SMTP id 58so2836616wri.8
	for <alsa-devel@alsa-project.org>; Wed, 12 Mar 2008 17:44:57 -0700 (PDT)
In-Reply-To: <61445c750803121149t45f1db2m69cce8d76fca213f@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 12, 2008 at 11:49 AM, Pharaoh . <pharaoh137@gmail.com> wrote:

>
>
> On Wed, Mar 12, 2008 at 1:34 AM, Clemens Ladisch <clemens@ladisch.de>
> wrote:
>
> > Pharaoh . wrote:
> > > I am trying to run my pcm external io type plugin on an arm based
> > board. I
> > > have no kernel alsa driver
> > > and the user space plugin is supposed to take care of talking to DSP
> > using
> > > shared memorty and send sound data.
> > >
> > > Since, I dont have kernel space ALSA driver, do I need to enable
> > kernel ALSA
> > > support in .config?
> >
> > No.
> >
> > > ALSA lib conf.c:2852:(snd_config_hook_load) cannot access file
> > > /home/pharaoh/alsa/cards/aliases.conf
> >
> > What --*prefix options did you use when configuring alsa-lib?
> > What did you use as DESTDIR when installing alsa-lib?
> >
> >
> > Regards,
> > Clemens
> >
>
> I configure alsa lib as :
>
> ./configure --host=$(ARCH_TOOLCHAIN_PREFIX)-linux --prefix=$(BUILD_OUTPUT)
> --exec-prefix=$(ROOTFS) --datadir=$(ROOTFS)/share --sysconfdir=$(ROOTFS)/etc
> --with-versioned=no --enable-static=yes
>
> Ignore $(ARCH_TOOLCHAIN_PREFIX)-linux.
> ROOTFS in / on board.
> DESTDIR is is /lib in rootfs, this is where libasound.so falls.
>
> But when I do file on resulting libasound.so it is shown as shared lib and
> not a static one.
>
> Same way I configure the alsa-utils.
>
> -pharaoh.
>
>
Now I am trying with my plugin, but I get following error, (this was part of
another thread but it is defunct now, apologies)


# aplay -D my_plug
aplay: can't resolve symbol 'snd_dlsym_start

When I do a nm -D on my plugin, I get following:
         U __assert
         U __udivsi3
         U __umodsi3
         U calloc
         U free
         U host_OMX_Deinit
         U host_OMX_Init
         U ilclient_change_component_state
         U ilclient_cleanup_components
         U ilclient_create_component
         U ilclient_destroy
         U ilclient_disable_port
         U ilclient_enable_port
         U ilclient_init
         U ilclient_set_empty_buffer_done_callback
         U ilclient_wait_for_event
         U memset
*         U printf*
         U puts
         U snd_config_get_id
         U snd_config_get_integer
         U snd_config_get_string
         U snd_config_iterator_end
         U snd_config_iterator_entry
         U snd_config_iterator_first
         U snd_config_iterator_next
*         U snd_dlsym_start*
         U snd_lib_error
         U snd_pcm_bytes_to_frames
         U snd_pcm_format_name
         U snd_pcm_format_physical_width
         U snd_pcm_format_value
         U snd_pcm_ioplug_create
         U snd_pcm_ioplug_delete
         U snd_pcm_ioplug_set_param_list
         U snd_pcm_ioplug_set_param_minmax
         U snprintf
         U strcmp
         U uCloseMutex
         U uCreateMutex
         U uGetMutex
         U uReleaseMutex

This is quite alright and these syms should be resolved runtime, but when I
did

#nm -D lib/libasound.so* | grep "snd_dlsym_start"


I get nothing, where snd_dlsym_start is supposed to be? As per my shallow
reading on this matter this is used only when static libs are being emulated
shared ones etc.



-pharaoh

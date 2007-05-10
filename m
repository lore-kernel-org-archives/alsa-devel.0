From: "Michel Benoit" <murpme@gmail.com>
Subject: Re: alsa on Atmel at91
Date: Thu, 10 May 2007 13:29:56 +0200
Message-ID: <c88e466f0705100429w7a4e86deyfea22508370358fd@mail.gmail.com>
References: <c88e466f0704151238q326df219uf95679897f4c44@mail.gmail.com>
	<c88e466f0704170503o450c9af3mc299129751dec208@mail.gmail.com>
	<1176813173.32188.181.camel@a10072.wolfsonmicro.main>
	<c88e466f0704170857k27a7dc9fk63490e3d4acd172b@mail.gmail.com>
	<1176827782.32188.224.camel@a10072.wolfsonmicro.main>
	<c88e466f0704180218p708ba602h766f6a3f36c1add0@mail.gmail.com>
	<1176889951.32188.246.camel@a10072.wolfsonmicro.main>
	<c88e466f0704180500l2f016c4bs28c6a3c1a3663575@mail.gmail.com>
	<1176900272.32188.274.camel@a10072.wolfsonmicro.main>
	<c88e466f0704180745k1201ff11kc477d9cc8ebf899c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.224])
	by alsa0.perex.cz (Postfix) with ESMTP id CF3102436C
	for <alsa-devel@alsa-project.org>;
	Thu, 10 May 2007 13:30:00 +0200 (CEST)
Received: by wr-out-0506.google.com with SMTP id 58so513736wri
	for <alsa-devel@alsa-project.org>; Thu, 10 May 2007 04:29:57 -0700 (PDT)
In-Reply-To: <c88e466f0704180745k1201ff11kc477d9cc8ebf899c@mail.gmail.com>
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
To: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Frank Mandarino <fmandarino@endrelia.com>
List-Id: alsa-devel@alsa-project.org

I put this problem aside for a while but I have now managed to narrow
it down a little

I'm trying to build alsa-lib 1.0.13 for a at91sam9260 target
(arm926ej-s).  I'm using gcc 4.1.2 built with buildroot (uclibc).  I
seem to be having a problem passing in arguments to some libasound
functions.

I have added some printfs to the following lib function (src/pcm.c):


int snd_pcm_hw_params_get_period_size(const snd_pcm_hw_params_t
*params, snd_pcm_uframes_t *val, int *dir)
{
       unsigned long _val;

       printf("get_period_size() %lu %lu %08x %08x %08x \n", _val,
*val, val, dir, params );

       int err = snd_pcm_hw_param_get(params, SND_PCM_HW_PARAM_PERIOD_SIZE,
&_val, NULL);
       if (err >= 0)
               *val = _val;

       printf("get_period_size() %lu %lu %08x %08x %08x %d\n", _val,
*val, val, dir, params, err );

       return err;
}


as well as to the program that calls the lib function (test/pcm.c):


       printf("period_size=%lu %08x dir=%d %08x params %08x \n",
size, &size, dir, &dir, params);
       err = snd_pcm_hw_params_get_period_size(params, &size, NULL);
       if (err < 0) {
               printf("Unable to get period size for playback: %s\n",
snd_strerror(err));
               return err;
       }
       period_size = size;
       printf("period_size=%lu %08x dir=%d %08x params %08x \n",
size, &size, dir, &dir, params);


When I run the program I get the following output

# pcm
Playback device is plughw:0,0
Stream parameters are 44100Hz, S16_LE, 1 channels
Sine wave rate is 440.0000Hz
Using transfer method: write
period_size=49572 bec48954 dir=0 bec48950 params bec489e4
get_period_size() 1073758756 3200551252 bec48924 bec48954 bec489e4
get_period_size() 1248 1248  bec48924 bec48954 bec489e4 0
period_size=49572 bec48954 dir=0 bec48950 params bec489e4

which shows that the pointers to 'params' is ok but that the pointer
to 'val' is incorrect (bec48924 instead of bec48954) and the pointer
to 'dir' is also wrong (bec48954 instead of  bec48950 = the pointer to
val).

What could be the cause of this kind of error?  Somehow the arguments
passed to  snd_pcm_hw_params_get_period_size() are getting mangled.

I have tried removing all optimisations, using other versions of gcc
(4.0.4 and 3.4.6) and using EABI instead of OABI.  I always get the
same result.

Any tips on how I can proceed in debugging this problem?

Are there any compiler or linker flags that could be responsible ?


Michel



On 4/18/07, Michel Benoit <murpme@gmail.com> wrote:
> > >
> > > It seems that that alsa lib is not returning the correct values.  Is
> > > this typical of the gcc bug?
> >
> > Iirc, some pcm refinements were being broken by this bug. So it could be
> > causing the period size = 0.
>
> I've now tried it with no -O option and it still returns period_size
> of 0.  The bug seemed to go away according to the bugzilla report when
> optimization is disabled.
>
> > >
> > > What gcc version are you using?
> >
> > 4.1.1
>
> The bug is also marked as fixed in 4.1.2.
>
> > > Can you also send me the parameters you use with ./configure to setup
> > > the cross-compilation?
> > >
> > > I use the following:
> > >
> > > CFLAGS="-Wall -O1" \
> > > CXXFLAGS="-Wall -O1" \
> > > CC=arm-linux-gcc ./configure \
> > >     --host=arm-linux\
> > >     --prefix=$HOME/bsp/rootfs/buildroot/build_arm/root/usr\
> > >     --with-softfloat\
> > >     --with-debug=yes
> > >
> >
> > The OE recipe used to build alsa-lib for OE is here (although, it needs
> > updating):-
> >
> > http://www.openembedded.org/repo/org.openembedded.dev/packages/alsa/alsa-lib_1.0.13.bb
> >
> > Btw, have you tried any other tests or aplay ?
>
> I run speaker_test from alsa-utils and get exactly the same result.
>
> > What about aplay -Dhw:0.0 file.wav (this should rule out missing conf
> > files that buildroot has not installed)
>
> I will try aplay.
>

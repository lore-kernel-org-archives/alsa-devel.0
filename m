From: Allan Klinbail <allank@labyrinth.net.au>
Subject: Re: can't compile CVS after fresh system install
Date: 18 Feb 2003 01:08:04 +1100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1045490891.16503.115.camel@littlewolf2.littlewolf>
References: <1045455722.13170.13.camel@littlewolf2.littlewolf>
	<s5hk7fzi4sh.wl@alsa2.suse.de>
	<1045485927.16502.78.camel@littlewolf2.littlewolf>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1045485927.16502.78.camel@littlewolf2.littlewolf>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa-dev <alsa-devel@lists.sourceforge.net>
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Solved !!!!!(almost) 

I upgraded autoconf,automake and pkgconfig from source (versions
required for MusE) and was able to succesfully compile alsa-driver
alsa-lib and alsa-utils.... 

However one thing I have noticed , gmix does complains it can't open
/dev/mixer (yes I did give the option --with-oss=yes... no big deal
though as aumix and alsamixer do work. 

So back to work tomorrow (after work) for using everything again.. as
it's 1am here I'm off to bed. 

 

cheers

Allan 




On Mon, 2003-02-17 at 23:45, Allan Klinbail wrote:
> Hi 
> 
> Yes I did try to run 'make clean', each time I tried again.  
> 
> I then have refreshed my cvs directories using the update command... 
> Still no good, well partially, jack can see alsa now.. but I'm still
> having problems with building alsa-lib directories.. (see output at
> bottom of message) 
> 
> Then I tried wiping the alsa-lib directory and "refreshing" that one
> from scratch.. still same problem
> 
> 
> Then I tried a CVS snapshot from the 15th of this month (I figured
> earlier than my most recent CVS download and newer than the mtpav
> changes) . Same problem
> 
> Then I did the same for the alsa-driver as I did for alsa-lib
> (completely removed then downloaded from CVS again)  same problem... 
> 
> 
> OUt of frustration .. even though I had already run ./snddevices before
> I decided to try running that again.. the output was different to usual,
> maybe something is involved here.. although until I re-installed
> Mandrake non of this was a problem
> 
> 
> mv: cannot move `/dev/sndstat' to `/dev/1sndstat': Operation not
> permitted
> rm: cannot remove `/dev/snd': Is a directory
> mv: cannot stat `/dev/1sndstat': No such file or directory
> rm: cannot remove `/dev/snd/controlC0': Operation not permitted
> rm: cannot remove `/dev/snd/controlC1': Operation not permitted
> rm: cannot remove `/dev/snd/controlC2': Operation not permitted
> rm: cannot remove `/dev/snd/controlC3': Operation not permitted
> rm: cannot remove `/dev/snd/controlC4': Operation not permitted
> rm: cannot remove `/dev/snd/controlC5': Operation not permitted
> rm: cannot remove `/dev/snd/controlC6': Operation not permitted
> rm: cannot remove `/dev/snd/controlC7': Operation not permitted
> rm: cannot remove `/dev/snd/midiC0D0': Operation not permitted
> rm: cannot remove `/dev/snd/midiC2D0': Operation not permitted
> rm: cannot remove `/dev/snd/pcmC0D0c': Operation not permitted
> rm: cannot remove `/dev/snd/pcmC0D0p': Operation not permitted
> rm: cannot remove `/dev/snd/pcmC1D0c': Operation not permitted
> rm: cannot remove `/dev/snd/pcmC1D0p': Operation not permitted
> rm: cannot remove `/dev/snd/seq': Operation not permitted
> rm: cannot remove `/dev/snd/timer': Operation not permitted
> rmdir: `/dev/snd': Operation not permitted
> ALSA dynamic sound device filesystem
> create symbolic link `/dev/snd/dev' to `/proc/asound/dev'
> ALSA loader devices
> Creating /dev/aload?... done
> Creating /dev/aloadSEQ... done
> 
>  
> Here is the complete output from where the errors starting appearing, in
> make 
> 
> cc -shared  conf.lo confmisc.lo input.lo output.lo async.lo error.lo
> dlmisc.lo -Wl,--whole-archive control/.libs/libcontrol.al
> mixer/.libs/libmixer.al pcm/.libs/libpcm.al rawmidi/.libs/librawmidi.al
> timer/.libs/libtimer.al hwdep/.libs/libhwdep.al seq/.libs/libseq.al
> instr/.libs/libinstr.al compat/.libs/libcompat.al
> -Wl,--no-whole-archive  control/.libs/libcontrol.al
> mixer/.libs/libmixer.al pcm/.libs/libpcm.al rawmidi/.libs/librawmidi.al
> timer/.libs/libtimer.al hwdep/.libs/libhwdep.al seq/.libs/libseq.al
> instr/.libs/libinstr.al compat/.libs/libcompat.al -lm -ldl
> -lpthread           -Wl,--version-script=Versions -Wl,-soname
> -Wl,libasound.so.2 -o .libs/libasound.so.2.0.0
> gcc: pcm/.libs/libpcm.al: No such file or directory
> gcc: pcm/.libs/libpcm.al: No such file or directory
> make[2]: *** [libasound.la] Error 1
> make[2]: Leaving directory `/usr/local/audio/cvs/alsa/alsa-lib/src'
> make[1]: *** [all-recursive] Error 1
> make[1]: Leaving directory `/usr/local/audio/cvs/alsa/alsa-lib/src'
> make: *** [all-recursive] Error 1
> [allan@littlewolf2 alsa-lib]$ 
> 
> 
> 
> 
> 
> 
> -------------------------------------------------------
> This sf.net email is sponsored by:ThinkGeek
> Welcome to geek heaven.
> http://thinkgeek.com/sf
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel





-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

From: David Henderson <dhenderson@digital-pipe.com>
Subject: Re: additional problem
Date: Tue, 12 Jul 2011 09:30:50 -0400
Message-ID: <4E1C4C8A.50703@digital-pipe.com>
References: <4E0B2F67.3070304@digital-pipe.com>	<4E0C68ED.1070506@digital-pipe.com>	<s5hiprmijtw.wl%tiwai@suse.de>	<4E1B07FD.9030702@digital-pipe.com>	<s5h1uxwkhcx.wl%tiwai@suse.de>	<4E1B1127.4080800@digital-pipe.com>	<s5htyasj1gi.wl%tiwai@suse.de>	<4E1B12FF.4080307@digital-pipe.com>	<s5hr55wj17k.wl%tiwai@suse.de>	<4E1B15EE.8080304@digital-pipe.com>	<s5hoc10izl3.wl%tiwai@suse.de>	<4E1C469B.4050400@digital-pipe.com>
	<s5hd3hfiqvc.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gw0-f51.google.com (mail-gw0-f51.google.com [74.125.83.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 6E6962471D
	for <alsa-devel@alsa-project.org>;
	Tue, 12 Jul 2011 15:33:00 +0200 (CEST)
Received: by gwj17 with SMTP id 17so2062790gwj.38
	for <alsa-devel@alsa-project.org>; Tue, 12 Jul 2011 06:32:59 -0700 (PDT)
In-Reply-To: <s5hd3hfiqvc.wl%tiwai@suse.de>
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

On 07/12/2011 09:13 AM, Takashi Iwai wrote:
> At Tue, 12 Jul 2011 09:05:31 -0400,
> David Henderson wrote:
>> On 07/11/2011 11:52 AM, Takashi Iwai wrote:
>>> At Mon, 11 Jul 2011 11:25:34 -0400,
>>> David Henderson wrote:
>>>> On 07/11/2011 11:17 AM, Takashi Iwai wrote:
>>>>> At Mon, 11 Jul 2011 11:13:03 -0400,
>>>>> David Henderson wrote:
>>>>>> On 07/11/2011 11:12 AM, Takashi Iwai wrote:
>>>>>>> At Mon, 11 Jul 2011 11:05:11 -0400,
>>>>>>> David Henderson wrote:
>>>>>>>> On 07/11/2011 10:43 AM, Takashi Iwai wrote:
>>>>>>>>> At Mon, 11 Jul 2011 10:26:05 -0400,
>>>>>>>>> David Henderson wrote:
>>>>>>>>>> On 07/01/2011 02:41 AM, Takashi Iwai wrote:
>>>>>>>>>>> At Thu, 30 Jun 2011 08:15:41 -0400,
>>>>>>>>>>> David Henderson wrote:
>>>>>>>>>>>> On 06/29/2011 09:57 AM, David Henderson wrote:
>>>>>>>>>>>>> Hi gang!  I've successfully been able to compile the alsa-utils
>>>>>>>>>>>>> package with the
>>>>>>>>>>>>> "--with-alsa-inc-prefix=/opt/staging/alsa/var/share/include
>>>>>>>>>>>>> --with-alsa-prefix=/opt/staging/alsa/lib", but the problem I'm having
>>>>>>>>>>>>> now is that the compiled binaries are looking for those directories
>>>>>>>>>>>>> during run-time and not just compile-time.  Does anyone have any
>>>>>>>>>>>>> thoughts on using those directories for package creation, but that the
>>>>>>>>>>>>> software doesn't use the '/opt/staging/alsa' prefix during run-time?
>>>>>>>>>>>>>
>>>>>>>>>>>>> Thanks,
>>>>>>>>>>>>> Dave
>>>>>>>>>>>> bump for help
>>>>>>>>>>> It works usually as is.  Check once via ldd whether the binary is
>>>>>>>>>>> really linked with that fixed path.  You may hit a problem when using
>>>>>>>>>>> libtool with *.la files, for example.
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> Takashi
>>>>>>>>>> Thanks for the continued help Takashi.  I've performed the requested
>>>>>>>>>> steps, but all referenced libs are correct (e.g. /lib/... and not
>>>>>>>>>> /opt/staging/alsa/lib/...).  Any other thoughts?
>>>>>>>>> Check ldd output of the binary.  If it contains the /opt/ path, it
>>>>>>>>> means that the path is set statically into the binary.  The old
>>>>>>>>> libtool had a related problem, IIRC.
>>>>>>>>>
>>>>>>>>> Other than that, rather ask your distro.  It's really distro-specific.
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Takashi
>>>>>>>> Hey Takashi, I performed the requested steps, but the output is still
>>>>>>>> correct (e.g. /lib/... and not /opt/staging/alsa/lib/...).
>>>>>>> So, what shows ldd at all?  Too little information.
>>>>>>>
>>>>>>>
>>>>>>> Takashi
>>>>>> # ldd /bin/amixer
>>>>>>             linux-gate.so.1 =>     (0xb7768000)
>>>>>>             libm.so.6 =>    /lib/libm.so.6 (0xb7741000)
>>>>>>             libasound.so.2 =>    /lib/libasound.so.2 (0xb7667000)
>>>>>>             libdl.so.2 =>    /lib/libdl.so.2 (0xb7663000)
>>>>>>             libpthread.so.0 =>    /lib/libpthread.so.0 (0xb764b000)
>>>>>>             libc.so.6 =>    /lib/libc.so.6 (0xb7507000)
>>>>>>             /lib/ld-linux.so.2 (0xb7769000)
>>>>>>             librt.so.1 =>    /lib/librt.so.1 (0xb74fe000)
>>>>> Then what happens if you run /bin/amixer ?
>>>>>
>>>>>
>>>>> Takashi
>>>> # /bin/amixer
>>>> ALSA lib conf.c:3601:(snd_config_update_r) Cannot access file
>>>> /opt/staging/package/var/share/alsa/alsa.conf
>>>> ALSA lib control.c:902:(snd_ctl_open_noupdate) Invalid CTL default
>>>> amixer: Mixer attach default error: No such file or directory
>>> It's a problem of alsa-lib build, not alsa-utils.
>>> Maybe you changed --prefix wrongly at alsa-lib build time?
>>>
>>>
>>> Takashi
>> That solved the problem!  Thanks Takashi!  Now that I've gotten the
>> software to compile correctly and I'm able to interact with the audio
>> hardware using alsamixer, I tried to run the speaker-test and now I'm
>> getting the error "ALSA lib
>> pcm_direct.c:1616:(snd1_pcm_direct_parse_open_conf) The field ipc_gid
>> must be a valid group (create group audio)" which I can see is a problem
>> with the absence of the 'audio' group on the distro.  Is there a way I
>> can configure alsa to use a different group other than 'audio'?
> You can set defaults.pcm.ipc_gid in ~/.asoundrc or /etc/asound.conf.
> Put a line like
> 	defaults.pcm.ipc_gid	"user"
>
> then the group "user" will be used for dmix/dsnoop.
>
>
> Takashi

Thanks again for the help Takashi.  Ok, I've created the 
/etc/asound.conf file with the appropriate group and now I'm trying to 
run the aplay binary and I'm not getting any error messages, but I'm 
also not hearing any sounds from the speakers.

# aplay freq10-30000-10s.wav
Playing WAVE 'freq10-30000-10s.wav' : Signed 16 bit Little Endian, Rate 
44100 Hz, Mono

# speaker-test -w ./freq10-30000-10s.wav

speaker-test 1.0.23

Playback device is default
Stream parameters are 48000Hz, S16_LE, 1 channels
Using 16 octaves of pink noise
Rate set to 48000Hz (requested 48000Hz)
Buffer size range from 2048 to 8192
Period size range from 1024 to 1024
Using max buffer size 8192
Periods = 4
was set period_size = 1024
was set buffer_size = 8192
  0 - Front Left
Time per period = 2.835792
  0 - Front Left
Time per period = 2.986653
  0 - Front Left
Time per period = 2.986654
  0 - Front Left
...snip...

I've made sure nothing is muted with the audio hardware by using 
alsamixer and changed the permissions on the files within the /etc/snd 
directory.  Any other thoughts?

Dave

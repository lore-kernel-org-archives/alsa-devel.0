From: Nathaniel Gray <n8gray@caltech.edu>
Subject: dmix plugin problems -- Resend
Date: Mon, 26 May 2003 15:28:32 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200305261528.32421.n8gray@caltech.edu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I'm sending this again since I got no response the first time and dmix 
does not appear to be under heavy development, despite how incredibly 
useful it would be if it worked.

[n8gray@golux alsa-lib-0.9.3]$ cat /proc/asound/version
Advanced Linux Sound Architecture Driver Version 0.9.3a.
Compiled on May  9 2003 for kernel 2.4.21-0.16mm-mdkcustom.
Using alsa-libs 0.9.3.

The dmix plugin seems to be very unreliable, or else maybe I'm not 
setting it up correctly.  Here's my asoundrc:
=================== .asoundrc ===================
pcm.intel8x0 {
   type hw
   card 0
}

ctl.intel8x0 {
   type hw
   card 0
}

pcm.mydmix {
    type dmix
    ipc_key 12349
    ipc_key_add_uid true
    slave {
        pcm "hw:0,0"
        # Setting this rate to 44100 seems to help
        rate 44100
    }
}

ctl.mydmix {
    type hw
    card 0
}

pcm.mixed {
    type plug
    slave {
       pcm mydmix
    }
}

ctl.mixed {
    type hw
    card 0
}
=================================================

If I run this command nothing happens:
[n8gray@golux sounds]$ aplay -D mixed KDE_Beep_ClockChime.wav
Playing WAVE 'KDE_Beep_ClockChime.wav' : Unsigned 8 bit, Rate 7418 Hz, 
Mono

I get no sound, no error, aplay uses no cpu time.  Here's the tail end 
of the same command under strace:
open("KDE_Beep_ClockChime.wav", O_RDONLY) = 5
read(5, "RIFF\256\17\0\0WAVEfmt \20\0\0\0\1\0\1\0", 24) = 24
read(5, "\372\34", 2)                   = 2
read(5, "\0\0\372\34\0\0\1\0\10\0", 10) = 10
read(5, "data\212\17\0\0", 8)           = 8
write(2, "Playing WAVE \'KDE_Beep_ClockChim"..., 41Playing WAVE 
'KDE_Beep_ClockChime.wav' : ) = 41
write(2, "Unsigned 8 bit, ", 16Unsigned 8 bit, )        = 16
write(2, "Rate 7418 Hz, ", 14Rate 7418 Hz, )          = 14
write(2, "Mono", 4Mono)                     = 4
write(2, "\n", 1
)                       = 1
shmget(IPC_PRIVATE, 49152, 0x1b6|0666)  = 10747908
shmat(10747908, 0, 0)                   = 0x40274000
shmget(IPC_PRIVATE, 12288, 0x1b6|0666)  = 10780677
shmat(10780677, 0, 0)                   = 0x40023000
read(5, "G\214j\313\267hqG\234\250Yn;\206\274[e=t\305\207\217FM"..., 
927) = 927
read(5, "\206\177U\217\214\207\211S\201\215\211\231[p\204\201\242"..., 
927) = 927
poll([at this point the program just hangs]

If I run this command it completes but I get no sound output:
[n8gray@golux sounds]$ aplay -D mixed pop.wav
Playing WAVE 'pop.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, 
Mono

The same file plays properly (with sound) if I leave out the "-D mixed" 
flag.  This command, however, works perfectly:
[n8gray@golux sounds]$ aplay -D mixed info.wav
Playing WAVE 'info.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, 
Mono

If I actually try to mix two streams, though, I get xruns and cracks in 
the sound:
[n8gray@golux sounds]$ aplay -D mixed info.wav & aplay -D mixed info.wav
[1] 12952
Playing WAVE 'info.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, 
Mono
Playing WAVE 'info.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, 
Mono
xrun!!! (at least 0.030 ms long)
xrun!!! (at least 0.008 ms long)
[1]+  Done                    aplay -D mixed info.wav

I've tried this experiment with long sounds to try to eliminate any 
startup inefficiency, but the cracks last as long as the streams are 
being mixed.

I'll be glad to help debug in any way I can.  I've tried using the C 
versions of mix_areas1 and mix_areas2 and it doesn't help any of these 
problems.

Thanks,
-Nathan
-- 
>>>-- Nathaniel Gray -- Caltech Computer Science ------>
>>>-- Mojave Project -- http://mojave.cs.caltech.edu -->




-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge

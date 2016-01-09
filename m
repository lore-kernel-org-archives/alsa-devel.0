From: Tom Yan <tom.ty89@gmail.com>
Subject: Re: wrong channel mapping in a52 plugin
Date: Sun, 10 Jan 2016 01:22:09 +0800
Message-ID: <CAGnHSE=itUuRxgFEVKJeX3PnPia9FC3wuxXcVvLTY-3wXfRw3Q@mail.gmail.com>
References: <CAGnHSEmzqH3hSjO4wsy=ZTHtKVc8SeJcqp6kbayZ0pR8o=3Hfw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <CAGnHSEmzqH3hSjO4wsy=ZTHtKVc8SeJcqp6kbayZ0pR8o=3Hfw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, alsa-user@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I think I found out what exactly is wrong in the a52 plugin.


So I had this .asoundrc:

pcm.myhw {
    type hw
    card PCH
    device 0
}

pcm.mya52 {
    type a52
    card PCH
}


pcm.hwfile {
    type file
    slave {
        pcm myhw
    }
    file myhw.wav
    format wav
}

pcm.a52file {
    type file
    slave {
        pcm mya52
    }
    file mya52.wav
    format wav
}

and ran the following:


[tom@localhost ~]$ speaker-test -D hwfile -c 6 -l 1

speaker-test 1.1.0

Playback device is hwfile
Stream parameters are 48000Hz, S16_LE, 6 channels
Using 16 octaves of pink noise
Rate set to 48000Hz (requested 48000Hz)
Buffer size range from 22 to 349525
Period size range from 11 to 174762
Using max buffer size 349524
Periods = 4
was set period_size = 87381
was set buffer_size = 349524
 0 - Front Left
 4 - Front Center
 1 - Front Right
 3 - Rear Right
 2 - Rear Left
 5 - LFE
Time per period = 10.961529
[tom@localhost ~]$ speaker-test -D plug:a52file -c 6 -l 1

speaker-test 1.1.0

Playback device is plug:a52file
Stream parameters are 48000Hz, S16_LE, 6 channels
Using 16 octaves of pink noise
Rate set to 48000Hz (requested 48000Hz)
Buffer size range from 3072 to 1047552
Period size range from 1536 to 1536
Using max buffer size 1047552
Periods = 4
was set period_size = 1536
was set buffer_size = 1047552
 0 - Front Left
 2 - Front Center
 1 - Front Right
 5 - Rear Right
 4 - Rear Left
 3 - LFE
Time per period = 6.376158

As you can see, the a52 plugin expose/report itself as something that
consider the input it takes should be in general 5.1 mapping order
(fl-fr-fc-lfe-bl-br) instead of "ALSA order" (fl-fr-bl-br-fc-lfe),
while it actually consider the input has ALSA order and remap the
channels when get it encoded (because ac3 should have the general
order).

Same thing happens in mpv:

[tom@localhost ~]$ mpv --audio-channels=help | grep 5.1
    5.1              (fl-fr-fc-lfe-bl-br)
    5.1(alsa)        (fl-fr-bl-br-fc-lfe)
    5.1(side)        (fl-fr-fc-lfe-sl-sr)
[tom@localhost ~]$ ffprobe
Downloads/www_lynnemusic_com_surround_test.ac3 |& grep 5.1
    Stream #0:0: Audio: ac3, 48000 Hz, 5.1(side), fltp, 448 kb/s
[tom@localhost ~]$ mpv -ao alsa:device=[hwfile]:non-interleaved
--audio-channels=6 Downloads/www_lynnemusic_com_surround_test.ac3
Playing: Downloads/www_lynnemusic_com_surround_test.ac3
[ffmpeg/demuxer] ac3: Estimating duration from bitrate, this may be inaccurate
 (+) Audio --aid=1 (ac3)
AO: [alsa] 48000Hz 5.1(alsa) (5.1) 6ch s32
A: 00:00:09 / 00:00:09 (97%)


Exiting... (End of file)
[tom@localhost ~]$ mpv -ao alsa:device=[a52file]:non-interleaved
--audio-channels=6 Downloads/www_lynnemusic_com_surround_test.ac3
Playing: Downloads/www_lynnemusic_com_surround_test.ac3
[ffmpeg/demuxer] ac3: Estimating duration from bitrate, this may be inaccurate
 (+) Audio --aid=1 (ac3)
AO: [alsa] 48000Hz 5.1 6ch s16p
A: 00:00:09 / 00:00:09 (97%)


Exiting... (End of file)

[ see 5.1 vs 5.1(alsa) in the AO: lines; the input is 5.1(side), which
has basically the same order as 5.1 ]

I've also done the same test with mplayer. As oppose to what
speaker-test / mpv does, it does a channel remap ANYWAY (at least for
-ao alsa). I compared all the output wav files captured by the "type
file" pcm wrappers to confirm these.

Another example is the ALSA pulse plugin:

[tom@localhost ~]$ speaker-test -D pulse -c 6 -l 1

speaker-test 1.1.0

Playback device is pulse
Stream parameters are 48000Hz, S16_LE, 6 channels
Using 16 octaves of pink noise
Rate set to 48000Hz (requested 48000Hz)
Buffer size range from 32 to 349525
Period size range from 10 to 116509
Using max buffer size 349524
Periods = 4
was set period_size = 87381
was set buffer_size = 349524
 0 - Front Left
 4 - Center
 1 - Front Right
 3 - Rear Right
 2 - Rear Left
 5 - LFE
Time per period = 10.976481

As you can see, it reports that it takes ALSA order. That's exactly
what a52 plugin should do too.

On 9 January 2016 at 02:59, Tom Yan <tom.ty89@gmail.com> wrote:
> I am using alsa-lib/alsa-utils/alsa-plugins 1.1.0 and ffmpeg 2.8.4 and
> in Arch Linux.
>
> So I ran `speaker-test -D wav -c 6 -l 1` with the following .asoundrc:
>
> pcm.file {
>     type file
>     file st.ac3
> }
>
> pcm.a52 {
>     type plug
>     slave {
>         pcm {
>             type a52
>             slavepcm file
>         }
>     }
> }
>
> pcm.wav {
>     type file
>     slave {
>         pcm a52
>     }
>     file st.wav
>     format wav
> }
>
> [tom@localhost ~]$ speaker-test -D wav -c 6 -l 1
>
> speaker-test 1.1.0
>
> Playback device is wav
> Stream parameters are 48000Hz, S16_LE, 6 channels
> Using 16 octaves of pink noise
> Rate set to 48000Hz (requested 48000Hz)
> Buffer size range from 3072 to 206157312
> Period size range from 1536 to 1536
> Using max buffer size 206157312
> Periods = 4
> was set period_size = 1536
> was set buffer_size = 206157312
>  0 - Front Left
>  2 - Front Center
>  1 - Front Right
>  5 - Rear Right
>  4 - Rear Left
>  3 - LFE
> Time per period = 0.203625
>
> Then, I encode "st.wav" manually with `ffmpeg -i st.wav ff.ac3`.
>
> This shows a comparison between the wav file written directly from the
> speaker-test directly (st.wav) and the ac3 file I encode with a manual
> ffmpeg command (ff.ac3):
> https://ptpb.pw/5XJR.png
> As you can see, everything is preserved but the LFE is made LFE.
>
> And this shows a comparision between the the ac3 file from ffmpeg and
> the one written from the output of a52 plugin:
> https://ptpb.pw/YaKg.png
> If you compare carefully, you can see that Front Center and Rear Left
> is swapped, LFE and Rear Right is also swapped.
>
> Here is a pair of ac3 samples that shows the problem clearly (a lady
> will be telling the channels one by one):
> Original: https://ptpb.pw/9XdC.ac3
> ALSA a52 plugin re-encoded from mpv output: https://ptpb.pw/SQ_7.ac3

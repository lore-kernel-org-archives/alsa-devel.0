From: Daniel Drake <drake@endlessm.com>
Subject: arecord: strange --duration behaviour with some sample
	rates
Date: Tue, 20 Jan 2015 14:38:37 -0600
Message-ID: <CAD8Lp47AoypMz_AYicOh7XvCThc-xKwxa2NYMRD_3h-aOophbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

With alsa-utils-1.0.28, we're seeing some strange behaviour when running:
 arecord -t wav -r 44100 -d 1 out.wav

After recording 1 second of data to out.wav, a load of extra files are
created like out-01.wav, out-02.wav, out-03.wav, etc. These extra
files are 44 bytes in length. arecord seems to continue  like this
forever rather than exiting after the 1 second recording.

The problem is somehow linked to the sample-rate. At 48000 or 8000,
things work fine, just 44100 is bad.

Tracing some values in the source:
count is 44100, and rest is initialized to the same.

In each iteration of the /* capture */ loop, f has value 5512, i.e.
5512 bytes are read.
So rest decreases through values 38588, 33076, 27564, 22052, 16540, 11028, 5516.

Now we read another 5512 bytes, rest is decreased to 4.
So we now call pcm_read(audiobuf, f) where f has value 4.
pcm_read adjusts that to 5512 and returns 5512.

Now we hit:
    if (pcm_read(audiobuf, f) != f)
        break;

We break out of that inner loop, count still has value 4 so we reach
the end of the outer loop, and loop again, which causes a new file to
be opened, etc.

Sorry that I'm not quite up-to-scratch with pcm basics to suggest a
quick fix, but hopefully this diagnosis is useful at least.

Thanks,
Daniel

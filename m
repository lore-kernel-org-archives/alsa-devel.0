From: "Dave Airlie" <airlied@gmail.com>
Subject: Sound disappears after a long run,
	pcm_rate plugin maybe
Date: Thu, 28 Jun 2007 11:29:58 +1000
Message-ID: <21d7e9970706271829g22df7b0bue611deeb914fa084@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.248])
	by alsa0.perex.cz (Postfix) with ESMTP id 45F402454F
	for <alsa-devel@alsa-project.org>;
	Thu, 28 Jun 2007 03:29:59 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id c36so83781ana
	for <alsa-devel@alsa-project.org>; Wed, 27 Jun 2007 18:29:58 -0700 (PDT)
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

I've been debugging this bug which I first noticed close to a year ago
but worked around by disabling dmix. Now I've had to enable dmix and
try and fix it.

My system is  SDL on alsa-lib-1.0.13 on 2.6.21 on intel 810 with a
Realtek ALC655.

I'm using SDL to open a 22050 16-bit stereo stream, and dmix is set to 48000.

When I run sound in my single app (only one app running for testing
purposes) around 20-24 hours later (I haven't got exact timings as I
can't sit in front of the pc for so long) the sound stop s happening
just in that app.

I can run aplay separately and it plays fine.

If I stop my app (ctrl-C and cont in gdb) or attach/detach strace, I
get an XRUN and my SDL code calls snd_pcm_prepare and the sounds comes
back. Now I can't tell you how much it sucks to only get a single
debugging run every 24 hours for 1 break point and if gdb stuffs it up
you lose big time.

I think I've tracked it down to pcm_rate.c as in if I open the sound
card at 48000 instead of 22050 it doesn't happen and I've added a lot
of printfs to the rate code in 1.0.13 and gotten huge log file traces
of it..

In a normal rate trace when things are working I get traces like this:
snd_pcm_rate_sync_playback_area: 442023720 442023720 525 986185728
snd_pcm_rate_sync_playback_area: 442023720 442023720 1549 986185728
snd_pcm_rate_sync_playback_area: 442023720 442023720 1549 986185728
snd_pcm_rate_sync_playback_area: 442024660 442023720 1549 986185728
snd_pcm_rate_commit_area: 6 940 1024 1881
snd_pcm_rate_sync_playback_area: 940 442023720 1881
snd_pcm_rate_sync_playback_area: 442024660 442024660 525 986185728
snd_pcm_rate_sync_playback_area: 442024660 442024660 1549 986185728
snd_pcm_rate_sync_playback_area: 442024660 442024660 1549 986185728
snd_pcm_rate_sync_playback_area: 442025595 442024660 1549 986185728
snd_pcm_rate_sync_playback_area: 442025600 442024660 1549 986185728
snd_pcm_rate_commit_area: 946 940 1024 1881
snd_pcm_rate_sync_playback_area: 940 442024660 1881
snd_pcm_rate_sync_playback_area: 442025600 442025600 525 986185728
snd_pcm_rate_sync_playback_area: 442025600 442025600 1549 986185728
snd_pcm_rate_sync_playback_area: 442025600 442025600 1549 986185728
snd_pcm_rate_sync_playback_area: 442026540 442025600 1549 986185728
snd_pcm_rate_commit_area: 5 940 1024 1881
snd_pcm_rate_sync_playback_area: 940 442025600 1881
snd_pcm_rate_sync_playback_area: 442026540 442026540 525 986185728
snd_pcm_rate_sync_playback_area: 442026540 442026540 1549 986185728
snd_pcm_rate_sync_playback_area: 442026540 442026540 1549 986185728
snd_pcm_rate_sync_playback_area: 442027476 442026540 1549 986185728
snd_pcm_rate_sync_playback_area: 442027480 442026540 1549 986185728

playback are debug code
        slave_size = snd_pcm_avail_update(slave);
        if (slave_size < 0)
                return slave_size;
         fprintf(stderr,"%s: %u %d %u %u\n", __func__, appl_ptr,
rate->last_commit_ptr, slave_size, pcm->boundary);
        if (appl_ptr < rate->last_commit_ptr)
                xfer = appl_ptr - rate->last_commit_ptr + pcm->boundary;
        else
                xfer = appl_ptr - rate->last_commit_ptr;
        while (xfer >= pcm->period_size &&
               (snd_pcm_uframes_t)slave_size >=
rate->gen.slave->period_size) {                 err =
snd_pcm_rate_commit_next_period(pcm, rate->last_commit_ptr %
pcm->buffer_size);                 fprintf(stderr, "%s: %u %u %u\n",
__func__, xfer, rate->last_commit_ptr, pcm->buffer_size);
                if (err == 0)

commit area debug
       fprintf(stderr,"%s: %u %u %u %u\n", __func__, appl_offset,
size, slave_size, pcm->buffer_size);
        areas = snd_pcm_mmap_areas(pcm);
        if (cont >= size) {

In the not so good case (with different debug - two sites and I hadn't
access to my debug code from one so I wrote it again)
you get large numbers of
snd_pcm_rate_sync_playback_area: 152605942 912 152385750
snd_pcm_rate_sync_playback_area: 152605942 912 152385750
snd_pcm_rate_sync_playback_area: 152606412 912 152385750
snd_pcm_rate_sync_playback_area: 152606412 912 152385750
snd_pcm_rate_sync_playback_area: 152606705 912 152385750
snd_pcm_rate_sync_playback_area: 152606882 912 152385750
snd_pcm_rate_sync_playback_area: 152606882 912 152385750
snd_pcm_rate_sync_playback_area: 152607352 912 152385750
snd_pcm_rate_sync_playback_area: 152607352 912 152385750
......
snd_pcm_rate_sync_playback_area: 152769972 912 152385750
snd_pcm_rate_sync_playback_area: 152770381 1936 152385750
snd_pcm_rate_commit_area: 1411 572 470
snd_pcm_rate_sync_playback_area: 384631 1 1936 152385750 739770368
snd_pcm_rate_sync_playback_area: 152770442 912 152386220
.... more of these....
snd_pcm_rate_sync_playback_area: 152910502 912 152386220
snd_pcm_rate_sync_playback_area: 152910502 912 152386220
snd_pcm_rate_sync_playback_area: 152910972 912 152386220
snd_pcm_rate_sync_playback_area: 152910972 912 152386220
appl ptr is 152910972
recalc: 3022344724 1411 3072 470 1024
snd_pcm_rate_sync_playback_area: 152910972 1936 152386220
snd_pcm_rate_commit_area: 1411 1042 470
snd_pcm_rate_sync_playback_area: 524752 1 1936 152386220 739770368
snd_pcm_rate_sync_playback_area: 152910972 1936 152386690
snd_pcm_rate_commit_area: 1411 101 470
snd_pcm_rate_sync_playback_area: 524282 1 1936 152386690 739770368
snd_pcm_rate_sync_playback_area: 152910972 1936 152387160
... this pattern repeats one commit per two playbacks until it goes
back in the top...

the debug code for these are
recalc:       fprintf(stderr,"%s: %lu %lu %lu %lu %lu\n", __func__, val,
                pcm->buffer_size, slave->buffer_size,
                pcm->period_size, slave->period_size);
commit area
    areas = snd_pcm_mmap_areas(pcm);
        fprintf(stderr,"%s: %u %u %u\n", __func__, pcm->buffer_size,
appl_offset, size);
        if (cont >= size) {

playback area:
        fprintf(stderr,"%s: %u %d %d\n", __func__, appl_ptr,
slave_size, rate->last_commit_ptr);
        if (appl_ptr < rate->last_commit_ptr)
                xfer = appl_ptr - rate->last_commit_ptr + pcm->boundary;
        else
                xfer = appl_ptr - rate->last_commit_ptr;
        while (xfer >= pcm->period_size &&
               (snd_pcm_uframes_t)slave_size >= rate->gen.slave->period_size) {

                err = snd_pcm_rate_commit_next_period(pcm,
rate->last_commit_ptr % pcm->buffer_size);
                fprintf(stderr,"%s: %u %d %d %u %u\n", __func__, xfer,
err, slave_size, rate->last_commit_ptr, pcm->boundary);

I'm hoping it is just some calculation in the rate plugin overflowing
and I was blaming SDL but I've fixed up the codepaths to look like
aplay and it still happened..

any hints would be appreciated on a) what that rate code is actually
doing in the fail case, b) what the rate code is doing in the non-fail
case :-)

Dave.

From: Jan Homann <jh@janhomann.de>
Subject: Re: Too many snd_pcm_mmap_readi calls
Date: Tue, 13 May 2014 09:25:01 +0200
Message-ID: <5371C8CD.6030606@janhomann.de>
References: <5369DE58.30208@janhomann.de> <5369F684.7060502@ladisch.de>
 <536A026D.1070104@janhomann.de> <536A2E13.9070900@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from kunden1.comsitec.de (kunden1.comsitec.de [93.190.93.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 116B9265310
 for <alsa-devel@alsa-project.org>; Tue, 13 May 2014 09:25:05 +0200 (CEST)
In-Reply-To: <536A2E13.9070900@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Am 07.05.2014 14:58, schrieb Clemens Ladisch:
> Jan Homann wrote:
>> In my opinion mmap_begin just tells the alsa-lib that someone is about
>> to access the buffer.
> With mmap_begin, you ask the device how many frames are available in the
> buffer (and get a pointer to them).  With mmap_commit, you tell the
> device how many frames you actually read.
>
>> I am using mmap because of its good performance.
> Using mmap makes sense only when you are accessing the samples in the
> buffer directly.  If you just copy the frames into your own buffer,
> there is *no* difference whatsoever to snd_pcm_readi.
>
>> Under normal condition with snd_pcm_mmap_readi my program uses about
>> 1% of cpu-time where snd_pcm_readi uses about 75%.
> It's likely that you do not correctly wait for frames being available
> in your real program.
>
>> Do you know a good tutorial about using mmap_readi?
> This: use snd_pcm_readi instead.
>
>
> Regards,
> Clemens
>

Thank you for your explanation.
Obviously, there was an error in my initialization which caused the high
cpu-load while using snd_pcm_readi.
After fixing this my programm is running nice and quiet. For almost 8
minutes.
After this time the cpu-load goes up again. The alsa buffer should
contain 480 samples but contains something between 1920 and 6720 samples.
The debug output prints several timestamps. The time for one cycle
through the while-loop is captured in looptime. Under normal
circumstances this one is around 10ms as I expect.
After about 46.500 loops (which is something like 7.75minutes) the
looptime is up to 120ms. The time is used not at the snd_pcm_wait but at
the snd_pcm_readi.
My ARM-Device is running a Preempt Linux Kernel 2.6.35-8 and Arch Linux.

Any hints would be kindly appreciated.

Thanks in advance,
Jan Homann



P.S.: i appended the while-loop which is just in fact doing nothing then
waiting and reading. The above described behaviour occures even when
doing nothing with the captured pcm-data. The debug-output appears never
in my log-files.

    while(1) {

        cnt++;

        err = snd_pcm_wait( sound_handler, 20 );
        switch( err ) {
            case 1:
                //normal operation
                break;
            case 0:
                //timeout occurred - go on with a new loop
                if( global.debug ) printf("%s:%u snd_pcm_wait timeout
(%s), error-code: %d\n", __FILE__, __LINE__, snd_strerror(err), err);
                continue;
                break;
            case -EPIPE:
                if( global.debug ) printf("%s:%u snd_pcm_wait XRUN (%s),
error-code: %d\n", __FILE__, __LINE__, snd_strerror(err), err);
                break;
            case -ESTRPIPE:
                if( global.debug ) printf("%s:%u snd_pcm_wait suspended
(%s), error-code: %d\n", __FILE__, __LINE__, snd_strerror(err), err);
                break;
            default:
                if( global.debug ) printf("%s:%u snd_pcm_wait error
(%s), error-code: %d\n", __FILE__, __LINE__, snd_strerror(err), err);
                break;
        }

        if( global.debug ) gettimeofday(&time2,NULL);
        //time needed for alsa wait
        testtime1 = (time2.tv_usec - time1.tv_usec + (time2.tv_sec -
time1.tv_sec) * 1000000);

        //get the frames out of the soundcardbuffer
        memset( alsa_out_pcm_bytes_U8, 0, sizeof(alsa_out_pcm_bytes_U8) );

        frames_to_deliver = snd_pcm_avail_update(sound_handler);

        frames_to_deliver = min(frames_to_deliver, 480);
        network_data.read_frames = snd_pcm_readi( sound_handler,
alsa_out_pcm_bytes_U8, frames_to_deliver );


        if( network_data.read_frames < 0 ) {
            switch( network_data.read_frames ) {
                case -EAGAIN:
                    //there is no data in driverbuffer available - wait
again by starting the main loop again
                    if( global.debug ) printf("%s:%u EAGAIN on reading -
driverbuffer empty! (%s), error-code: %ld\n", __FILE__, __LINE__,\
                        snd_strerror(network_data.read_frames),
network_data.read_frames);
                    continue;
                    break;
                case -EPIPE:
                    if( global.debug ) printf("<<<<<<<<<<<<<<< Buffer
READ Overrun >>>>>>>>>>>>>>>\n");
                    if( global.debug ) printf("%s:%u (%s), error-code:
%ld\n",__FILE__, __LINE__,\
                        snd_strerror(network_data.read_frames),
network_data.read_frames);
                    continue;
                    break;
                default:
                    if( global.debug ) printf("%s:%u error reading (%s),
error-code: %ld\n", __FILE__, __LINE__,\
                        snd_strerror(network_data.read_frames),
network_data.read_frames);
                    continue;
                    break;
            }
        }

        if( global.debug ) {

            gettimeofday(&time3,NULL);
            //time needed for read
            testtime2 = (time3.tv_usec - time2.tv_usec + (time3.tv_sec -
time2.tv_sec) * 1000000);

            //sum of times for one cycle
            looptime = (time3.tv_usec - time1.tv_usec + (time3.tv_sec -
time1.tv_sec) * 1000000);

            //looptime:  Time for one cycle
            //testtime1: Time for alsa wait
            //testtime2: Time for alsa read
            printf("%06d L:%05d T1:%05d T2:%05d %ld %ld %d\n", \
                    cnt, \
                    looptime, testtime1,testtime2, \
                    network_data.read_frames, frames_to_deliver, err);
           
            if (looptime > 15000){
                printf("ERR %06d L:%05d T1:%05d T2:%05d %ld %ld %d\n", \
                    cnt, \
                    looptime, testtime1,testtime2, \
                    network_data.read_frames, frames_to_deliver, err);
            }
           
            if( global.debug )
gettimeofday(&time1,NULL);                       
        }
    }
}

From: "sam detweiler" <sdetweil@gmail.com>
Subject: arecord stops capturing data when streaming to stdout
	after max wav file size data processed
Date: Fri, 15 Dec 2017 11:31:12 -0600
Message-ID: <0a7101d375ca$80c034c0$82409e40$@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ot0-f175.google.com (mail-ot0-f175.google.com
 [74.125.82.175])
 by alsa0.perex.cz (Postfix) with ESMTP id 496B6266BF5
 for <alsa-devel@alsa-project.org>; Fri, 15 Dec 2017 18:31:15 +0100 (CET)
Received: by mail-ot0-f175.google.com with SMTP id q3so8403069oth.2
 for <alsa-devel@alsa-project.org>; Fri, 15 Dec 2017 09:31:14 -0800 (PST)
Content-Language: en-us
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
Cc: evanbtcohen@gmail.com
List-Id: alsa-devel@alsa-project.org

The github smart-mirror project uses arecord on pi devices to capture user
audio. This is a long running application, 

(I expect my mirror to be on 24/7)

 

Anyhow, after 18 hours, we stop receiving audio data. 

 

 

I have debugged it to the capture routine in aplay.c

 

Basically it is not intended to run forever. 

 

                rest = count;  <---- get the remaining size from the count
total size

                                // don't let the remaining data size be too
big

                                if (rest >
fmt_rec_table[file_type].max_filesize)

                                                rest =
fmt_rec_table[file_type].max_filesize;

                                if (max_file_size && (rest > max_file_size))


                                                rest = max_file_size;

 

                                write the 'file'  header

                                /* setup sample header */

                                if (fmt_rec_table[file_type].start)

 
fmt_rec_table[file_type].start(fd, rest);

 

                                /* capture */

                                fdcount = 0;

                                while (rest > 0 && recycle_capture_file == 0
&& !in_aborting) {

                                                size_t c = (rest <=
(off64_t)chunk_bytes) ?

                                                                (size_t)rest
: chunk_bytes;

                                                size_t f = c * 8 /
bits_per_frame;

                                                if (pcm_read(audiobuf, f) !=
f) {

                                                                in_aborting
= 1;

                                                                break;

                                                }

                                                if (xwrite(fd, audiobuf, c)
!= c) {

 
perror(name);

                                                                in_aborting
= 1;

                                                                break;

                                                }

                                                count -= c; <--- decrement
the file size 

                                                rest -= c;  <---- decement
the remaining data

                                                fdcount += c;

                                }

 

                                Eventually rest AND count will be 0 or less
than 0 (for wav this is 2 gig).

                                Then we loop back up, start another file,
and then while rest >0, it is not any longer

                                Then we loop, and write a new file header,
and then rest <0, so no data capture..

                                                

                                If this is stdout, we should NOT decrement
the rest and size counters.. but let the timelimit and sample limit stop the
outer loop

 

                                while ((file_type == FORMAT_RAW &&
!timelimit && !sampleslimit) || count > 0);

 

so my proposed change is 

 

                                                /* capture */

                                fdcount = 0;

                                while (rest > 0 && recycle_capture_file == 0
&& !in_aborting) {

                                                size_t c = (rest <=
(off64_t)chunk_bytes) ?

                                                                (size_t)rest
: chunk_bytes;

                                                size_t f = c * 8 /
bits_per_frame;

                                                if (pcm_read(audiobuf, f) !=
f) {

                                                                in_aborting
= 1;

                                                                break;

                                                }

                                                if (xwrite(fd, audiobuf, c)
!= c) {

 
perror(name);

                                                                in_aborting
= 1;

                                                                break;

                                                }

                                                If(!stdout){
<---- add this test

                                                                count -= c;
<--- decrement the file size 

                                                                rest -= c;
<---- decement the remaining data

                                                                fdcount +=
c;

                                                }

                                }

 

 

Sam

 

From: "Aaron J. Grier" <agrier@poofygoof.com>
Subject: proper use of snd_mixer_selem_set_capture_switch ?
Date: Thu, 4 Sep 2008 17:57:08 -0700
Message-ID: <20080905005707.GJ5930@arwen.poofy.goof.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.poofygoof.com (209-162-215-114.dq1sn.easystreet.com
	[209.162.215.114])
	by alsa0.perex.cz (Postfix) with ESMTP id 8248824552
	for <alsa-devel@alsa-project.org>;
	Fri,  5 Sep 2008 02:57:13 +0200 (CEST)
Received: from arwen.poofy.goof.com (muzgash.poofy.goof.com [10.0.0.26])
	by smtp.poofygoof.com (Postfix) with ESMTP id A66D529D4
	for <alsa-devel@alsa-project.org>; Thu,  4 Sep 2008 17:57:10 -0700 (PDT)
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

does anyone have a good example or walkthrough how to change capture
sources?  I'm having a heck of a time.

my calls go like this:

/* setup */
snd_mixer_selem_id_alloca
snd_mixer_open
snd_mixer_attach
snd_mixer_selem_register
snd_mixer_load

/* set up PCM element, unused in this example */
snd_mixer_selem_id_set_index
snd_mixer_selem_id_set_name
snd_mixer_find_selem

/* set up Line element (linecapture) */
snd_mixer_selem_id_set_index
snd_mixer_selem_id_set_name
snd_mixer_find_selem

/* set up Mic element (miccapture) */
snd_mixer_selem_id_set_index
snd_mixer_selem_id_set_name
snd_mixer_find_selem

/* here's that part that throws me... I'm trying to sit in a loop and
 * trade capture back and forth between Line and Mic.  code reproduced
 * here verbatim... */

      do
      {
         snd_mixer_selem_channel_id_t chn;
         for (chn = 0; chn <= SND_MIXER_SCHN_LAST; chn++)
         {
            int junk;

            if (snd_mixer_selem_has_capture_channel(linecapture, chn))
            {
               status = snd_mixer_selem_get_capture_switch(linecapture,
                  chn, &junk);
               assert(0 == status);
               printf("line, chn %d, junk %d, ", chn, junk);
               status = snd_mixer_selem_set_capture_switch(linecapture,
                 chn, lineflag);
               printf("set %d\n", lineflag);
               assert(0 == status);
            }

            if (snd_mixer_selem_has_capture_channel(miccapture, chn))
            {
               status = snd_mixer_selem_get_capture_switch(miccapture,
                  chn, &junk);
               printf("mic, chn %d, junk %d, ", chn, junk);
               assert(0 == status);
               status = snd_mixer_selem_set_capture_switch(miccapture,
                  chn, micflag);
               printf("set %d\n", micflag);
               assert(0 == status);
            }
         }

         for (chn = 0; chn <= SND_MIXER_SCHN_LAST; chn++)
         {
            if (snd_mixer_selem_has_capture_channel(linecapture, chn))
            {
               status = snd_mixer_selem_get_capture_switch(linecapture,
                  chn, &lineflag);
               printf("read line, chn %d: %d\n", chn, lineflag);
               assert(0 == status);
            }

            if (snd_mixer_selem_has_capture_channel(miccapture, chn))
            {
               status = snd_mixer_selem_get_capture_switch(miccapture,
                  chn, &micflag);
               printf("read mic, chn %d: %d\n", chn, micflag);
               assert(0 == status);
            }
         }

         if (lineflag)
         {
            lineflag = 0;
            micflag = 1;
         }
         else
         {  
            lineflag = 1;
            micflag = 0;
         }

         getchar();

      } while (1);

I get output like this:

line, chn 0, junk 0, set 1
mic, chn 0, junk 1, set 0
line, chn 1, junk 1, set 1
mic, chn 1, junk 0, set 0
read line, chn 0: 1
read mic, chn 0: 0
read line, chn 1: 1
read mic, chn 1: 0

	[all is well, alsamixer shows LR capture on Line input, smash
	return and go for another loop]

line, chn 0, junk 1, set 0
mic, chn 0, junk 0, set 1
line, chn 1, junk 1, set 0
mic, chn 1, junk 0, set 1
read line, chn 0: 1
read mic, chn 0: 1
read line, chn 1: 1
read mic, chn 1: 1

	[here's where it goes funny.  the "junk" is what I set last
	time, as expected, but the readbacks after the
	set_capture_switch indicate both line and mic are being
	captured?  that's not right.  alsamixer shows LR capture on Mic
	input.  smack return again to see what happens.]

line, chn 0, junk 1, set 0
mic, chn 0, junk 1, set 1
line, chn 1, junk 1, set 0
mic, chn 1, junk 1, set 1
read line, chn 0: 0
read mic, chn 0: 1
read line, chn 1: 1
read mic, chn 1: 1

	[this gets really weird.  we make the same write calls we did
	last time, and now we get back something different?  alsamixer
	shows R Line and L Capture.  screwey.]

I feel I must be missing something obvious, like a flush operation, or
something very simple.  who knew changing a mux could be such an
involved procedure?  (=

-- 
  Aaron J. Grier | "Not your ordinary poofy goof." | agrier@poofygoof.com

From: Francois Gouget <fgouget@codeweavers.com>
Subject: Division by zero in snd_pcm_rate_sw_params()
Date: Sat, 24 Jul 2004 03:30:06 +0200
Sender: wine-devel-admin@winehq.org
Message-ID: <4101BB9E.8010207@codeweavers.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030302090900080801070704"
Return-path: <wine-devel-admin@winehq.org>
Errors-To: wine-devel-admin@winehq.org
List-Unsubscribe: <http://www.winehq.org/mailman/listinfo/wine-devel>,
	<mailto:wine-devel-request@winehq.org?subject=unsubscribe>
List-Post: <mailto:wine-devel@winehq.org>
List-Help: <mailto:wine-devel-request@winehq.org?subject=help>
List-Subscribe: <http://www.winehq.org/mailman/listinfo/wine-devel>,
	<mailto:wine-devel-request@winehq.org?subject=subscribe>
List-Archive: <http://www.winehq.org/hypermail/wine-devel/>
To: alsa-devel@lists.sourceforge.net
Cc: Wine Devel <wine-devel@winehq.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------030302090900080801070704
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I am working on Wine and lately I have been tracking various sound 
related issues. One issue I noticed is a crash in Wine's winmm wave test 
when using the Alsa sound backend.

More precisely:
  * if Wine's winmm wave test is the only application using the sound 
device, then it works
  * but if another application is already using the sound device (e.g. 
xmms), then Wine's winmm wave test crashes when trying to play the 96kHz 
test.

The crash occurs when calling snd_pcm_sw_params():

     EXIT_ON_ERROR( snd_pcm_sw_params(pcm, sw_params), MMSYSERR_ERROR, 
"unable to set sw params for playback");

See this URL for the exact source:
http://source.winehq.org/source/dlls/winmm/winealsa/audio.c#L1602

Digging some more I found out that the division by zero happens in the 
snd_pcm_rate_sw_params() function pcm_rate.c. Here's why:

  * Wine sets xfer_align to 1:
    EXIT_ON_ERROR(snd_pcm_sw_params_set_xfer_align(pcm, sw_params, 1),
                  MMSYSERR_ERROR, "unable to set xfer align");

  * then it calls snd_pcm_sw_params() as shown above

  * eventually we get to snd_pcm_rate_sw_params() in src/pcm/pcm_rate.c. 
(http://cvs.sourceforge.net/viewcvs.py/alsa/alsa-lib/src/pcm/pcm_rate.c?rev=1.83&view=markup)

  * There we call recalc():

    recalc(pcm, &sparams->xfer_align);

  * when more than one application uses the soundcard, recalc() ends up 
doing:

    *val = muldiv_near(*val, slave->period_size, pcm->period_size);

  * however in my case slave->period_size is less than half of 
pcm->period_size so I end up with xfer_align == *val == 0.

  * then, a few lines later in snd_pcm_rate_sw_params() we do:

     if (sparams->start_threshold > (slave->buffer_size /
             sparams->xfer_align) * sparams->xfer_align)
         sparams->start_threshold = (slave->buffer_size /
             sparams->xfer_align) * sparams->xfer_align;

    And we crash with a division by zero because now sparams->xfer_align==0.
    (these lines were added in CVS revision 1.83 of this file)

Simply resetting xfer_align to 1 is it is zero after the call to 
recalc() (see attached patch) fixes the problem for me (no crash and the 
test tone plays correctly). However I don't know if this is the right 
fix, hence the following questions:

Does my patch look ok? What is the proper procedure to get it applied? 
Is there further information I can provide to resolve this issue?

My configuration:
  * Up to date Debian testing
  * Alsa 1.0.5a
  * cat /proc/asound/cards
0 [V8235          ]: VIA8233 - VIA 8235
                      VIA 8235 at 0xbc00, irq 5


-- 
Francois Gouget
fgouget@codeweavers.com


--------------030302090900080801070704
Content-Type: text/plain;
 name="pcm_rate.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pcm_rate.diff"

--- pcm_rate.c.orig	2004-07-24 03:19:41.000000000 +0200
+++ pcm_rate.c	2004-07-24 03:20:41.000000000 +0200
@@ -630,6 +638,8 @@
 	recalc(pcm, &sparams->avail_min);
 	rate->orig_avail_min = sparams->avail_min;
 	recalc(pcm, &sparams->xfer_align);
+	if (sparams->xfer_align==0)
+		sparams->xfer_align=1;
 	recalc(pcm, &sparams->start_threshold);
 	if (sparams->start_threshold <= slave->buffer_size) {
 		if (sparams->start_threshold > (slave->buffer_size / sparams->avail_min) * sparams->avail_min)

--------------030302090900080801070704--

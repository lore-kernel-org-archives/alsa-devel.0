From: Srinivasan S <srinivasan.s@tataelxsi.co.in>
Subject: Re: Alsa issue faced in port audio
Date: Mon, 3 Aug 2015 13:17:34 +0000
Message-ID: <SG2PR04MB0695060A893E2A2E625306C0C3770@SG2PR04MB0695.apcprd04.prod.outlook.com>
References: <SG2PR04MB069577BBCEC38E6B3117CA21C3770@SG2PR04MB0695.apcprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from APC01-PU1-obe.outbound.protection.outlook.com
 (mail-pu1apc01on0133.outbound.protection.outlook.com [104.47.126.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 64FA726061A
 for <alsa-devel@alsa-project.org>; Mon,  3 Aug 2015 15:17:38 +0200 (CEST)
In-Reply-To: <SG2PR04MB069577BBCEC38E6B3117CA21C3770@SG2PR04MB0695.apcprd04.prod.outlook.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Dear All,

Brief description of the problem

Even am facing the same as below issue & am stuck with this issue from many days, could anybody please let me know how did you fix this issue, if possible could you please send me across the patch
 the problem with the capture end-less loop was due to an
overrun condition. The sequence is as follows:

- read calls waitForFrames
- WaitForFrames checks available frames (GetAvailableFrames) that
  returns 0
- WaitForFrames enters Poll while loop for capture
- poll returns
- WaitForFrames calls EndPolling does not detect an error, sets PollCapture
  to false and xrun == 0. EndPoll does not check for available frames.
- WaitForFrames checks for available frames (GetAvailableFrames)
  that detects an overrun and sets xrun (to me it seems that this overrun
  event was the reason to return from poll and EndPoll just checks
  the event source, in this case the capture device).
- WaitForFrames calls handleXrun that recovers the capture stream
  and leaves it in PREPARED state
- return to read
- read did not check xrun, frames available == 0, loop, calls
  WaitForFrames again
- eventually WaitForFrames enters poll while loop. Because of its state the
  ALSA system does not report any event and the poll triggers the
  timeout.
- endPolling does not set xrun, (revents is 0) and does not set
  pollCapture to false and the while loop never terminates.
Kindly do the needful as early as possible
Many Thanks in advance

________________________________________
From: alsa-devel-bounces@alsa-project.org <alsa-devel-bounces@alsa-project.org> on behalf of Srinivasan S <srinivasan.s@tataelxsi.co.in>
Sent: Monday, August 3, 2015 4:48 PM
To: alsa-devel@alsa-project.org
Subject: [alsa-devel] Alsa issue faced in port audio

Dear ALSA Community,


Am running port-audio(pjproject-2.4 & 2.3) on linux kernel version 3.14 & alsa-lib verison 1.0.27, but some how portaudio ALSA handles under/overrun in blocking read/write: it is never reported back to the application: handleXrun tries to recover, usually this works and leaves the stream in STATE_PREPARED.

The xrun flag is set but neither the portaudio ALSA read nor the write methods look at this when they are in the read/write while loop. In case

of playback this causes bad "framesAvail" values. The read funtion enters an endless loop.


In port audio in writeframes for each time for read samples playback/capture poll will happen in this poll(snd_poll_descriptor_revents) we will get read/write event from device in the success case, when Xrun occurs the poll always returns 0 or NULL, which indicates  A value of 0 indicates that the call timed out and no file descriptors were ready.But we traced the source code file descriptor is available & not corrupted


Could you please let us know how this can be fixed in ALSA


Kindly do the needful as early as possible

Srinivasan S

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

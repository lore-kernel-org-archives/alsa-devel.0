From: Carlo Florendo <subscribermail@gmail.com>
Subject: How to get correct midi timings from ALSA using the
	library only
Date: Tue, 24 Jul 2007 17:01:19 +0800
Message-ID: <46A5BFDF.4040906@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.hq.astra.ph (unknown [202.78.101.198])
	by alsa0.perex.cz (Postfix) with ESMTP id 86C682449F
	for <alsa-devel@alsa-project.org>;
	Tue, 24 Jul 2007 11:00:59 +0200 (CEST)
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
Cc: linux-audio-dev@lists.linuxaudio.org
List-Id: alsa-devel@alsa-project.org

Hi,

(1) I've written a command line MIDI sequencer for lightweight systems and 
am successful in making it work using the ALSA queue API.  However, one 
drawback of the API is its lack of callback functions.  I wish to be able 
to track events as they are drained by the queue.

(2) I know and have successfully worked on a work around whereby the 
application itself subscribes to the output port so as to see events as 
they are played.

However, I wish to be able to make the sequencer or player work without the 
use of the ALSA queue nor the workaround in (2).

Here's the pseudo-code of the relevant MIDI player routine:

for (i = 0; i < number_of_events; i++)
{
     usleep(event[i].delta_time_in_microseconds);
     output_and_drain_event(event[i]);
}

This routine gives a non-bearable latency on 2.4 kernels but not so much on 
2.6 kernels.

How could I get the app to <u|nano>sleep() in the most accurate way in 
userspace without using the ALSA queue nor the extra subscription to an 
output port?   Or, is there a drain or output routine that supports 
callbacks?  If so, I will be grateful if you could point them out.  I seem 
not to find any output callback routine under the docs.

Thank you very much.

Best Regards,

Carlo

-- 
Carlo Florendo
Softare Engineer/Network Co-Administrator
Astra Philippines Inc.
UP-Ayala Technopark, Diliman 1101, Quezon City
Philippines
http://www.astra.ph

--
The Astra Group of Companies
5-3-11 Sekido, Tama City
Tokyo 206-0011, Japan
http://www.astra.co.jp

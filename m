From: Tobias Peters <tpeters@uni-oldenburg.de>
Subject: hw_pointer error message triggered without need
Date: Tue, 21 Oct 2003 17:37:30 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F9552BA.1020404@uni-oldenburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

I'm using linux-2.4.22 with alsa drivers 0.9.7c. Sound card driver in 
use was intel 8x0 (but I doubt it's responsible in this case).

ALSA ../alsa-kernel/core/pcm_lib.c:216: Unexpected hw_pointer value
(stream = 0, delta: -255, max jitter = 256): wrong interrupt acknowledge?

If I understand the relevant code correctly, then this error message is 
triggered unnecessarily if the hardware buffer is only two periods in 
size.  It is triggered when the hardware pointer has already been 
increased by one sample since the last period completed.

Not so if there are more periods per buffer.

   Tobias





-------------------------------------------------------
This SF.net email is sponsored by OSDN developer relations
Here's your chance to show off your extensive product knowledge
We want to know what you know. Tell us and you have a chance to win $100
http://www.zoomerang.com/survey.zgi?HRPT1X3RYQNC5V4MLNSV3E54

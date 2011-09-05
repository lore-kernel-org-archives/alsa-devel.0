From: "Nallasellan, Singaravelan" <singaravelan.nallasellan@intel.com>
Subject: Player Thread is not woken after period elapsed
Date: Mon, 5 Sep 2011 23:08:53 +0530
Message-ID: <3CA6C6D9F70D314CA34352990B57DA1507C420F147@bgsmsx502.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id 507122414A
	for <alsa-devel@alsa-project.org>;
	Mon,  5 Sep 2011 19:39:00 +0200 (CEST)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi,

When I tried to root cause a glitch in the audio playback, I found a weird behavior. 

User thread which invokes the writei function which in turn  invokes a kernel function which waits for the free buffer to write the audio data.  This kernel function adds this thread to a wake(sleep) queue  and calls a schedule_timeout (msecs_to_jiffies(10000)).

When the audio playback of a period is completed, the hardware generates an interrupt. The handler in the path wake_up the thread added to the sleep queue.  Most of the time, the playback thread is woken up.

During this error case, the thread is not getting woken up. However the sleep queue is not empty.  This continues until the playback enter into underrun due to all the periods in the buffer are played back. Audio playback continues after recovery from xrun. 

Will you provide some hint on how to go about identifying the root cause?

Thanks
-Sing

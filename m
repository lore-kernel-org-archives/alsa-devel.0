From: "Niraj Kulkarni" <kulkarniniraj@rediffmail.com>
Subject: Re:
	=?utf-8?q?=5BBug_1155202=5D__=5BIntel_DZ77SL-50K=2C_?=
	=?utf-8?q?Intel_PantherPoint_HDMI=2C_Digital_Out=2C_HDMI=5D_No_sou?=
	=?utf-8?q?nd_at_all?=
Date: 25 Jan 2014 05:56:25 -0000
Message-ID: <1390627477.S.24238.autosave.drafts.old.1390629385.4357@webmail.rediffmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rediffmail.com (f4mail-235-81.rediffmail.com [202.137.235.81])
 by alsa0.perex.cz (Postfix) with SMTP id 7D7EF2654C0
 for <alsa-devel@alsa-project.org>; Sat, 25 Jan 2014 06:56:29 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, "david.henningsson@canonical.com" <david.henningsson@canonical.com>, alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

&gt;This is doubtful. Here we see the behavior of the PCI controller, and

&gt;there shouldn't be difference by CPU instructions.



&gt;The difference in the code between azx_reset() and your code are:



&gt;- Use of azx_writeb() and azx_writel()

&gt;- Limited loop time for GCTL_RESET bit check

I tried both things. It did not work. So, I tried adding a delay between while loop and reset writel in my code. A few experiments with it shows that delay between reset state and on state determines codec detection. Only a delay of less than 100 uSec results in successful codec detection.
Here is table of my observations:

usleep&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; result 
5-10 &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;ok
50-100 &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; ok
75-100&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; ok
75-150&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; fail
100-200&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; fail
250-500&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; fail
500-1000 &nbsp;&nbsp;&nbsp; fail


Since link_reset_enter and exit have a lot of code in between (atleast greater than 100us) it always results in failure.

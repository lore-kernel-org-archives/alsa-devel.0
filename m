From: "santosh pattar" <santosh.pattar@gmail.com>
Subject: ALSA Programming Query
Date: Thu, 23 Oct 2008 10:06:14 +0530
Message-ID: <19f3dfd10810222136r6f8f9b8fy32a91385b75a6e7a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.171])
	by alsa0.perex.cz (Postfix) with ESMTP id A57BB2439E
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Oct 2008 06:36:32 +0200 (CEST)
Received: by ug-out-1314.google.com with SMTP id 30so1470163ugs.24
	for <alsa-devel@alsa-project.org>; Wed, 22 Oct 2008 21:36:14 -0700 (PDT)
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

Dear All,

I have some doubts on the ALSA programming,

1)My ALSA driver supports minimum Period Bytes size as 32 bytes, but when i
set the period size as 512 bytes it is always setting to 1024 bytes.I am
using the function "snd_pcm_hw_params_set_period_size_near()" . What might
be wrong here?Is the function what i am using correct?

2)How the Library functions and the Driver functions interact, what is the
interface between the library functions and driver functions?Is there any
document which explains this. I got a document which explains how to write
ALSA driver.But it does not mention the interface with the library.

3)How Can we achive MIC and LINEIN switching using the mixer?What library
function do i need to use to achive this?

4)If i want to get the Timestamp for each buffer captured, what library
function should be used?

5)I am trying to capture and play the same audio (ALSA duplex). When i
capture and store it in a file and play from the file i am able to hear the
sound properly. If i capture in a buffer and play the same buffer directly
it says Broken PIPE ERROR in the playout.
 I tried the capture and playout in two different threads, i am able to hear
the sound and i am not getting any Broken PIPE error. But along with the
audio i am hearing some noise.
Do we need to use some kind of synchronisation between the threads for
capture and playout?


Any help on these things is appreciated.
Thank you in advance.

Regards,
santosh

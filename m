From: Irfan shaikh <irfan.shaikh@sasken.com>
Subject: Re: ALSA Underrun / Silence playback
Date: Mon, 5 Dec 2011 17:26:36 +0530
Message-ID: <4EDCB174.9070403@sasken.com>
References: <4EDC674A.4030302@sasken.com> <4EDC9403.3080708@ladisch.de>
	<4EDC9732.1030108@sasken.com> <4EDCA0CC.5030603@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mta-blr1.sasken.com (mta-blr1.sasken.com [203.200.200.72])
	by alsa0.perex.cz (Postfix) with ESMTP id B267B103969
	for <alsa-devel@alsa-project.org>; Mon,  5 Dec 2011 12:59:10 +0100 (CET)
In-Reply-To: <4EDCA0CC.5030603@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 12/05/2011 04:15 PM, Clemens Ladisch wrote:
> Irfan shaikh wrote:
>> >  I have used my threshold as boundary value also and checked the audio
>> >  performance.  I was still getting UNDERRUN's (-32).
> Did you actually call snd_pcm_sw_params()?
Hi thanks a lot for hint provided by you.
It works fine now.
What threshold value is better boundary value OR alsa buffer size value 
for good performance ?

Observation :
I do lot of console operation purposely to get ALSA underrun.
After above implementation i do not see any UNDERRUN.
###### But Audio goes out of sync and playes jerky ? ########
Is there any way we can avoid above jerks ?

xfer_align function is depreciated.



Thanks and regards
Irfan

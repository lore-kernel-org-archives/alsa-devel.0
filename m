From: ranjith vs <ranjithvs@iwavesystems.com>
Subject: While writing to speaker sometimes segmentation fault
	comes.
Date: Fri, 22 Nov 2013 10:51:15 +0530 (IST)
Message-ID: <1750043993.107445.1385097675393.JavaMail.zimbra@iwavesystems.com>
References: <844569205.107413.1385097196700.JavaMail.zimbra@iwavesystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.iwavesystems.com (smtp.iwavesystems.com [124.124.219.236])
 by alsa0.perex.cz (Postfix) with ESMTP id DF04026162E
 for <alsa-devel@alsa-project.org>; Fri, 22 Nov 2013 06:21:58 +0100 (CET)
In-Reply-To: <844569205.107413.1385097196700.JavaMail.zimbra@iwavesystems.com>
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
Cc: krishna ks <krishnaks@iwavesystems.com>
List-Id: alsa-devel@alsa-project.org

Hello,

     I am streaming audio from vlc,in the following formats sampling frequency 44100 stereo 16 bit.On the receiver side receiveing pcm frames
and writing to speaker using alsa interface. But sometimes i'm getting segmentation fault in the snd_pcm_writei function. And one more thing is that eventhough I try to set the buffer size to 4096. It is setting it's own value.But i'm writing the buffer of length which I received from pcm_avail_upadte function.


Thanks & Regards,

Ranjith

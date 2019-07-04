From: Julian Bradfield <jalsa-devel@jcbradfield.org>
Subject: bug in playing 6-channel sound
Date: Thu, 4 Jul 2019 11:46:20 +0100
Message-ID: <23837.55548.631053.741245@vis.stevens-bradfield.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bigv.stevens-bradfield.com (bigv.stevens-bradfield.com
 [IPv6:2001:41c9:1:421::187])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9822CF800E8
 for <alsa-devel@alsa-project.org>; Thu,  4 Jul 2019 12:46:22 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Some five years ago, the following post

https://mailman.alsa-project.org/pipermail/alsa-devel/2014-February/072265.html

reported a failure to play six-channel sound, that could be worked
around by setting the prealloc value for the device to various values
*other than* the default 64. 

I have just run into this playing a movie from my laptop (Thinkpad
Yoga X1, Intel HDA PCH sound card outputting through HDMI) running
Xubuntu 18.04, up to date as at the time of posting.

I see exactly the same problem as in that post, and the same
workaround works for me - I tried prealloc values 63,65,32,128, and
any of them is ok.

I'm a bit baffled that such a problem has survived for several years.

If any developer would like me to provide debugging information,
please get in touch - I have some time available at present, but not
enough to learn ALSA and debug it myself!

I will remain subscribed to the list for a few weeks to read any
followups.

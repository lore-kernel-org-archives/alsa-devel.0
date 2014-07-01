From: "Brandon Yates" <Brandon.Yates@adaptivedigital.com>
Subject: PCM Plugin Channel question
Date: Tue, 1 Jul 2014 18:59:55 -0400
Message-ID: <B02206F4ACA2904A8270028316B8DAFF011CC286@mercury.corp.adaptivedigital.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.bemta12.messagelabs.com (mail1.bemta12.messagelabs.com
 [216.82.251.17])
 by alsa0.perex.cz (Postfix) with ESMTP id 060482650F7
 for <alsa-devel@alsa-project.org>; Wed,  2 Jul 2014 00:59:57 +0200 (CEST)
Content-class: urn:content-classes:message
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
List-Id: alsa-devel@alsa-project.org


Hello, I have developed a pcm ext plugin that applies some processing to the audio stream in the transfer callback.

My plugin works for a mono (1 channel) stream. I'd now like to expand it to support stereo data in the form of 2 channels interleaved.  I can't find much information on how this works.  I have a couple questions that I'd greatly appreciate if anyone could help with.

1) Is there any way in the 'SND_PCM_PLUGIN_DEFINE_FUNC' function that I can determine if the user application has opened the stream with 1 channel vs 2 channel? 

2) I assume in the case of two channels my transfer function would need to: a)deinterleave the data from source so my processing routine can access it in a linear buffer and b) reinterleave the data before I copy it to destination.   Is this correct? Is there more to it or things I am overlooking?

3) For IO-plugin I see there is a `SND_PCM_IOPLUG_HW_ACCESS` value I could use to restrict the stream type to `SND_PCM_ACCESS_RW_INTERLEAVED`.  Does there exist a similar function for External PCM Plugin?

4)Is there some fundamental design idea here I am not grasping?

Thanks much!

Brandon

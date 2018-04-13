From: Robert Tiemann <rtie@gmx.de>
Subject: Sample format changes by plugin while playing
Date: Fri, 13 Apr 2018 13:44:43 +0200
Message-ID: <2f7e073c-b51a-dd7d-af89-9a10872faed1@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 by alsa0.perex.cz (Postfix) with ESMTP id D481C266BBC
 for <alsa-devel@alsa-project.org>; Fri, 13 Apr 2018 13:44:44 +0200 (CEST)
Received: from [192.168.15.101] ([87.245.7.122]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MGS9o-1fBMyZ3Lzk-00DHbg for
 <alsa-devel@alsa-project.org>; Fri, 13 Apr 2018 13:44:43 +0200
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

I have a general question about ALSA plugins: Is it possible for an
ALSA plugin to reconfigure the sample rate and sample format of its
slave in such a way that the software playing through that plugin
wouldn't notice?

That is, given some audio stream, the plugin shall be allowed to
change the sample rate and format based on control data extracted from
the audio data pushed through the plugin. In my imagination, any
output format changes should be completely transparent to the sound
player; the player would always deliver a stream of audio data at a
constant rate, and once in a while the plugin would change the
hardware settings. For sure there would be an audible gap during
reconfiguration, but that would be OK for me.

Now, is this possible at all?

Best regards,
Robert

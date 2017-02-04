From: "Farzan Shojaee" <shojaee@partodadeh.com>
Subject: split stereo channel into two mono channels in driver
Date: Sat, 4 Feb 2017 14:17:36 +0330
Message-ID: <000001d27ed4$1a57e4a0$4f07ade0$@partodadeh.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nov-007-i592.relay.mailchannels.net
 (nov-007-i592.relay.mailchannels.net [46.232.183.146])
 by alsa0.perex.cz (Postfix) with ESMTP id 162B7266972
 for <alsa-devel@alsa-project.org>; Sat,  4 Feb 2017 11:47:44 +0100 (CET)
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 1CDC4181794
 for <alsa-devel@alsa-project.org>; Sat,  4 Feb 2017 10:47:42 +0000 (UTC)
Received: from hp181.hostpapa.com (unknown [100.96.16.202])
 by relay.mailchannels.net (Postfix) with ESMTPA id 366EF180F80
 for <alsa-devel@alsa-project.org>; Sat,  4 Feb 2017 10:47:41 +0000 (UTC)
Received: from [95.82.36.171] (port=53637 helo=Software4)
 by hp181.hostpapa.com with esmtpa (Exim 4.87)
 (envelope-from <shojaee@partodadeh.com>) id 1cZxsY-001s2W-Dy
 for alsa-devel@alsa-project.org; Sat, 04 Feb 2017 11:47:39 +0100
Content-Language: fa
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

I need to modify the driver (I'm not sure, codec driver or platform driver)
so that, have two independent mono channels instead of one stereo channel.
I'm familiar with structure of ASoC drivers, but I really don't know how can
I do it.
Can everybody guide me how can I do it?
Even a general description would be helpful.

Thanks,
Farzan Shojaee

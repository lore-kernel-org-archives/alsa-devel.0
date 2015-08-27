From: David Henningsson <david.henningsson@canonical.com>
Subject: Out-of-tree HDMI audio driver for BayTrail-T
Date: Thu, 27 Aug 2015 08:02:00 +0200
Message-ID: <55DEA7D8.5060106@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id A030A26596B
 for <alsa-devel@alsa-project.org>; Thu, 27 Aug 2015 08:02:01 +0200 (CEST)
Received: from c83-254-133-68.bredband.comhem.se ([83.254.133.68]
 helo=[192.168.8.102])
 by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.76) (envelope-from <david.henningsson@canonical.com>)
 id 1ZUqG9-00029v-5y
 for alsa-devel@alsa-project.org; Thu, 27 Aug 2015 06:02:01 +0000
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I don't usually deal with out-of-tree drivers, but when Canonical 
enabled the Intel Compute Stick [1] (which is using a BayTrail-T 
processor), we were using an out-of-tree driver to enable HDMI audio.

The driver has earlier been made public by Intel [2], and I've put my 
modifications to it here [3].

Unfortunately, it looks like the effort and hardware knowledge required 
to make this driver upstreamable is beyond what I can currently manage.

Also, I cannot answer for whether or not other parties (such as Intel) 
plan to upstream the driver.

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic

[1] 
http://www.intel.com/content/www/us/en/compute-stick/intel-compute-stick.html

[2] https://github.com/01org/baytrailaudio

[3] 
http://kernel.ubuntu.com/git/diwic/baytrail-hdmi-audio.git/log/?h=baytrail-T-hdmi-audio 

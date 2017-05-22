From: Tim <tedon@rogers.com>
Subject: HR timer 1000Hz limit since kernel 4.4.0-77
Date: Mon, 22 May 2017 12:30:27 -0400
Message-ID: <990803c6-b19a-a694-d28f-abfd8b19582e@rogers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nm18-vm0.bullet.mail.bf1.yahoo.com
 (nm18-vm0.bullet.mail.bf1.yahoo.com [98.139.213.138])
 by alsa0.perex.cz (Postfix) with ESMTP id 86BB4266E84
 for <alsa-devel@alsa-project.org>; Mon, 22 May 2017 18:30:29 +0200 (CEST)
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

Hello, ever since kernel 4.4.0-77, there seems to be
  a limit on the ALSA HR timer, I can't set it above 1000Hz
  (snd_timer_params() fails with -22 invalid argument).
I used to be able to set the rate much higher than that.
Been observed in two completely different distros, one with
  a much newer kernel. How can I overcome this limit?
Thanks.

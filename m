From: Henrik Grunell <henrik.grunell@gipscorp.com>
Subject: snd_device_name_hint destroys the config
Date: Mon, 30 Mar 2009 02:00:53 -0700
Message-ID: <B48CF2594DDE184383071A6BF4E46F2D9FB696A488@EXVMBX015-5.exch015.msoutlookonline.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EXHUB015-4.exch015.msoutlookonline.net
	(exhub015-4.exch015.msoutlookonline.net [207.5.72.96])
	by alsa0.perex.cz (Postfix) with ESMTP id 10774103802
	for <alsa-devel@alsa-project.org>;
	Mon, 30 Mar 2009 11:00:57 +0200 (CEST)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

After I've called snd_device_name_hint the configuration seems destroyed. I can no longer access (open) e.g. "default" and "pulse" pcms. As a test, I took the pcm_list function in aplay and put it in my application. The second (and following) call(s) shows that devices are missing compared to the first call. I use Ubuntu 8.10 (1.0.17) and I see the same behavior on Fedora 7 (1.0.14). Is this a known issue? I haven't found anything searching on this.

Thanks,
Henrik

________________________________
CONFIDENTIALITY NOTE: This e-mail message, including any attachment(s), contains information that may be confidential, protected by the attorney-client or other legal privileges, and/or proprietary non-public information. If you are not an intended recipient of this message or an authorized assistant to an intended recipient, please do not read, copy, use or disclose this communication and notify the sender immediately. It should be noted that any review, retransmission, dissemination or other use of, or taking action or reliance upon, this information by persons or entities other than the intended recipient is prohibited.

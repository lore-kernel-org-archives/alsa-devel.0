From: Steve Longerbeam <stevel@embeddedalley.com>
Subject: non-interleaved mode
Date: Tue, 10 Jul 2007 11:08:01 -0700
Message-ID: <4693CB01.5060804@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp104.biz.mail.mud.yahoo.com (smtp104.biz.mail.mud.yahoo.com
	[68.142.200.252]) by alsa0.perex.cz (Postfix) with SMTP id ACCD124347
	for <alsa-devel@alsa-project.org>;
	Tue, 10 Jul 2007 20:08:19 +0200 (CEST)
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

Hi,

The driver for the sound engine I'm working on requires NONINTERLEAVED. 
Will ALSA core give my driver a full period of left-only samples, 
followed by a full period of right-only samples? Or are left/right 
samples split within a single period (ie. first half of period is left 
samples, second half is right samples)?

Thanks,
Steve

From: Paul Dugas <paul@dugasenterprises.com>
Subject: Timing Info
Date: Fri, 11 Jun 2010 18:00:54 -0400
Message-ID: <AANLkTil1tGrkCdRt1s9AZ8eWYG55hYrPOCq6TRaEhpRK@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog106.obsmtp.com (na3sys009aog106.obsmtp.com
	[74.125.149.77]) by alsa0.perex.cz (Postfix) with SMTP id E385E1039DA
	for <alsa-devel@alsa-project.org>;
	Sat, 12 Jun 2010 00:01:00 +0200 (CEST)
Received: by wyb40 with SMTP id 40so1454161wyb.33
	for <alsa-devel@alsa-project.org>; Fri, 11 Jun 2010 15:00:54 -0700 (PDT)
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

I'm using snd_pcm_readi() to collect samples and am wondering if/how I
can get accurate timestamps for them.  Seems like the snd_pcm_status()
gives me this info but I'm unclear on the specifics.  Can someone
point me toward the correct field in the status structure that I
should be using and what sample that timestamp corresponds to?

Does snd_pcm_status_get_tstamp() get me the timestamp for the first
frame returned by the next snd_pcm_readi() call?


P

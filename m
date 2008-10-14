From: "naveen krishna ch" <naveenkrishna.ch@gmail.com>
Subject: OMAP3EVM ASOC TWL4030 Audio drivers
Date: Tue, 14 Oct 2008 11:26:30 +0530
Message-ID: <ef0d8a250810132256i5c3b7f01k69132674df713500@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from po-out-1718.google.com (po-out-1718.google.com [72.14.252.157])
	by alsa0.perex.cz (Postfix) with ESMTP id 61109243B1
	for <alsa-devel@alsa-project.org>;
	Tue, 14 Oct 2008 07:56:50 +0200 (CEST)
Received: by po-out-1718.google.com with SMTP id b23so3247348poe.2
	for <alsa-devel@alsa-project.org>; Mon, 13 Oct 2008 22:56:31 -0700 (PDT)
Content-Disposition: inline
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

Hi All,

I am using OMAP3 EVM + TWL4030 combination.
The ASOC drivers this combination seems to work half way.

My problem is when i do a
aplay ***.wav it plays fine

but when i try to record through the line in with
arecord -c 2 -r 8000 -f 8000 -d 10 -t wav record.wav
command it does not record any thing.

I have used the Gumstix Overo sources as a reference for making the Asoc
sources for this combination.

Can any one tell me how can i solve this issue.

-- 
Thanks,
keep smiling...
keep winning...

(: Naveen Krishna Ch :)

From: Michael Qiu <fallwind@gmail.com>
Subject: About audio driver architecture
Date: Tue, 19 Jan 2010 15:26:06 +0800
Message-ID: <f74f98341001182326s1c03d5e2va470207ff194c2ad@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f196.google.com (mail-yx0-f196.google.com
	[209.85.210.196])
	by alsa0.perex.cz (Postfix) with ESMTP id 6D764244C1
	for <alsa-devel@alsa-project.org>; Tue, 19 Jan 2010 08:26:08 +0100 (CET)
Received: by yxe34 with SMTP id 34so1259249yxe.16
	for <alsa-devel@alsa-project.org>; Mon, 18 Jan 2010 23:26:06 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,
  I'm going to write an audio driver for a developping soc used for
dvb set top box.
As I've never done such things before, so I've some questions.
1. Seems the "ALSA Driver Documentation" is mainly for PCI(and for PC)
based audio card. Where can I got a document for SOC which has no PCI
bus. If there are some existing drivers it will be even better.
2. Is there any standard for such a audio driver which upper
applications will depend on it? Or I can just follow ALSA?

Best regards
Michael Qiu

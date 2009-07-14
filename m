From: jassi brar <jassisinghbrar@gmail.com>
Subject: New Audio Driver Design
Date: Tue, 14 Jul 2009 13:52:12 +0900
Message-ID: <1b68c6790907132152pbfc1995k3be854627cb77f3e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f177.google.com (mail-yx0-f177.google.com
	[209.85.210.177])
	by alsa0.perex.cz (Postfix) with ESMTP id DBDAB24651
	for <alsa-devel@alsa-project.org>;
	Tue, 14 Jul 2009 06:52:13 +0200 (CEST)
Received: by yxe7 with SMTP id 7so4527343yxe.16
	for <alsa-devel@alsa-project.org>; Mon, 13 Jul 2009 21:52:12 -0700 (PDT)
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

Hello,
  I am to write an ALSA driver for my SOC which has a dedicated DSP
subsystem which can
be loaded with decoder instructions and parameteres, and then we load it
with encoded data. The dsp then decodes the data and sends it to the PCM
controller.

Could someone please refer me to some similar driver/codec which already
does that?
If not, how should i design the driver?
    :- Should I load the encoder inst/params using firmware API? Then, which
API should I use to submit encoded data to the DSP?

Any pointers please?

Thanks.

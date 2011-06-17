From: =?ISO-8859-2?Q?MIroslav_Du=B9ek?= <mirda.dusi@gmail.com>
Subject: WM8731 set sample rate
Date: Fri, 17 Jun 2011 12:39:15 +0200
Message-ID: <BANLkTinU5Lqd-yBC95juC4-NQOGw8SeJKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pv0-f179.google.com (mail-pv0-f179.google.com
	[74.125.83.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 09BF6103A6A
	for <alsa-devel@alsa-project.org>;
	Fri, 17 Jun 2011 12:39:16 +0200 (CEST)
Received: by pvg18 with SMTP id 18so955765pvg.38
	for <alsa-devel@alsa-project.org>; Fri, 17 Jun 2011 03:39:15 -0700 (PDT)
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

Hi all,

I am using  processor S3C2416 as master and WM8731 as slave and I am trying
to set right sample rate of ADC DAC data between them. I set I2S clock to
EPLL output (96MHz) , and I   mainly  need calculate 8KHz sample rate. In
user manual of S3C2416 is poor explanation of clocking I2S bus. What is
BCLKMaster and where can I set 1/M ratio and (Figure 23-2 in UM rev 1.3
S3C2416) ??  What exactly means values in registers (BFS, RFS) ??Is
Re-scaler set by IIS_PSR really 1 / N rescaller in Figure 23-2 in UM rev 1.3
S3C2416.

Thanks for any help.

Mirek

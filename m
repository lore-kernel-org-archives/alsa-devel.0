From: Amit Nagal <helloin.amit@gmail.com>
Subject: periods_max initialization in snd_usb_hardware
Date: Wed, 27 Jun 2012 11:24:02 +0530
Message-ID: <CA+F9FsDoX=X14qpzgoH+Fm8oEq8f36fwa02J1fQTD9eqbCnVSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f179.google.com (mail-qc0-f179.google.com
	[209.85.216.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 53D0224543
	for <alsa-devel@alsa-project.org>;
	Wed, 27 Jun 2012 07:54:03 +0200 (CEST)
Received: by qcse14 with SMTP id e14so381656qcs.24
	for <alsa-devel@alsa-project.org>; Tue, 26 Jun 2012 22:54:02 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, alsa-user@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi ,

snd_usb_hardware is defined in sound/usb/pcm.c as :
static struct snd_pcm_hardware snd_usb_hardware =
{
                 .....
	.buffer_bytes_max =	1024 * 1024,
	.period_bytes_min =	64,
	.period_bytes_max =	512 * 1024,
	.periods_min =	2,
	.periods_max =	1024,
};

here periods_max is intialized with value = 1024 .

but going by buffer_bytes_max and period_bytes_min value defined above ,
periods_max = ( buffer_bytes_max / period_bytes_min ) = 16384 .

why this upper cap of  1024 is maintained for  periods_max even though from
calculation it comes as 16384 ?



Thanx & Regards
Amit Nagal

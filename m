From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: Cross compiling alsa-lib (again)
Date: Mon, 07 Jan 2008 11:47:37 +0100
Message-ID: <1199702857.17059.1229845735@webmail.messagingengine.com>
References: <8b67d60801061542o2673384oad87e11bd56012d4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4.smtp.messagingengine.com (out4.smtp.messagingengine.com
	[66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id D783524888
	for <alsa-devel@alsa-project.org>; Mon,  7 Jan 2008 11:47:37 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <8b67d60801061542o2673384oad87e11bd56012d4@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Adrian McMenamin <lkmladrian@gmail.com>, alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Adrian McMenamin wrote:
> $ aplay -D hw:0,0 /aine-email.wav
> Playing WAVE '/aine-email.wav' : Unsigned 8 bit, Rate 8000 Hz, Mono
> aplay: set_params:895: Access type not available

This error message indicates that:
1) the "hw" plugin was found, i.e., the configuration files are installed
   correctly and are found by alsa-lib; and
2) the driver apparently didn't set the SNDRV_PCM_INFO_INTERLEAVED flag.


HTH
Clemens

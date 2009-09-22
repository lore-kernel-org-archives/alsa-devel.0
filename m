From: =?ISO-8859-1?Q?Michel_M=FCller?= <mimu0006@stud.fh-kl.de>
Subject: (AT91RM2000 - ARM) Driver that puts data over SSC to
	FPGA
Date: Tue, 22 Sep 2009 15:04:51 +0200
Message-ID: <4AB8CB73.7060708@stud.fh-kl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from post.fh-kl.de (post.fh-kl.de [143.93.17.200])
	by alsa0.perex.cz (Postfix) with ESMTP id 85E052414C
	for <alsa-devel@alsa-project.org>;
	Tue, 22 Sep 2009 15:04:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by post.fh-kl.de (Postfix) with ESMTP id 377A6240727B
	for <alsa-devel@alsa-project.org>;
	Tue, 22 Sep 2009 15:04:57 +0200 (CEST)
Received: from post.fh-kl.de ([127.0.0.1])
	by localhost (post.fh-kl.de [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id eFXj5O1BzLNJ for <alsa-devel@alsa-project.org>;
	Tue, 22 Sep 2009 15:04:52 +0200 (CEST)
Received: from [10.0.23.167] (aoip1.informatik.fh-kl.de [143.93.17.33])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by post.fh-kl.de (Postfix) with ESMTPSA id 7F3AB24023FD
	for <alsa-devel@alsa-project.org>;
	Tue, 22 Sep 2009 15:04:52 +0200 (CEST)
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

I am trying to write an ALSA-driver that puts the audio data over the 
SSC channel to the FPGA. This FPGA routes the Data to the AD/DA chips.

I tried to figure out how I can do this with the ASoC Interfaces but I 
am currently stuck. Currently there is an Atmel SSC and PCM Interface 
that I can probably use. If I want to use the ASoC API I need to have a 
Codec Driver. But I don't have direct access to the codec.

How should I proceed? I have 2 possibilities I think: Writing a Codec 
Driver / Writing an Alsa Driver as described in the guide of Takashi Iwai.

If I write a character device that transfers data to the FPGA over the 
SSC I can hear sound, but I want to use ALSA because the use of audio 
applications will be easy and flexible.

Thank you in advance!

Regards,
Michel

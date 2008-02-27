From: "Dustin Kerstein" <dustobub@gmail.com>
Subject: HDMI Multichannel LPCM/RAW Support/Status
Date: Tue, 26 Feb 2008 21:11:17 -0500
Message-ID: <001201c878e6$0a8245a0$1f86d0e0$@com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.240])
	by alsa0.perex.cz (Postfix) with ESMTP id 64E27246A2
	for <alsa-devel@alsa-project.org>; Wed, 27 Feb 2008 03:11:29 +0100 (CET)
Received: by an-out-0708.google.com with SMTP id c36so510427ana.80
	for <alsa-devel@alsa-project.org>; Tue, 26 Feb 2008 18:11:22 -0800 (PST)
Content-Language: en-us
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

I was just curious if there is any planned support for multichannel LPCM/Raw
audio for newer HDMI based chipsets. There are several matx boards with HDMI
1.1 and above compliance, which means they should be able to pass 8-channel
LPCM audio. Also, in HDMI 1.3 and above, Bit Stream passing is supported,
which actually should be easier, bandwidth wise, than LPCM. Multichannel PCM
(above 2 channels) was never an issue because SPDIF lacked the bandwidth.
After talking with some people in irc it seems as though the # of channels
setting in Alsa is only one bit. Thanks.


Dustin

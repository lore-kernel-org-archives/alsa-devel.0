From: "Harsha priya gupta" <harshapriya@gmail.com>
Subject: HW decoding abstracted in ALSA
Date: Mon, 25 Feb 2008 12:27:00 +0530
Message-ID: <827ad74d0802242257u604e47d7sb844a29e2bcd1c3b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.176])
	by alsa0.perex.cz (Postfix) with ESMTP id 50143244AA
	for <alsa-devel@alsa-project.org>; Mon, 25 Feb 2008 07:57:01 +0100 (CET)
Received: by wa-out-1112.google.com with SMTP id m33so1507307wag.8
	for <alsa-devel@alsa-project.org>; Sun, 24 Feb 2008 22:57:00 -0800 (PST)
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

Hi,

I am new to ALSA and audio stack in Linux. I have a sound card that can do
HW decoding as well. I am looking at writing an ALSA driver such that
whatever may be the player or MMF above, it should use the HW decoder and
not the inherit SW decoder that is available with the player.

Can someone help me with some pointers or existing like-drivers?

Thanks in advance,
Harsha

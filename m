From: AlGrenadine <a.granvaud@gmail.com>
Subject: opening rawmidi on user ports
Date: Tue, 12 Mar 2019 17:19:38 +0100
Message-ID: <9c82e740-a327-3809-875c-3eb4f01945e8@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D28F9F89693
 for <alsa-devel@alsa-project.org>; Tue, 12 Mar 2019 17:19:41 +0100 (CET)
Received: by mail-wr1-x436.google.com with SMTP id o9so3355387wrv.9
 for <alsa-devel@alsa-project.org>; Tue, 12 Mar 2019 09:19:41 -0700 (PDT)
Received: from [192.168.1.23] (lfbn-1-2324-194.w90-78.abo.wanadoo.fr.
 [90.78.135.194])
 by smtp.gmail.com with ESMTPSA id o18sm31153915wrg.40.2019.03.12.09.19.39
 for <alsa-devel@alsa-project.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 12 Mar 2019 09:19:39 -0700 (PDT)
Content-Language: fr
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,
I use btmidi-server from the bluez stack, which creates user ports to 
send and receive midi via bluetooth.
I can't manager which parameter string i must provide to 
snd_rawmidi_open function, can you help ?

(of course the user ports don't appear in amidi -l)
I only have a client and port ids (128:0) when using aconnect -l

Thanks

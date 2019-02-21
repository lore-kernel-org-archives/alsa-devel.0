From: Rajagopal Aravindan <a.rajagopal.81@gmail.com>
Subject: Playback samples at a specific time on Intel HDA
Date: Fri, 22 Feb 2019 00:49:24 +0530
Message-ID: <CAEQQSVuKc-vZKaeg9xUmYpnBYfsCZYLpr5AkpA26KysUZLe_Vg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 13256F80786
 for <alsa-devel@alsa-project.org>; Thu, 21 Feb 2019 20:19:56 +0100 (CET)
Received: by mail-lj1-x230.google.com with SMTP id q128so24929784ljb.11
 for <alsa-devel@alsa-project.org>; Thu, 21 Feb 2019 11:19:56 -0800 (PST)
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

Hello,

I am trying to accomplish synchronized audio playback using ALSA &
gPTP, on an Intel SkyLake platform have Intel HDA.

I do understand that, starting with SkyLake platform, there is support
for querying link time.
But, how do I instruct to play the samples at a given (gPTP) time ?
Is this possible ?
Can someone please point me to code or doc, relevant to my goal ?
In essence, I would like to play the samples at the stroke of a given
(gPTP) time.

Also, the ALSA page says ...
"The link time can be directly measured if supported in hardware by
sample counters or wallclocks (e.g. with HDAudio 24MHz or PTP clock
for networked solutions)"

What is the connection between PTP clock and sound card here,
are there sound cards that can latch on to a PTP clock on a NIC or what ?

Thanks in advance.

Regards,
Rajagopal

From: Robert von Chamier <whrobbr1986@gmail.com>
Subject: amdtp: syt handling
Date: Sun, 3 Mar 2013 14:56:59 +0100
Message-ID: <CAOiRfSVz5u866Zv46DKO6DkVkWyn9aVcvLOrMoz1PQyTDVomHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f195.google.com (mail-wi0-f195.google.com
 [209.85.212.195])
 by alsa0.perex.cz (Postfix) with ESMTP id 538AA261701
 for <alsa-devel@alsa-project.org>; Sun,  3 Mar 2013 14:57:00 +0100 (CET)
Received: by mail-wi0-f195.google.com with SMTP id l13so504526wie.6
 for <alsa-devel@alsa-project.org>; Sun, 03 Mar 2013 05:57:00 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello,
i am working on the firewire amdtp module. My aim is to add the capture
functionality. Already in my prototype the module captures up to 192k
sampling rate.
But ... How i have to handle the syt in the CIP packages?

Do i compare the syt with the corresponding cycle?
or ...
Do i take the syt as timestamp for alsa? Is it possible to commit a
timestamp to alsa for the corresponding samples?

Can you help me?

Robert

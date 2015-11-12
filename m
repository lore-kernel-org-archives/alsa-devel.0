From: Ankhit Vivekananda <ankhit.vivekananda@biscotti.com>
Subject: Configuring McBSP word length for ICS-43432
Date: Thu, 12 Nov 2015 10:20:18 -0600
Message-ID: <CACaQK7B+iML+DAVMvW5ynRkAoGZ_C1DDC=eVZ2WrnxOx9aZbAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f44.google.com (mail-wm0-f44.google.com [74.125.82.44])
 by alsa0.perex.cz (Postfix) with ESMTP id D515E2606B7
 for <alsa-devel@alsa-project.org>; Thu, 12 Nov 2015 17:20:19 +0100 (CET)
Received: by wmww144 with SMTP id w144so95642004wmw.0
 for <alsa-devel@alsa-project.org>; Thu, 12 Nov 2015 08:20:19 -0800 (PST)
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

I am trying to configure ICS-43432 MEMS mic with TM320DM365 processor's
McBSP interface. The data sheet for ICS-43432 says that it outputs 24-bits
data, i.e., 24 bit word length, but requires 64SCK cycles. Does this mean
the word length (RWDLEN1 bit in RCR register) for McBSP should be set to
32-bits or 24-bits?

Thank you,
Ankhit

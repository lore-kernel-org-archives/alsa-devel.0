From: Paul Pawlowski <mrarmdev@gmail.com>
Subject: Writing /usr/share/alsa/cards/ files
Date: Fri, 2 Aug 2019 14:53:52 +0200
Message-ID: <CAKSqxP-f+4KCUU79prHaLi2--3H8jAA9iXYxK-EoA8oQKNv=XA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E1114F80214
 for <alsa-devel@alsa-project.org>; Fri,  2 Aug 2019 14:54:03 +0200 (CEST)
Received: by mail-ed1-x530.google.com with SMTP id d4so72334414edr.13
 for <alsa-devel@alsa-project.org>; Fri, 02 Aug 2019 05:54:03 -0700 (PDT)
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
Is there any documentation on writing /usr/share/alsa/cards/ files? I
painfully tried to create one in order to enable 2 separate audio outputs,
but I ultimately failed to due to the lack of any sort of error reporting.
Is there a way to enable any error reporting when parsing these files? It
seems that the error output when parsing any hooks goes to nowhere.

Also, is this the correct mailing list to get help regarding alsa driver
development and configuration?

Thank you,
Paul Pawlowski

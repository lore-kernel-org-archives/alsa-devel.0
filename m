From: ranjith vs <ranjithvs@iwavesystems.com>
Subject: Getting Error While cross compiling to arm linux
Date: Wed, 30 Oct 2013 11:50:46 +0530 (IST)
Message-ID: <1665954872.64371.1383114046175.JavaMail.zimbra@iwavesystems.com>
References: <2067000456.64354.1383113803719.JavaMail.zimbra@iwavesystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.iwavesystems.com (unknown [124.124.219.236])
 by alsa0.perex.cz (Postfix) with ESMTP id 648F82625D2
 for <alsa-devel@alsa-project.org>; Wed, 30 Oct 2013 07:21:33 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by smtp.iwavesystems.com (Postfix) with ESMTP id 2D6571E2601
 for <alsa-devel@alsa-project.org>; Wed, 30 Oct 2013 11:50:47 +0530 (IST)
Received: from smtp.iwavesystems.com ([127.0.0.1])
 by localhost (smtp.iwavesystems.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id AK6YRqZn7OmN for <alsa-devel@alsa-project.org>;
 Wed, 30 Oct 2013 11:50:46 +0530 (IST)
Received: from localhost (localhost [127.0.0.1])
 by smtp.iwavesystems.com (Postfix) with ESMTP id 70A7A1E2B5D
 for <alsa-devel@alsa-project.org>; Wed, 30 Oct 2013 11:50:46 +0530 (IST)
Received: from smtp.iwavesystems.com ([127.0.0.1])
 by localhost (smtp.iwavesystems.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id Bta1E64zZdUE for <alsa-devel@alsa-project.org>;
 Wed, 30 Oct 2013 11:50:46 +0530 (IST)
Received: from smtp.iwavesystems.com (smtp.iwavesystems.com [124.124.219.236])
 by smtp.iwavesystems.com (Postfix) with ESMTP id 4D8DB1E2601
 for <alsa-devel@alsa-project.org>; Wed, 30 Oct 2013 11:50:46 +0530 (IST)
In-Reply-To: <2067000456.64354.1383113803719.JavaMail.zimbra@iwavesystems.com>
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

hi,

   I want to cross compile alsa-lib to arm-linux platform.But I Cross compiled successfully but while giving make it is giving following errors


./opt/freescale/usr/local/gcc-4.6.2-glibc-2.13-linaro-multilib-2011.12/fsl-linaro-toolchain/bin/../lib/gcc/arm-fsl-linux-gnueabi/4.6.2/../../../../arm-fsl-linux-gnueabi/bin/ld: .libs/conf.o: Relocations in generic ELF (EM: 3)
.libs/conf.o: could not read symbols: File in wrong format
collect2: ld returned 1 exit status
make[2]: *** [libasound.la] Error 1
make[2]: Leaving directory `/home/ranjithvs/Downloads/alsa-lib-1.0.27.2/src'
make[1]: *** [all-recursive] Error 1
make[1]: Leaving directory `/home/ranjithvs/Downloads/alsa-lib-1.0.27.2/src'
make: *** [all-recursive] Error 1

Regards,

Ranjith

From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Alsa-lib 32-bit on 64-bit machine
Date: Tue, 21 Oct 2014 19:12:21 +0100
Message-ID: <201410211912.21662.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.ip07ir2.opaltelecom.net (out1.ip07ir2.opaltelecom.net
 [62.24.128.243])
 by alsa0.perex.cz (Postfix) with ESMTP id 0F3BC26061D
 for <alsa-devel@alsa-project.org>; Tue, 21 Oct 2014 20:12:15 +0200 (CEST)
Content-Disposition: inline
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
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Hi,

I've tried to find info or examples of this on the web, but to no avail.

What is the recommended way to build Alsa-lib on a 64-bit machine to create 
the additional alternative 32-bit libraries for compatibility with 32-bit 
applications?

The original distro (in this case a Suse Enterprise) has them, but standard 
'./configure make install' only builds the 64-bit variants.  I only succeeded 
by explicitly adding CFLAGS, and wondered if it should work using configure 
options, or another way?  I'm also not sure exactly which flags should be set 
with that method (m32, march=i686 others?).  Does anyone know how it is done 
in the Suse builds?

Thanks,

Alan

From: Ricardo Biehl Pasquali <pasqualirb@gmail.com>
Subject: Re: [PATCH v6 0/3] ALSA: pcm: anonymous dup
	implementation
Date: Tue, 5 Feb 2019 16:24:45 -0200
Message-ID: <20190205182444.GA20812@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qt1-f195.google.com (mail-qt1-f195.google.com
 [209.85.160.195])
 by alsa0.perex.cz (Postfix) with ESMTP id CDDB12666B3
 for <alsa-devel@alsa-project.org>; Tue,  5 Feb 2019 19:24:54 +0100 (CET)
Received: by mail-qt1-f195.google.com with SMTP id 2so4964455qtb.5
 for <alsa-devel@alsa-project.org>; Tue, 05 Feb 2019 10:24:54 -0800 (PST)
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
To: perex@perex.cz
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

What about file sealing?

See:

Jonathan Corbet's article about sealed files (2014-04-09).
<https://lwn.net/Articles/593918/>.

Theodore Ts'o reply to file sealing patch suggesting an
implementation on VFS (2014-03-20).
Re: [PATCH 0/6] File Sealing & memfd_create()
<https://lwn.net/Articles/593963/>.

	pasquali

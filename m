From: Weedy <weedy2887@gmail.com>
Subject: Re:
	=?utf-8?q?Segfaults_in_snd=5Fpcm=5Farea=5Fsilence=28?=
	=?utf-8?q?=29_when_using_softvol?=
Date: Sun, 18 May 2014 15:02:17 +0000 (UTC)
Message-ID: <loom.20140518T165909-667@post.gmane.org>
References: <1350474892.6596.24.camel@x230>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from plane.gmane.org (plane.gmane.org [80.91.229.3])
 by alsa0.perex.cz (Postfix) with ESMTP id 6D07E264FEB
 for <alsa-devel@alsa-project.org>; Sun, 18 May 2014 18:05:06 +0200 (CEST)
Received: from list by plane.gmane.org with local (Exim 4.69)
 (envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1Wm3aC-0005BM-Ur
 for alsa-devel@alsa-project.org; Sun, 18 May 2014 18:05:05 +0200
Received: from 76-10-148-61.dsl.teksavvy.com ([76.10.148.61])
 by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Sun, 18 May 2014 18:05:04 +0200
Received: from weedy2887 by 76-10-148-61.dsl.teksavvy.com with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Sun, 18 May 2014 18:05:04 +0200
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

Tanu Kaskinen <tanuk <at> iki.fi> writes:
> https://bugs.freedesktop.org/show_bug.cgi?id=51060
> > I've had this problem too and the problem only occurs with
> > -ftree-vectorize.
> > 
> > It looks to me as if this is a gcc bug, as it produces a "movdqa" or
> > "vmovdqa" instruction which is used with an unaligned pointer.


I want to point out this is still broken.
alsa-lib 1.0.27.2
gcc 4.8.2

(holy crap gmane, how much more do I have to prune. Just let me post)

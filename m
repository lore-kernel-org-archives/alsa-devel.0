From: Michael Pinnell <mike.pinnell@gmail.com>
Subject: Raspberry Pi - asound/proc/status - state parameter
	always set to RUNNING?
Date: Wed, 20 Dec 2017 00:10:41 +0000
Message-ID: <CA+Ggjo1GsgZJUOo--fbZae_0LxVCWNdkd5SAz=6e4uaLYGcCaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f172.google.com (mail-yw0-f172.google.com
 [209.85.161.172])
 by alsa0.perex.cz (Postfix) with ESMTP id 7BEDB266E43
 for <alsa-devel@alsa-project.org>; Wed, 20 Dec 2017 01:11:03 +0100 (CET)
Received: by mail-yw0-f172.google.com with SMTP id m129so1144440ywb.11
 for <alsa-devel@alsa-project.org>; Tue, 19 Dec 2017 16:11:03 -0800 (PST)
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

Hi all, I was passed thi smailing list info in this github issue..

https://github.com/opensrc/alsa/issues/26#issuecomment-352616858

Basically, I'm working on a raspberry pi and need to know when sound is
playing or not, and I'm trying to use the status file's state parameter to
determine when this is.  It seems however that my state parameter is always
set to RUNNING and has an owner_pid even though that pid is not showing up
in ps.

Any ideas what may be causing this and how to rectify?

Thanks, any help would be much appreciated.

Regards,
Mike.

<http://www.avg.com/email-signature?utm_medium=email&utm_source=link&utm_campaign=sig-email&utm_content=webmail>
Virus-free.
www.avg.com
<http://www.avg.com/email-signature?utm_medium=email&utm_source=link&utm_campaign=sig-email&utm_content=webmail>
<#DAB4FAD8-2DD7-40BB-A1B8-4E2AA1F9FDF2>

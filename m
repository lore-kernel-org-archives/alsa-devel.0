From: "Andrew Paprocki" <andrew@ishiboo.com>
Subject: Proper way to set SCMS copy prohibited bits on IEC958
	S/PDIF
Date: Wed, 30 Jul 2008 16:37:45 -0400
Message-ID: <76366b180807301337k3776e656p3b5edc6c0d2f56a5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.251])
	by alsa0.perex.cz (Postfix) with ESMTP id 56D9D24428
	for <alsa-devel@alsa-project.org>;
	Wed, 30 Jul 2008 22:37:47 +0200 (CEST)
Received: by rv-out-0708.google.com with SMTP id f25so163545rvb.32
	for <alsa-devel@alsa-project.org>; Wed, 30 Jul 2008 13:37:45 -0700 (PDT)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I briefly checked the code for the Delta1010 (ice1712) to see if there
was a way from user space to force the SCMS copy prohibited bits on in
the S/PDIF stream. I see the driver initializes the bits to 0. Is
there already a way to do this from user space, or would I have to
modify the driver to force them on (or use a module parameter)?

Thanks,
-Andrew

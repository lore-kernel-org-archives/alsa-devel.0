From: "Lee Revell" <rlrevell@joe-job.com>
Subject: Re: Errors in application building
Date: Tue, 3 Jul 2007 14:37:48 -0400
Message-ID: <75b66ecd0707031137i4c302270oa307df11e0a6ad3@mail.gmail.com>
References: <61c0054e0707031129t28cc1421sde4d3b4ac4b6428b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qb-out-0506.google.com (qb-out-0506.google.com [72.14.204.227])
	by alsa0.perex.cz (Postfix) with ESMTP id 45BC3103812
	for <alsa-devel@alsa-project.org>;
	Tue,  3 Jul 2007 20:37:50 +0200 (CEST)
Received: by qb-out-0506.google.com with SMTP id f9so1030543qba
	for <alsa-devel@alsa-project.org>; Tue, 03 Jul 2007 11:37:49 -0700 (PDT)
In-Reply-To: <61c0054e0707031129t28cc1421sde4d3b4ac4b6428b@mail.gmail.com>
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
To: Paul Kavan <pkavan@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 7/3/07, Paul Kavan <pkavan@gmail.com> wrote:
> grhuser@pcL7:$ arm-linux-gcc -Wall -o grh_audio grh_audio.c

You need to add -lasound to the gcc command line.

Lee

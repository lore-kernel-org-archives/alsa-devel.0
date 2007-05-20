From: "Lee Revell" <rlrevell@joe-job.com>
Subject: Re: Questions on usb audio development
Date: Sun, 20 May 2007 15:25:31 -0400
Message-ID: <75b66ecd0705201225w5e6a7e28t7a61f000cd5e2352@mail.gmail.com>
References: <46506D9D.4000701@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.235])
	by alsa0.perex.cz (Postfix) with ESMTP id 39344245C9
	for <alsa-devel@alsa-project.org>;
	Sun, 20 May 2007 21:25:33 +0200 (CEST)
Received: by nz-out-0506.google.com with SMTP id l8so1737901nzf
	for <alsa-devel@alsa-project.org>; Sun, 20 May 2007 12:25:32 -0700 (PDT)
In-Reply-To: <46506D9D.4000701@gmx.net>
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
To: LCID Fire <lcid-fire@gmx.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 5/20/07, LCID Fire <lcid-fire@gmx.net> wrote:
> Hi.
> I know there is quite some documentation how to develop a pci driver for
> alsa - but since I'll try to get a usb device working I was wondering
> how to write a usb driver? Is it just the same? How to interface the
> various aspects of the device with regards to descriptor reading, ...

Look at the snd-usb-audio and usx2y sources.

Lee

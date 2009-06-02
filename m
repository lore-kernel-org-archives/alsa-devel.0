From: Ren Brian <ren.brian@gmail.com>
Subject: Re: How can i solve the alsa underrun issue
Date: Wed, 3 Jun 2009 00:15:46 +0530
Message-ID: <c0ec47240906021145i35d6e220q6b16bc6e7db0aa6d@mail.gmail.com>
References: <c0ec47240906020922r76371458r2d31a6d6f7b39a73@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.155])
	by alsa0.perex.cz (Postfix) with ESMTP id 41E1B245F1
	for <alsa-devel@alsa-project.org>;
	Tue,  2 Jun 2009 20:45:48 +0200 (CEST)
Received: by yw-out-1718.google.com with SMTP id 4so5524931ywq.2
	for <alsa-devel@alsa-project.org>; Tue, 02 Jun 2009 11:45:47 -0700 (PDT)
In-Reply-To: <c0ec47240906020922r76371458r2d31a6d6f7b39a73@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> Hi,
>
>    I'm trying to develop one application using alsa lib. The application
> receives encoded sound data from a udp socket and decodes the data and write
> it to device. Is it possible to set the buffer length for alsa?. In my
> application i have a short array of size 6000 to keep the decoded data and
> decoded data length is 5120. What period size i should set. It always set
> 940 frames. When i used the OSS calls, it works fine. When i used the alsa
> lib it gives underrun. How can i resolve this?
>
> Thanks,
> -Renju
>

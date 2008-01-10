From: "Claudio Matsuoka" <cmatsuoka@gmail.com>
Subject: Re: intel-hd on an intel G33 motherboard
Date: Thu, 10 Jan 2008 10:17:39 -0200
Message-ID: <5f52f6d70801100417h1382c2c1r3ecc9afb1b095e2b@mail.gmail.com>
References: <BAY109-W10EC413FC1F19625739A28A95B0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.183])
	by alsa0.perex.cz (Postfix) with ESMTP id DECFA24550
	for <alsa-devel@alsa-project.org>; Thu, 10 Jan 2008 13:17:41 +0100 (CET)
Received: by py-out-1112.google.com with SMTP id w49so1030894pyg.36
	for <alsa-devel@alsa-project.org>; Thu, 10 Jan 2008 04:17:40 -0800 (PST)
In-Reply-To: <BAY109-W10EC413FC1F19625739A28A95B0@phx.gbl>
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
To: De Fuuss <fuuss@hotmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Dec 26, 2007 4:42 PM, De Fuuss <fuuss@hotmail.com> wrote:

> Maybe I'm missing something, but I've failed to get even the slightest noise out of the onboard sound card from a Intel G33 motherboard. I tried the alsa drivers from the alsa-driver-1.0.15 package as well as the the alsa drivers provided by kernel 2.6.23 (built as modules), to no avail.
>
> The sound chip is identified as a Intel HDA / Realtek ALC888 on the Intel G33 ICH9 motherboard.

I'm using a Dell Inspiron 530 with a G33 chipset, and I can confirm
that the sound output isn't quite good. The Inspiron possibly needs a
specific quirk to get the 5.1 output right, and even in 2ch mode the
pin assignment is strange.

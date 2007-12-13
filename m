From: John Faith <jfaith@freescale.com>
Subject: Re: Alsa library for the arm-linux architecture
Date: Thu, 13 Dec 2007 09:58:43 -0800
Message-ID: <476172D3.6000602@freescale.com>
References: <951b8d920712130537s2f6eacb1g53121e7e1c738b0d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	by alsa0.perex.cz (Postfix) with ESMTP id 912BA246BA
	for <alsa-devel@alsa-project.org>; Thu, 13 Dec 2007 19:00:03 +0100 (CET)
In-Reply-To: <951b8d920712130537s2f6eacb1g53121e7e1c738b0d@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Felipe Uderman <felipe.uderman@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Felipe Uderman wrote:
> Hello,
> 
> I need to cross compile a project to the arm-linux platform that depends on
> the Alsa Library. My problem is that my cross development environment does
> not include the Alsa Library. I have downloaded the Alsa sources, and I
> checked that there are some instructions on how to port the library to other
> architectures. I would like to know if there are ports of the Alsa Library
> for the arm-linux architecture availible for download, or if I really have
> to cross compile it.
> 
> Thank you for your help!
> 
> Felipe
>

Hi Filipe,
We cross compile alsa-lib 1.0.11rc2 for ARM with:

./configure --prefix=/usr --host=arm-linux --build=i686-pc-linux-gnu
make
make install DESTDIR=/target/root/dir

There was only one patch we had to make, which was to remove the line 
'add_dir="-L$libdir"' (around line 2422) in alsa-lib-1.0.11rc2/ltmain.sh.

,
John

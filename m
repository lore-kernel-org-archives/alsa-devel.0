From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: 1.0.16rc2
Date: Thu, 31 Jan 2008 23:38:48 +0000
Message-ID: <20080131233848.35bb5071.pochini@shiny.it>
References: <Pine.LNX.4.61.0801291553220.11819@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out26.alice.it (smtp-out26.alice.it [85.33.2.26])
	by alsa0.perex.cz (Postfix) with ESMTP id CF1641038DE
	for <alsa-devel@alsa-project.org>; Thu, 31 Jan 2008 23:21:48 +0100 (CET)
In-Reply-To: <Pine.LNX.4.61.0801291553220.11819@tm8103.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 29 Jan 2008 15:54:54 +0100 (CET)
Jaroslav Kysela <perex@perex.cz> wrote:

> Hi,
> 
> 	1.0.16rc2 alsa-driver, alsa-lib, pyalsa packages are available for 
> download. Full changelog from 1.0.16rc1 is on:
> 
> http://www.alsa-project.org/main/index.php/Changes_v1.0.16rc1_v1.0.16rc2

I have a little compile problem. It seems that the configure
script of alsa-lib isn't able to locate the directory with the Python
headers. I have to either disable python support, or do "export
CFLAGS=-I/usr/include/python2.4".



--
Giuliano.

From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: Remove dynamic configuration from alsa-lib
Date: Sun, 8 Jul 2007 22:08:24 +0200
Message-ID: <20070708220824.2176b415.pochini@shiny.it>
References: <468A9F7E.3030806@tse.gov.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out28.alice.it (smtp-out28.alice.it [85.33.2.28])
	by alsa0.perex.cz (Postfix) with ESMTP id A8ECA103838
	for <alsa-devel@alsa-project.org>;
	Sun,  8 Jul 2007 22:10:59 +0200 (CEST)
In-Reply-To: <468A9F7E.3030806@tse.gov.br>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Fausto Carvalho Marques SIlva <fausto@tse.gov.br>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 03 Jul 2007 16:11:58 -0300
Fausto Carvalho Marques SIlva <fausto@tse.gov.br> wrote:

> I have a hard job...to remove dynamic configuration from alsa-lib 
> (conf.c,confmisc.c).
> I found it difficult because snd_conf_* functions are spread all over 
> *.c files.
> Is there am easy way of doing it ? Does anyone have some "guidelines" of 
> doing it?
> Any help is wellcome...

I haven't had a look at the code, but perhaps you can replace all the
snd_conf_* functions with copies that do nothing, so you don't have to
change all the callers.


--
Giuliano.

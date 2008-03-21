From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: Buffer management in ALSA
Date: Fri, 21 Mar 2008 00:51:31 +0000
Message-ID: <20080321005131.8169cda4.pochini@shiny.it>
References: <mailman.3514.1205879646.2095.alsa-devel@alsa-project.org>
	<010C7BAE6783F34D9AC336EE5A01A088058D4D70@dbde01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out28.alice.it (smtp-out28.alice.it [85.33.2.28])
	by alsa0.perex.cz (Postfix) with ESMTP id 87B6124420
	for <alsa-devel@alsa-project.org>; Fri, 21 Mar 2008 00:49:12 +0100 (CET)
In-Reply-To: <010C7BAE6783F34D9AC336EE5A01A088058D4D70@dbde01.ent.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 19 Mar 2008 08:36:06 +0530
"Aggarwal, Anuj" <anuj.aggarwal@ti.com> wrote:

> Hi All,
> 
> Can anyone throw some light on the buffer management part in the ALSA
> framework? How and where it is implemented? And what is expected from
> the driver, which is hooking its code to the framework?

Since each card has different requirements the driver has to manage its
buffers. Usually the driver has just to set up the buffer and the
scatter-gather list and then ALSA accesses it with no other support from
the driver. The buffer is supposed di be a "ring", ie. when the card
reaches the end of the buffer, it restarts automatically from the
beginning. If the cards needs the CPU to copy or process the data (e.g. it
doesn't support DMA), then the driver has to provide a callback function
which will be called at the end of each period.


--
Giuliano.

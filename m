From: "John Utz" <john.utz@dmx.com>
Subject: Re: how do you people debug ALSA?
Date: Tue, 22 Jan 2008 09:21:13 -0800
Message-ID: <20080122092113.206d7304@jutz-gnto64>
References: <ef33e0240801210111l569c27f4k624d9b37dd33fce8@mail.gmail.com>
	<4794BCC7.5070408@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.dmxmusic.com (mail.dmxmusic.com [199.201.237.35])
	by alsa0.perex.cz (Postfix) with ESMTP id EA988103819
	for <alsa-devel@alsa-project.org>; Tue, 22 Jan 2008 18:21:49 +0100 (CET)
In-Reply-To: <4794BCC7.5070408@freescale.com>
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

On Mon, 21 Jan 2008 09:39:51 -0600
"Timur Tabi" <timur@freescale.com> wrote:

> Mihaela Vitalariu wrote:
> > Hello everyone!
> > 
> > How do you ALSA developers debug the ALSA code?
> 
> printk().
> 

yup, gdb and printk. sound device development is relatively challenging
work

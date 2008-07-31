From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: Proper way to set SCMS copy prohibited bits on
 IEC958 S/PDIF
Date: Thu, 31 Jul 2008 02:01:40 +0200
Message-ID: <489100E4.70702@keyaccess.nl>
References: <76366b180807301337k3776e656p3b5edc6c0d2f56a5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.groni1.gr.home.nl (smtpq1.groni1.gr.home.nl
	[213.51.130.200])
	by alsa0.perex.cz (Postfix) with ESMTP id 3C20E243E3
	for <alsa-devel@alsa-project.org>;
	Thu, 31 Jul 2008 01:59:07 +0200 (CEST)
In-Reply-To: <76366b180807301337k3776e656p3b5edc6c0d2f56a5@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Andrew Paprocki <andrew@ishiboo.com>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 30-07-08 22:37, Andrew Paprocki wrote:

> I briefly checked the code for the Delta1010 (ice1712) to see if there
> was a way from user space to force the SCMS copy prohibited bits on in
> the S/PDIF stream. I see the driver initializes the bits to 0. Is
> there already a way to do this from user space, or would I have to
> modify the driver to force them on (or use a module parameter)?

I can't try this myself right now, but try "man iecset".

Rene.

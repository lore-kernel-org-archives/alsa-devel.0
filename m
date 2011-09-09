From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: Re: hdsp: 2.6.39 IRQ set-up error
Date: Fri, 09 Sep 2011 22:57:30 +0200
Message-ID: <4E6A7DBA.5030603@drcomp.erfurt.thur.de>
References: <CAPhDKbEL_VCycmsKhZJ1PvDzS+vmOr54FOCZLmo7kqk9DKBN8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ltw.loris.tv (ltw.loris.tv [85.14.220.160])
	by alsa0.perex.cz (Postfix) with ESMTP id 982CE103886
	for <alsa-devel@alsa-project.org>;
	Fri,  9 Sep 2011 22:57:40 +0200 (CEST)
In-Reply-To: <CAPhDKbEL_VCycmsKhZJ1PvDzS+vmOr54FOCZLmo7kqk9DKBN8Q@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ilya Dmitrichenko <errordeveloper@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 09/09/11 21:41, Ilya Dmitrichenko wrote:

> Hi,

Hi!

> It's rather strange that IRQ number is 0,
> I'm not too sure but I though 0 is a special
> IRQ number, isn't it?

Has it been working before? I've seen this once, in the end, it turned
out the BIOS was at fault.

Maybe switching the PCI slot could help.

> I cannot see any options that the module could take.

No, it should work out of the box.

Andre Schramm wrote:
> We had some problems with hdspm.c on 2.6.3x kernels as there was much
> work going on on the driver, maybe hdsp.c changed as well around that
> time.

No changes were made to hdsp.c.


Cheers

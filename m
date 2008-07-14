From: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [PATCH v2 1/3] ALSA SoC: Add OpenFirmware helper
	for matching bus and codec drivers
Date: Mon, 14 Jul 2008 11:22:06 -0600
Message-ID: <fa686aa40807141022y18ea2a70qa68665f310e9b505@mail.gmail.com>
References: <20080712083929.15025.47682.stgit@trillian.secretlab.ca>
	<20080714134930.GC25448@sirena.org.uk>
	<fa686aa40807141006k402b6a5fq8da1424081a20011@mail.gmail.com>
	<20080714171632.GH25448@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hs-out-0708.google.com (hs-out-0708.google.com [64.233.178.245])
	by alsa0.perex.cz (Postfix) with ESMTP id A0189243F9
	for <alsa-devel@alsa-project.org>;
	Mon, 14 Jul 2008 19:22:07 +0200 (CEST)
Received: by hs-out-0708.google.com with SMTP id x43so1156827hsb.0
	for <alsa-devel@alsa-project.org>; Mon, 14 Jul 2008 10:22:06 -0700 (PDT)
In-Reply-To: <20080714171632.GH25448@sirena.org.uk>
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
To: Grant Likely <grant.likely@secretlab.ca>, linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, liam.girdwood@wolfsonmicro.com, jonsmirl@gmail.com
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 14, 2008 at 11:16 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Mon, Jul 14, 2008 at 11:06:34AM -0600, Grant Likely wrote:
>
>> I'm okay with that.  How about fsl/mpc5200-of-machine.c for now?
>> (only the mpc5200 i2s driver uses it at the moment).  It can always be
>> renamed if other folks want to use it for other chips.
>
> That seems reasonable so long as you're happy with it, though it does
> seem to be going to the other extreme in terms of broadness :)

heh; I don't care.  This stuff is all going to be in flux anyway, so
change is inevitable whatever is chosen now.  :-)

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

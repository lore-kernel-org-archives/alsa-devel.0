From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 2/2] ASoC: wm8985: add device-tree
	support
Date: Mon, 23 May 2016 09:31:40 +0100
Message-ID: <20160523083140.GB20422@localhost.localdomain>
References: <1463489389-17719-1-git-send-email-petr@barix.com>
 <1463489389-17719-2-git-send-email-petr@barix.com>
 <20160520162128.GS1646@localhost.localdomain>
 <CAEP=dzB2527G27ym5pP2C1AxMKKeU7HMiYZ8_=48VBZdv6jxbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 7197226070F
 for <alsa-devel@alsa-project.org>; Mon, 23 May 2016 10:31:35 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CAEP=dzB2527G27ym5pP2C1AxMKKeU7HMiYZ8_=48VBZdv6jxbw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Petr Kulhavy <petr@barix.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>, Kumar Gala <galak@codeaurora.org>, Plamen Prodanov <plamen@barix.com>
List-Id: alsa-devel@alsa-project.org

On Mon, May 23, 2016 at 09:23:05AM +0200, Petr Kulhavy wrote:
> On 20 May 2016 at 18:21, Charles Keepax
> <ckeepax@opensource.wolfsonmicro.com> wrote:
> > On Tue, May 17, 2016 at 02:49:49PM +0200, Petr Kulhavy wrote:
> >> +static enum wm8985_type wm8985_data = WM8985;
> >> +static enum wm8985_type wm8758_data = WM8758;
> >> +
> >> +static const struct of_device_id wm8985_of_match[] = {
> >> +     { .compatible = "wlf,wm8985", .data = &wm8985_data},
> >> +     { .compatible = "wlf,wm8758", .data = &wm8758_data},
> >
> > You can probably just use (void *)WM8985 instead here.
> 
> I know this pretty safe with integers but can you do this with enums?
> Doesn't it lead to undefined behaviour?

Hmm... its not uncommon that it is done in the kernel, but
that is rarely an indicator of if something is actually
technically valid or not. Casting from an integer to a pointer
is technically implementation defined, but we clearly rely on
gcc's implementation in the kernel. However, without actually
reading the spec in more detail I am unclear on if an enum counts
as an integer here, my suspicion is that it would since it
generally always implicitly casts to an int.

I guess the correct fix is that .data should probably be a
kernel_ulong_t in of_device_id. But if no one else objects I am
happy for you to leave your current code as is.

Thanks,
Charles

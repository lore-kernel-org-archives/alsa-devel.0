From: Fabio Estevam <festevam@gmail.com>
Subject: Re: Request for comments for SND_SOC_IMX_WM8731
Date: Fri, 24 Oct 2014 12:56:27 -0200
Message-ID: <CAOMZO5BVBrnd-S8TbPa-j3uSXj_ZRtvED6Tq-CjtnO1U+YZxnA@mail.gmail.com>
References: <CAB-pspcgsa3-YgBfk-5TUoyfEN0pbBHtqCUrzyaQdCA-QNHt1Q@mail.gmail.com>
 <CAOMZO5AXhj-r4v-sR6Rp_ywD85M07W06r551vMq0r6juE+Tmgg@mail.gmail.com>
 <20141024140440.GG3729@sirena.org.uk>
 <CAOMZO5AJ=KehtXWvh10LTCV25gWGn2DgSLprm8bG3trVcsxHrg@mail.gmail.com>
 <CAB-pspe+NP-bvBF=wm-3EQjMw7mvzSeAEH1O-j_fen=L50mkNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f49.google.com (mail-la0-f49.google.com
 [209.85.215.49])
 by alsa0.perex.cz (Postfix) with ESMTP id 12EFB2604B1
 for <alsa-devel@alsa-project.org>; Fri, 24 Oct 2014 16:56:32 +0200 (CEST)
Received: by mail-la0-f49.google.com with SMTP id gf13so1447595lab.22
 for <alsa-devel@alsa-project.org>; Fri, 24 Oct 2014 07:56:27 -0700 (PDT)
In-Reply-To: <CAB-pspe+NP-bvBF=wm-3EQjMw7mvzSeAEH1O-j_fen=L50mkNw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jonathan Bennett <jbscience87@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>, Aaron Kling <webgeek1234@gmail.com>, Igor Grinberg <grinberg@compulab.co.il>, Valentin Raevsky <valentin@compulab.co.il>
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 24, 2014 at 12:48 PM, Jonathan Bennett
<jbscience87@gmail.com> wrote:

> All 4 clocks were in that dts as a result of tinkering with both slave and
> master mode. We are actually only using the first two. That said, I think
> you're right. I think the ones we use should be moved to the sound {} block
> of the dts. I'll get these changes fixed up and send in the next version.
>
> Oh, also, this patch is a bit big for the mailing list, what is the
> preferred method for sending in large patches to look at? I can attach,
> throw it on github, put it on an http server, etc.

Like I said previously just post the patch to the list (with
maintainers on Cc) using git send-email.

Take a look at Documentation/SubmittingPatches.

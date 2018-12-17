From: Daniel Baluta <daniel.baluta@gmail.com>
Subject: Re: [RFC 2/2] ASoC: Add MICFIL SoC Digital Audio
 Interface driver.
Date: Mon, 17 Dec 2018 16:13:44 +0200
Message-ID: <CAEnQRZA+RQDdvdtsA-ZkC1Tnr=8sP7ognNqmrnE4y+wbB2XAFA@mail.gmail.com>
References: <1544433661-32496-1-git-send-email-cosmin.samoila@nxp.com>
 <1544433661-32496-3-git-send-email-cosmin.samoila@nxp.com>
 <20181212181414.GE6920@sirena.org.uk>
 <f3a0f305-dc96-f8b9-3c57-e45256326e2f@linux.intel.com>
 <20181217121858.GB13868@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com
 [209.85.208.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 4D7852678D5
 for <alsa-devel@alsa-project.org>; Mon, 17 Dec 2018 15:13:56 +0100 (CET)
Received: by mail-ed1-f42.google.com with SMTP id d39so10823235edb.12
 for <alsa-devel@alsa-project.org>; Mon, 17 Dec 2018 06:13:56 -0800 (PST)
In-Reply-To: <20181217121858.GB13868@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "robh@kernel.org" <robh@kernel.org>, "S.j. Wang" <shengjiu.wang@nxp.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, dl-linux-imx <linux-imx@nxp.com>, Cosmin Samoila <cosmin.samoila@nxp.com>, "gabrielcsmo@gmail.com" <gabrielcsmo@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 17, 2018 at 2:19 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Fri, Dec 14, 2018 at 02:09:00PM -0600, Pierre-Louis Bossart wrote:
>
> > There's no mention of any buffer so it's likely plain vanilla VAD here.
> > We've seen two choices to warn userspace of a acoustic event, either use a
> > uevent or a kcontrol. I believe we ended-up chosing the latter on the Intel
> > side in the past and that was also the plan for SOF.
>
> It sounded like there were some separate audio streams somewhere along
> the line, it wasn't super clear if that just went into a DSP that did
> the VAD and wasn't visible to the rest of the system or if it's
> something the system can see.  Generally we have gone for kcontrols for
> event signalling.

Yes, it is plain vanilla VAD here. The MICFIL hardware IP sends an interrupt
when voice is detected.

Can you point us to some code that uses kcontrol interface to signal an event?
This might sound silly because I know there are a lot of places where kcontrol
interface is used but I  just want make sure that we are on the same page.
>
> > In terms of configurations for the PDM we have completely different settings
> > since we pass explicit coefficients while this solution passes qualifiers
> > (cut-off, quality, etc), not sure if there is any point in trying to unify
> > those parameters.
>
> Yes, I don't think the specific parameters are going to be joined up any
> time soon - it's more the overall shape of the solution.

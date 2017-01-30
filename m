From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 2/2] ASoc: Add devictree bindings for
	CS35L35 CODEC
Date: Mon, 30 Jan 2017 14:16:55 -0600
Message-ID: <20170130201655.zuozjbg5jnhwrezy@rob-hp-laptop>
References: <1485360798-15523-1-git-send-email-brian.austin@cirrus.com>
 <c3224f63-e5d1-4874-8317-c5df53d0207d@EX3.ad.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f65.google.com (mail-oi0-f65.google.com
 [209.85.218.65])
 by alsa0.perex.cz (Postfix) with ESMTP id BA069266EF9
 for <alsa-devel@alsa-project.org>; Mon, 30 Jan 2017 21:16:57 +0100 (CET)
Received: by mail-oi0-f65.google.com with SMTP id u143so26654035oif.3
 for <alsa-devel@alsa-project.org>; Mon, 30 Jan 2017 12:16:57 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <c3224f63-e5d1-4874-8317-c5df53d0207d@EX3.ad.cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Brian Austin <brian.austin@cirrus.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, lgirdwood@gmail.com, broonie@kernel.org, ckeepax@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 25, 2017 at 10:13:18AM -0600, Brian Austin wrote:
> Add devicetree bindings documentatin for
> Cirrus Logic CS35L35 Boosted Amplifier
> 
> Signed-off-by: Brian Austin <brian.austin@cirrus.com>
> ---
>  .../devicetree/bindings/sound/cs35l35.txt          | 171 +++++++++++++++++++++
>  1 file changed, 171 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/cs35l35.txt

This looks similar to the CS35L33. Please align the property names and 
perhaps combine into a single binding doc.

Rob

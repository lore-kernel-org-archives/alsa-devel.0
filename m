From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [ASoC]fsl_ssi: fix of_property_read_u32_array return value check
Date: Wed, 04 Mar 2015 14:07:21 +0100
Message-ID: <54F70389.6020004@maciej.szmigiero.name>
References: <54E1199F.3000107@maciej.szmigiero.name> <20150224082448.GY6236@finisterre.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150224082448.GY6236@finisterre.sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Li.Xiubo@freescale.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

W dniu 24.02.2015 09:24, Mark Brown pisze:
> On Sun, Feb 15, 2015 at 11:11:43PM +0100, Maciej S. Szmigiero wrote:
>> of_property_read_u32_array returns 0 on success, so the return value shouldn't be inverted twice,
>> first on assignment then in condition expression.
> 
> This doesn't apply to current code, please check and resend.  Please
> also keep your changelog under 80 columns as covered in
> SubmittingPatches.
> 

Thanks for looking into it,

Against which tree/branch patches for ASoC should be generated?

Best regards,
Maciej Szmigiero

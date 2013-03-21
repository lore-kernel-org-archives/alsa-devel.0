From: Timur Tabi <timur@tabi.org>
Subject: Re: [PATCH] Sound: sgtl5000 Allow codec clock
	frequency to be set.
Date: Wed, 20 Mar 2013 20:35:42 -0500
Message-ID: <514A63EE.7000707@tabi.org>
References: <20130319170322.27828.7691.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
 [71.74.56.122]) by alsa0.perex.cz (Postfix) with ESMTP id A7B9B2650C3
 for <alsa-devel@alsa-project.org>; Thu, 21 Mar 2013 02:35:45 +0100 (CET)
In-Reply-To: <20130319170322.27828.7691.stgit@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Martin Fuzzey <mfuzzey@parkeon.com>, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Martin Fuzzey wrote:
> +If a clock is provided, clock-frequency is optional
> +
> +If no clock is provided clock-frequency is required (this represents the codec
> +being clocked by an external signal not present in the clock tree)
> +
> +If both a clock and clock-frequency are provided the clock's rate will be set.
> +
> +
>   Example:
>
>   codec: sgtl5000@0a {
>   	compatible = "fsl,sgtl5000";
>   	reg = <0x0a>;
> +	clock-frequency = <20000000>;
> +	clocks = <&clks 162>; /* cko1 */

The code looks okay, but I'm not sure this example is right.  The binding 
says that clock-frequency is optional if 'clocks' is provided, but here 
you list both.  You should probably have two examples.

-- 
Timur Tabi

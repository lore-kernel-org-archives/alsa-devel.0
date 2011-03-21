From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: Re: ALSA issue on DA850/OMAP-L138/AM18x
Date: Mon, 21 Mar 2011 18:41:50 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC3560870370B2BAEA@dbde02.ent.ti.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59302484734E0@dbde02.ent.ti.com>
	<4D5BDA3D.5080905@acn-group.ch>
	<B85A65D85D7EB246BE421B3FB0FBB593024B83B5E4@dbde02.ent.ti.com>
	<4D749A09.8050101@acn-group.ch>
	<B85A65D85D7EB246BE421B3FB0FBB593024C0E5EC7@dbde02.ent.ti.com>
	<4D762FEB.3010003@acn-group.ch> <4D870A59.9050004@acn-group.ch>
	<FCCFB4CDC6E5564B9182F639FC3560870370B2BA32@dbde02.ent.ti.com>
	<4D874169.9010202@acn-group.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id EADD01037F8
	for <alsa-devel@alsa-project.org>; Mon, 21 Mar 2011 14:12:08 +0100 (CET)
In-Reply-To: <4D874169.9010202@acn-group.ch>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Christophe Aeschlimann <c.aeschlimann@acn-group.ch>
Cc: "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Rajashekhara, Sudhakar" <sudhakar.raj@ti.com>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On Monday, March 21, 2011 5:46 PM, Christophe Aeschlimann wrote:
[...]
> 
> The symptoms were slightly different on our custom board which
> uses a 
> TLV320AIC3107 codec :
> 
> After every cold boot the system would take ~7 seconds to
> start recording. Recording a second time just after the first
> time would behave normally (without delay).  
> 
> This delay was because the ADC (audio input) starts working
> when the volts reach 1.35V (common mode) on the ADC. But a
> 10uF series capacitor was delaying the ramp-up by 7 seconds.
> Reducing the capacitor size changed the delay to something
> more reasonable (ms range).    
> 
> This "issue" is described in the TLV320AIC3107 codec under
> "INPUT IMPEDANCE AND VCM CONTROL" the 2nd paragraph. (they
> also offer a workaround but this was not of a practical use in
> our case).   
> 

Thanks for the info.

Regards,
Vaibhav

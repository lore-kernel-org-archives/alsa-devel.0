From: John Hsu <KCHSU0@nuvoton.com>
Subject: Re: [PATCH] ASoC: nau8825: devicetree for crosstalk
	bypass
Date: Thu, 29 Jun 2017 08:08:15 +0800
Message-ID: <595444EF.3030700@nuvoton.com>
References: <1498460028-12314-1-git-send-email-KCHSU0@nuvoton.com>
 <20170628181415.gj6cc4jn47636hf6@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 37278266E02
 for <alsa-devel@alsa-project.org>; Thu, 29 Jun 2017 02:08:21 +0200 (CEST)
In-Reply-To: <20170628181415.gj6cc4jn47636hf6@sirena.org.uk>
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
Cc: AP MS30 Linux ALSA <alsa-devel@alsa-project.org>, "anatol.pomozov@gmail.com" <anatol.pomozov@gmail.com>, AC30 YHChuang <YHCHuang@nuvoton.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "benzh@chromium.org" <benzh@chromium.org>, "mac.chiang@intel.com" <mac.chiang@intel.com>, AC30 CTLin0 <CTLIN0@nuvoton.com>, "yong.zhi@intel.com" <yong.zhi@intel.com>, John Hsu <supercraig0719@gmail.com>, MS40 MHKuo <MHKuo@nuvoton.com>
List-Id: alsa-devel@alsa-project.org

On 6/29/2017 2:14 AM, Mark Brown wrote:
> On Mon, Jun 26, 2017 at 02:53:48PM +0800, John Hsu wrote:
>
>> +  - nuvoton,crosstalk-bypass: make crosstalk function bypass if set 1.
>
> This should just be a boolean property, no need for a value.

Get it. I'll change it. Thank you.


===========================================================================================
The privileged confidential information contained in this email is intended for use only by the addressees as indicated by the original sender of this email. If you are not the addressee indicated in this email or are not responsible for delivery of the email to such a person, please kindly reply to the sender indicating this fact and delete all copies of it from your computer and network server immediately. Your cooperation is highly appreciated. It is advised that any unauthorized use of confidential information of Nuvoton is strictly prohibited; and any information in this email irrelevant to the official business of Nuvoton shall be deemed as neither given nor endorsed by Nuvoton.

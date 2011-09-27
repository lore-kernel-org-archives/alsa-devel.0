From: David Pettit <David.Pettit@globalstar.com>
Subject: Re: davinci-pcm debug
Date: Tue, 27 Sep 2011 15:57:50 +0000
Message-ID: <7B4FB10C4117DC479BE74BE8181DEEC613617B11@PO1-COV.ad.corp.globalstar.com>
References: <7B4FB10C4117DC479BE74BE8181DEEC6136047E2@PO1-COV.ad.corp.globalstar.com>
	<CAPcSpELH_08HCii_7BZTpVury-DmdfGb8uVzvd80iHos_=nW5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ham.globalstar.com (ham.globalstar.com [206.220.220.92])
	by alsa0.perex.cz (Postfix) with ESMTP id C5BC524442
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Sep 2011 17:57:53 +0200 (CEST)
In-Reply-To: <CAPcSpELH_08HCii_7BZTpVury-DmdfGb8uVzvd80iHos_=nW5g@mail.gmail.com>
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
To: Ben Gardiner <bengardiner@nanometrics.ca>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tuesday, September 27, 2011 10:51 AM, Ben Gardiner [mailto:bengardiner@nanometrics.ca] wrote:
> We had also experienced strange pointer increments here when using a
> mainline version of the davinci-pcm driver. Commit
> 52e2c5d38ea6f13a19c29da7ba5183e6fac55400 'ASoC: davinci-pcm: convert
> to BATCH mode' remedied the problem for us. I recommend you give it a
> try.

Thanks, Ben.  I noticed the new commits as well.  I pulled them into my sdk's source tree and it appears to have fixed my issues.  

David Pettit

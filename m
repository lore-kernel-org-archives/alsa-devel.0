From: Dmitry Baryshkov <dbaryshkov@gmail.com>
Subject: Re: [PATCH 1/5] Permit simultaneous compilation of
 both PXA AC97 drivers
Date: Mon, 08 Sep 2008 14:19:13 +0400
Message-ID: <48C4FC21.3060107@gmail.com>
References: <20080908085339.GA31573@doriath.ww600.siemens.net>
	<1220864773-31745-1-git-send-email-dbaryshkov@gmail.com>
	<20080908093047.GA790@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.184])
	by alsa0.perex.cz (Postfix) with ESMTP id D7CC82451D
	for <alsa-devel@alsa-project.org>;
	Mon,  8 Sep 2008 12:21:59 +0200 (CEST)
Received: by nf-out-0910.google.com with SMTP id e27so565841nfd.32
	for <alsa-devel@alsa-project.org>; Mon, 08 Sep 2008 03:21:59 -0700 (PDT)
In-Reply-To: <20080908093047.GA790@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dmitry Baryshkov <dbaryshkov@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> On Mon, Sep 08, 2008 at 01:06:09PM +0400, Dmitry Baryshkov wrote:
>> Signed-off-by: Dmitry Baryshkov <dbaryshkov@gmail.com>
> 
> This change was merged some time ago - it's easier if you development
> against Takashi's tree rather than against an old kernel, especially
> given the changes going on in ASoC.  I haven't checked yet but I expect
> that some of your later changes will no longer apply with current code.

Against which tree should I develop? 
git://opensource.wolfsonmicro.com/linux-2.6-asoc ?

-- 
With best wishes
Dmitry

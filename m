From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH 1/3] ASoC: wm8741: Add digital mute callback
Date: Wed, 6 Sep 2017 09:19:01 +0100
Message-ID: <20170906081901.3yfkkxppz62tz4qu@localhost.localdomain>
References: <1504553653-8144-1-git-send-email-sergej@taudac.com>
 <1504553653-8144-2-git-send-email-sergej@taudac.com>
 <20170905133351.tfqsa6s33aeigfxy@localhost.localdomain>
 <2fae023a-25cc-01cf-2972-312dd7f48e43@taudac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id D1CAD266DD6
 for <alsa-devel@alsa-project.org>; Wed,  6 Sep 2017 10:19:06 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <2fae023a-25cc-01cf-2972-312dd7f48e43@taudac.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sergej Sawazki <sergej@taudac.com>
Cc: ce3a@gmx.de, patches@opensource.cirrus.com, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 05, 2017 at 08:15:05PM +0200, Sergej Sawazki wrote:
> Thanks Charles,
> 
> agreed about the __func__. But, I would like to keep the debug message, in
> order to be consistent with the other callbacks. They all print debug
> messages.
> 
> Would it be ok for you?
> 

I am ok with leaving the print, if we update the message.

Thanks,
Charles

From: Nenghua Cao <nhcao@marvell.com>
Subject: Re: [PATCH] ASOC:DAPM: extend dapm kcontrol to support
 runtime route update
Date: Fri, 13 Dec 2013 20:11:55 +0800
Message-ID: <52AAF98B.2060108@marvell.com>
References: <1386835619-18070-1-git-send-email-nhcao@marvell.com>
 <20131212104347.GH11044@sirena.org.uk>
 <F766E4F80769BD478052FB6533FA745D4E76B8FA79@SC-VEXCH4.marvell.com>
 <20131212110718.GI11044@sirena.org.uk> <52AAF09A.40302@marvell.com>
 <s5hy53phthr.wl%tiwai@suse.de> <20131213114215.GW11044@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by alsa0.perex.cz (Postfix) with ESMTP id 282682616C9
 for <alsa-devel@alsa-project.org>; Fri, 13 Dec 2013 13:06:18 +0100 (CET)
In-Reply-To: <20131213114215.GW11044@sirena.org.uk>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Henry Zhao <xzhao10@marvell.com>, Yacine Belkadi <yacine.belkadi.1@gmail.com>, Chao Xie <cxie4@marvell.com>
List-Id: alsa-devel@alsa-project.org

Hi, Takashi and Mark:

On 12/13/2013 07:42 PM, Mark Brown wrote:
> On Fri, Dec 13, 2013 at 12:37:20PM +0100, Takashi Iwai wrote:
> 
>> > Usually backward compatibility is concerned when something new breaks
>> > the existing ones.  In your case, always updating DPCM would work,
>> > too, even without an extra flag; it's just suboptimal.
> Right, and if we have separate versions then at some point we'll end up
> having to define DPCM versions of everything which is going to get
> tedious and error prone.

According to your suggestion, i removed the flag, and updated the patch.
Please review it again.

Thanks
